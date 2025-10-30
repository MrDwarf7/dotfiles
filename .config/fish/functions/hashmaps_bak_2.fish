#!/usr/bin/env fish
#

# Global separator for nested maps (unit separator \x1f)
set -g HASHMAP_SEP (printf "\x1f")

# Number of buckets (power of 2 recommended; adjust for map size)
set -g HASHMAP_BUCKETS 16

# Helper to compute hash index for a key (0 to BUCKETS-1)
# Uses cksum for hashing; fallback to dumb hash if cksum fails
function _hash_key -a key
    set -l hash (echo -n $key | cksum 2>/dev/null | awk '{print $1}')
    if test -z "$hash"
        # Fallback: simple char sum % buckets (weak but works without external)
        set hash 0
        for char in (string split '' $key)
            set hash (math $hash + (printf '%d' "'$char") )
        end
        set hash (math $hash % $HASHMAP_BUCKETS)
    else
        set hash (math $hash % $HASHMAP_BUCKETS)
    end
    echo $hash
end

# Helper to clean a string by stripping outer quotes if present.
function _strip_quotes -a str
    string replace -r "^['\"](.*)['\"]\$" '$1' $str
end

# Internal: Scatter pairs into hashed buckets
# Usage: _scatter_to_buckets $pairs
# Sets global hashmap_bucket_* variables
function _scatter_to_buckets
    # Clear existing buckets
    for i in (seq 0 (math $HASHMAP_BUCKETS - 1))
        set -e "hashmap_bucket_$i"
    end

    for pair in $argv
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2
            set -l key $kv[1]
            set -l bucket_idx (_hash_key $key)
            set -a "hashmap_bucket_$bucket_idx" $pair
        end
    end
end

# Internal: Gather all pairs from buckets into a sorted list (by bucket for determinism)
# Usage: set pairs (_gather_from_buckets)
function _gather_from_buckets
    set -l all_pairs
    for i in (seq 0 (math $HASHMAP_BUCKETS - 1))
        if set -q "hashmap_bucket_$i"[1]
            set -a all_pairs $$"hashmap_bucket_$i"
        end
    end
    printf "%s\n" $all_pairs
end

# Create a new hashmap from a string representation.
# Outputs one cleaned "key : value" per line.
function hashmaps.new
    set -l input (string join ' ' $argv)
    set input (string replace -r '^\{\s*' '' $input)
    set input (string replace -r '\s*\}$' '' $input)
    # Split on , to get pairs
    set -l pair_strs (string split ',' $input | string trim)
    # Parse each pair into cleaned key : value
    set -l pairs
    for p in $pair_strs
        # Split on first :, trim parts
        set -l kv (string split -m 1 ':' $p | string trim)
        if test (count $kv) -eq 2
            # Strip outer quotes on each
            set -l clean_k (_strip_quotes $kv[1])
            set -l clean_v (_strip_quotes $kv[2])
            # Reconstruct with ' : '
            set -a pairs "$clean_k : $clean_v"
        end
    end
    if test (count $pairs) -gt 0
        _scatter_to_buckets $pairs
        _gather_from_buckets # Output the flat list
        # printf "%s" $pairs
    else
        return 1
    end
end

# Set a key-value in the hashmap.
# Usage: set MAP (hashmaps set <key> <value> $MAP)
# Outputs the updated pairs, one per line.
function hashmaps.set -a key value
    set -l map $argv[3..-1]
    _scatter_to_buckets $map # Load into buckets

    set -l bucket_idx (_hash_key $key)
    set -l bucket_var "hashmap_bucket_$bucket_idx"
    set -l found 0
    set -l new_bucket
    for pair in $$bucket_var
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2 -a "$kv[1]" = "$key"
            set -a new_bucket "$key : $value"
            set found 1
        else
            set -a new_bucket $pair
        end
    end
    if test $found -eq 0
        set -a new_bucket "$key : $value"
    end
    if test -n "$bucket_var"
        set $bucket_var $new_bucket
    else
        return 1
    end
    _gather_from_buckets # Output updated flat list
end

# Get the pair for a key from the hashmap as two lines: key\nvalue
# Usage: set pair (hashmaps get <key> $MAP)
function hashmaps.get -a key
    set -l map $argv[2..-1]
    _scatter_to_buckets $map # Load into buckets

    set -l bucket_idx (_hash_key $key)
    set -l bucket_var "hashmap_bucket_$bucket_idx"
    for pair in $$bucket_var
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2 -a "$kv[1]" = "$key"
            printf "%s\n%s\n" $kv[1] $kv[2]
            return 0
        end
    end
    return 1
end

# Nest a submap under a key in the parent hashmap.
# Usage: set MAP (hashmaps nest <key> $SUBMAP -- $PARENTMAP)
# Joins the submap pairs with $HASHMAP_SEP and sets as the value.
# Outputs the updated pairs, one per line.
function hashmaps.nest -a key
    set -l sep_idx
    for i in (seq 2 (count $argv))
        if test $argv[$i] = --
            set sep_idx $i
            break
        end
    end
    if not set -q sep_idx[1]
        printf "Usage: hashmaps nest <key> \$SUBMAP -- \$PARENTMAP\n" >&2
        return 1
    end
    set -l submap $argv[2..(math $sep_idx - 1)]
    set -l parent $argv[(math $sep_idx + 1)..-1]
    # Join submap with sep
    set -l joined_value (string join $HASHMAP_SEP $submap)
    # Use set to add/update
    hashmaps.set $key $joined_value $parent
