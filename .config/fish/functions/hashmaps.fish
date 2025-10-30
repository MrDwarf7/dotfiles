#!/usr/bin/env fish
#

function hashmaps_new
    if test (count $argv) -eq 0
        return 0
    end
    set -l input (string join ' ' -- $argv)
    set input (string replace -a -r '\s*:\s*' ':' -- $input)
    set input (string replace -a -r '\s*,\s*' ',' -- $input)
    set input (string replace -r '^\s*\{\s*' '' -- $input)
    set input (string replace -r '\s*\}\s*$' '' -- $input)
    set -l pairs (string split ',' -- $input)
    set -l keys
    set -l values
    for p in $pairs
        set -l pair (string trim -- $p)
        if test -z "$pair"
            continue
        end
        set -l kv (string split -m 1 ':' -- $pair)
        if test (count $kv) -ne 2
            printf "Invalid pair: %s\n" $pair
            return 1
        end
        set -l key (string trim -- $kv[1])
        set -l val (string trim -- $kv[2])
        set -a keys $key
        set -a values $val
    end
    set -l hashes
    set -l hash_pairs
    for j in (seq (count $keys))
        set -l key $keys[$j]
        set -l value $values[$j]
        set -l pair "$key:$value"
        set -l hash (printf "%s" "$key" | cksum | cut -d ' ' -f1)
        set -a hashes $hash
        set -a hash_pairs $pair
    end
    set -l n (count $hashes)
    for i in (seq 1 (math $n - 1))
        for j in (seq 1 (math $n - $i))
            if test $hashes[$j] -gt $hashes[(math $j + 1)]
                set -l temp_hash $hashes[$j]
                set hashes[$j] $hashes[(math $j + 1)]
                set hashes[(math $j + 1)] $temp_hash
                set -l temp_pair $hash_pairs[$j]
                set hash_pairs[$j] $hash_pairs[(math $j + 1)]
                set hash_pairs[(math $j + 1)] $temp_pair
            end
        end
    end
    for p in $hash_pairs
        printf "%s\n" $p
    end
end

function hashmaps_get
    set -l key $argv[1]
    set -l map $argv[2..]
    set -l target_hash (printf "%s" "$key" | cksum | cut -d ' ' -f1)
    set -l low 1
    set -l high (count $map)
    set -l pos (math $high + 1)
    while test $low -le $high
        set -l mid (math floor "($low + $high) / 2")
        set -l entry $map[$mid]
        set -l entry_key (string split -m 1 -f 1 ':' $entry)
        set -l hash_mid (printf "%s" "$entry_key" | cksum | cut -d ' ' -f1)
        if test $hash_mid -lt $target_hash
            set low (math $mid + 1)
        else
            set pos $mid
            set high (math $mid - 1)
        end
    end
    set -l i $pos
    while test $i -le (count $map)
        set -l entry $map[$i]
        set -l entry_key (string split -m 1 -f 1 ':' $entry)
        set -l hash_i (printf "%s" "$entry_key" | cksum | cut -d ' ' -f1)
        if test $hash_i -gt $target_hash
            break
        end
        if test "$entry_key" = "$key"
            set -l value (string split -m 1 -f 2 ':' $entry)
            printf "%s\n" $entry_key
            printf "%s\n" $value
            return 0
        end
        set i (math $i + 1)
    end
    return 1
end

function hashmaps_set
    set -l key $argv[1]
    set -l value $argv[2]
    set -l map $argv[3..]
    set -l target_hash (printf "%s" "$key" | cksum | cut -d ' ' -f1)
    set -l low 1
    set -l high (count $map)
    set -l pos (math $high + 1)
    while test $low -le $high
        set -l mid (math floor "($low + $high) / 2")
        set -l entry $map[$mid]
        set -l entry_key (string split -m 1 -f 1 ':' $entry)
        set -l hash_mid (printf "%s" "$entry_key" | cksum | cut -d ' ' -f1)
        if test $hash_mid -lt $target_hash
            set low (math $mid + 1)
        else
            set pos $mid
            set high (math $mid - 1)
        end
    end
    set -l i $pos
    set -l found false
    while test $i -le (count $map)
        set -l entry $map[$i]
        set -l entry_key (string split -m 1 -f 1 ':' $entry)
        set -l hash_i (printf "%s" "$entry_key" | cksum | cut -d ' ' -f1)
        if test $hash_i -gt $target_hash
            break
        end
        if test "$entry_key" = "$key"
            set -l new_entry "$key:$value"
            set map[$i] $new_entry
            set found true
            break
        end
        set i (math $i + 1)
    end
    if $found
        for m in $map
            printf "%s\n" $m
        end
        return 0
    end
    set -l new_entry "$key:$value"
    set -l start (math $pos - 1)
    set -l new_map
    if test $start -ge 1
        set new_map $map[1..$start]
    end
    set -a new_map $new_entry
    set -a new_map $map[$pos..]
    for m in $new_map
        printf "%s\n" $m
    end
end

function hashmaps
    set -l sub $argv[1]
    switch $sub
        case new
            hashmaps_new $argv[2..]
        case get
            hashmaps_get $argv[2..]
        case set
            hashmaps_set $argv[2..]
        case '*'
            printf "Unknown command\n"
    end
end
