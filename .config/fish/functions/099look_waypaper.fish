#!/usr/bin/env fish
#

set -g waypaper_fill_method fill # fill | stretch | fit | center | tile
set -g DEBUG_MODE 0

# set -g first_mon
# set -g second_mon

function cleanup
    if not test -z (set -s | grep -E '^output_buffer')
        printf "Cleaning up output buffer variable: %s" "$output_buffer"
        set -e output_buffer
    end

    if not test -z (set -s | grep -E '^waypaper_fill_method')
        printf "Cleaning up waypaper_fill_method variable: %s" "$waypaper_fill_method"
        set -e waypaper_fill_method
    end

    return 0
end

function pprint
    if test $DEBUG_MODE -eq 1
        printf $argv
    end
end

function set_waypaper
    set path $argv[1]
    set monitor $argv[2]

    if not 090test_path $path
        return 1
    end

    if not 090test_cmd waypaper
        return 1
    end

    command waypaper --backend awww --fill $waypaper_fill_method --monitor $monitor --wallpaper $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallpaper for %s: %s\n" $monitor (cat $output_buffer)
        return 1
    end
end

function waypaper_extractor
    set index $argv[1]
    set field $argv[2]
    # set store_in $argv[3]

    set -l fmt_field (printf '.[%d].%s' $index $field)
    set -l result (waypaper --list | jq -r $fmt_field)

    if test -z "$result"
        printf "Failed to extract %s for index %d\n" $field $index
        return 1
    end

    # set -g $store_in $result
    printf "%s" $result

    return 0

end

function jq_extract
    set base_regex '[._A-Za-z0-9~/-]'
    set field $argv[1]
    set lhs $argv[2]
    set rhs $argv[3]

    set regex "\"(?<$lhs>$base_regex+),(?<$rhs>$base_regex+)\""
    set jq_comp ".[].$field | capture($regex)"

    set data (waypaper --list | jq -r $jq_comp)

    if test -z "$data"
        printf "Failed to extract [ $data ] via use of [ $field ] from waypaper list.\n"
        return 1
    end

    printf "%s" $data

    return 0

end

function 099look_waypaper --description 'Call waypaper for wallust'
    set path_one $argv[1]
    set path_two $argv[2]

    # Get the monitors from waypaper (DP-1, HDMI-A-2, etc.)

    # waypaper_extractor 0 monitor (string collect "first_mon")
    # pprint "MAIN :: First monitor extracted: %s\n" $first_mon

    # if test (string match -r '.*,.*' $first_mon)
    #     waypaper_extractor 1 monitor (string collect "second_mon")
    #     pprint "MAIN :: Second monitor extracted: %s\n" $second_mon
    # end

    # set first_mon (waypaper_extractor 0 monitor)
    # set second_mon (waypaper_extractor 1 monitor)

    # pprint "MAIN :: FIRST %s\n" $first_mon
    # pprint "MAIN :: SECOND %s\n" $second_mon

    set mons (jq_extract monitor a b)
    pprint "MAIN :: MONS %s\n" $mons

    set first_mon (printf "%s" $mons | jq -r '.a')
    set second_mon (printf "%s" $mons | jq -r '.b')

    pprint "MAIN :: FIRST JQ %s\n" $first_mon
    pprint "MAIN :: SECOND JQ %s\n" $second_mon

    ###########################################################################

    # Get the existing wallpapers for each monitor

    # set first_mon_wallpaper (waypaper_extractor 0 wallpaper)
    # set second_mon_wallpaper (waypaper_extractor 1 wallpaper)

    set walls (jq_extract wallpaper a b)
    pprint "MAIN :: WALLS %s\n" $walls

    set first_mon_wallpaper (printf "%s" $walls | jq -r '.a')
    set second_mon_wallpaper (printf "%s" $walls | jq -r '.b')

    pprint "MAIN :: FIRST WALLPAPER %s\n" $first_mon_wallpaper
    pprint "MAIN :: SECOND WALLPAPER %s\n" $second_mon_wallpaper

    ###########################################################################

    #
    #
    #
    #
    #

    set -g output_buffer (mktemp /tmp/wa.XXXXXXXXXX)

    # First checks on the $argv[1] and $argv[2] to see if they are set
    # If not, we use existign wallpapers ||&& only update wallust's colors
    if test -z "$path_one" -a -z "$path_two"
        printf "No wallpapers provided, using existing wallpapers.\n"
        set path_one $first_mon_wallpaper
        set path_two $second_mon_wallpaper
    end

    pprint "Output buffer set to: %s\n" $output_buffer
    pprint "Waypaper fill method set to: %s\n" $waypaper_fill_method
    pprint "Wallpaper for first monitor: %s\n" $path_one
    pprint "Wallpaper for second monitor: %s\n" $path_two
    pprint "\n"

    # First we will do a check, user may only want to update wallust's colors if
    # the supplied wallpaper is nothing/empty or the same as the current wallpaper
    if test -z "$path_one" -o "$path_one" = "$first_mon_wallpaper"
        set path_one $first_mon_wallpaper
    end
    pprint "Path one after check: %s\n" $path_one

    # If the second wallpaper is not set, we will use the first wallpaper
    # Shift vs. Same
    if test -z "$path_two"
        set path_two $second_mon_wallpaper # Keep all the same
        # set path_two $first_mon_wallpaper # This will effectively 'shift' the first wallpaper to the second monitor
        # set path_two $path_one # This would make it the same across both monitors
    end
    pprint "Path two after check: %s\n" $path_two

    if not test (string match "$path_one" "$first_mon_wallpaper")
        pprint "Setting wallpaper for first monitor: %s on %s\n" $path_one $first_mon
        set_waypaper $path_one $first_mon || return $status
    end
    # Similarly for second

    if not test (string match "$path_two" "$second_mon_wallpaper")
        pprint "Setting wallpaper for second monitor: %s on %s\n" $path_two $second_mon
        set_waypaper $path_two $second_mon || return $status
    end

    # Call wallust to update colors
    if not 099look_wallust $path_one
        printf "Failed to set wallust colors for %s\n" $path_one
        return 1
    end
    command hyprctl reload >/dev/null || return $status

    # print "Wallpapers set and wallust colors updated successfully.\n"
    # print "You can view the output buffer at: %s\n" $output_buffer

    cleanup || return $status

    return $status
end