end

# Recursive deep get for nested keys.
# Usage: set pair (hashmaps deep_get <key.path> $MAP)
# key.path like "outer.inner.rust"
# Returns key\nvalue on success (last key and its value), or nothing and status 1 if not found.
# Handles recursion by calling itself on submaps.
function hashmaps.deep_get -a key_path
    set -l map $argv[2..-1]
    _scatter_to_buckets $map # Load into buckets

    # Split key_path on .
    set -l keys (string split '.' $key_path)
    set -l current_key $keys[1]
    set -l remaining_path (string join '.' $keys[2..-1])

    set -l bucket_idx (_hash_key $current_key)
    set -l bucket_var "hashmap_bucket_$bucket_idx"

    # Find the pair for current_key
    for pair in $$bucket_var
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2 -a "$kv[1]" = "$current_key"
            set -l value $kv[2]
            if test -n "$remaining_path"
                # If remaining path, check if value is nested (contains sep)
                if string match -q "*$HASHMAP_SEP*" $value
                    # Extract submap and recurse
                    set -l submap (string split $HASHMAP_SEP $value)
                    # Recurse
                    set -l sub_result (hashmaps.deep_get $remaining_path $submap)
                    if test $status -eq 0
                        printf "%s" $sub_result
                        return 0
                    end
                else
                    # Not nested, but path remains: not found
                    return 1
                end
            else
                # No remaining path: found
                printf "%s\n%s\n" $current_key $value
                return 0
            end
        end
    end
    return 1
end

# Check if a key (or deep key.path) exists in the hashmap.
# Usage: hashmaps has <key.path> $MAP
# Returns status 0 if exists, 1 otherwise. No output.
function hashmaps.has -a key_path
    set -l map $argv[2..-1]
    _scatter_to_buckets $map # Load into buckets

    # Similar to deep_get, but just check existence, recursive.
    set -l keys (string split '.' $key_path)
    set -l current_key $keys[1]
    set -l remaining_path (string join '.' $keys[2..-1])

    set -l bucket_idx (_hash_key $current_key)
    set -l bucket_var "hashmap_bucket_$bucket_idx"

    for pair in $map
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2 -a "$kv[1]" = "$current_key"
            if test -n "$remaining_path"
                set -l value $kv[2]
                if string match -q "*$HASHMAP_SEP*" $value
                    set -l submap (string split $HASHMAP_SEP $value)
                    hashmaps.has $remaining_path $submap
                    return $status
                else
                    return 1
                end
            else
                return 0
            end
        end
    end
    return 1
end

# ... (nest, deep_get, has, extract, dispatcher remain the same, but update calls to get/set to scatter/gather as needed.
# For deep_get/has, recurse with scattering if performance matters, but for simplicity, keep linear in submaps since small.)

# Extract a nested submap from a joined value.
# Usage: set SUBMAP (hashmaps extract $joined_value)
# Splits on $HASHMAP_SEP to get back the list of pairs.
function hashmaps.extract -a joined
    string split $HASHMAP_SEP $joined
end

# To clean up buckets (optional, call after done with map)
function hashmaps.destroy
    for i in (seq 0 (math $HASHMAP_BUCKETS - 1))
        set -e "hashmap_bucket_$i"
    end
end

# Dispatcher function.
# Usage: hashmaps <cmd> <args...>
# cmds: new, set, get, nest, deep_get, has
# Note: get is now alias to deep_get for compatibility, but deep_get supports paths.
function hashmaps
    set -l cmd $argv[1]
    set -l args $argv[2..-1]

    switch $cmd
        case new
            hashmaps.new $args

        case set
            if test (count $args) -lt 2
                printf "Usage: hashmaps set <key> <value> \$MAP\n" >&2
                return 1
            end
            hashmaps.set $args[1] $args[2] $args[3..-1]

        case get
            # Alias to deep_get
            if test (count $args) -lt 1
                printf "Usage: hashmaps get <key.path> \$MAP\n" >&2
                return 1
            end
            hashmaps.deep_get $args[1] $args[2..-1]

        case nest
            if test (count $args) -lt 3
                printf "Usage: hashmaps nest <key> \$SUBMAP -- \$MAP\n" >&2
                return 1
            end
            hashmaps.nest $args

        case deep_get
            if test (count $args) -lt 1
                printf "Usage: hashmaps deep_get <key.path> \$MAP\n" >&2
                return 1
            end
            hashmaps.deep_get $args[1] $args[2..-1]

        case has
            if test (count $args) -lt 1
                printf "Usage: hashmaps has <key.path> \$MAP\n" >&2
                return 1
            end
            hashmaps.has $args[1] $args[2..-1]
            return $status # Pass through status

        case extract
            if test (count $args) -lt 1
                printf "Usage: hashmaps extract <joined_value>\n" >&2
            end
            hashmaps.extract $args[1]

        case destroy
            if test (count $args) -ne 0
                printf "Usage: hashmaps destroy\n" >&2
            end
            hashmaps.destroy

        case '*'
            printf "Unknown command: %s\n" $cmd >&2
            return 1
    end
end
