#!/usr/bin/env fish
#

# set -g TEST {
# 	"rust": "rs",
# 	"python": "py",
# 	"typescript": "ts",
# }

## now just trying to get only 'rust' items -----
#
#                         K
#  ❯ set -l t (echo $TEST[1] | string trim | string split ':' | string trim | string collect | string split '\n')
#
# without the split + second trim we get this:
# - K: V
#
# with only the split, but no second trim we get this:
# - K  V
#
# note the extra space, hmmm
#
# we need the second trim as fish treats every element in the array
# as a single item, therefore we have to call trim to remove the space that's a 'part' of the 'rs' (or rather ' rs' )
# after, we get this:
# K V
#
#          K V
#  ❯ echo $t
# rust
#
#            K
#  ❯ echo $t[1]
# rust
#
#         K V
#  ❯ echo $t
# rust rs
#
#            K
#  ❮ echo $t[1]
# rust
#
#            V
#  ❯ echo $t[2]
# rs

# set -l TEST { "rust": "rs", "python": "py" }

# check if we have both '{' and '}'
# these will repr:
# set -l T "{ "rust": "rs", "python": "py" }"
#
# and
#
# set -l T { "rust": "rs", "python": "py" }
#
# respectively

# Helper to clean a string by stripping outer quotes if present.
function _strip_quotes -a str
    string replace -r "^['\"](.*)['\"]\$" '$1' $str
end

# Global separator for nested maps (unit separator \x1f)
set -g HASHMAP_SEP (printf "\x1f")

# Create a new hashmap from a string representation.
# Usage: set MAP (hashmaps new '{ rust : rs, python : py, typescript : ts }')
# or with quotes if spaces: '{ "key space" : "val : ue" }'
# Handles optional quotes around keys/values, variable spaces around :, outer {}.
# Outputs one cleaned "key : value" per line (with single spaces around :).
function hashmaps.new
    set -l input (string join ' ' $argv)
    # Strip outer {} if present
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
    # Output as lines if any
    if test (count $pairs) -gt 0
        printf "%s\n" $pairs
    else
        return 1
    end
end

# Set a key-value in the hashmap.
# Usage: set MAP (hashmaps set <key> <value> $MAP)
# Outputs the updated pairs, one per line.
# Handles update or add; preserves order.
function hashmaps.set -a key value
    set -l map $argv[3..-1]
    set -l new_map
    set -l found 0
    for pair in $map
        set -l kv (string split -m 1 ':' $pair | string trim)
        if test (count $kv) -eq 2 -a "$kv[1]" = "$key"
            set -a new_map "$key : $value"
            set found 1
        else
            set -a new_map $pair
        end
    end
    if test $found -eq 0
        set -a new_map "$key : $value"
    end
    # Output as lines
    printf "%s\n" $new_map
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
    # Split key_path on .
    set -l keys (string split '.' $key_path)
    set -l current_key $keys[1]
    set -l remaining_path (string join '.' $keys[2..-1])

    # Find the pair for current_key
    for pair in $map
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
    # Similar to deep_get, but just check existence, recursive.
    set -l keys (string split '.' $key_path)
    set -l current_key $keys[1]
    set -l remaining_path (string join '.' $keys[2..-1])

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

# Extract a nested submap from a joined value.
# Usage: set SUBMAP (hashmaps extract $joined_value)
# Splits on $HASHMAP_SEP to get back the list of pairs.
function hashmaps.extract -a joined
    string split $HASHMAP_SEP $joined
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

        case '*'
            printf "Unknown command: %s\n" $cmd >&2
            return 1
    end
end
