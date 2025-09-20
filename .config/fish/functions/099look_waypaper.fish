#!/usr/bin/env fish

set -g waypaper_fill_method fit # fill | stretch | fit | center | tile
set -g DEBUG_MODE 0

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

    command waypaper --backend swww --fill $waypaper_fill_method --monitor $monitor --wallpaper $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallpaper for %s: %s\n" $monitor (cat $output_buffer)
        return 1
    end
end

function 099look_waypaper --description 'Call waypaper for wallust'
    set path_one $argv[1]
    set path_two $argv[2]

    # Get the monitors from waypaper (DP-1, HDMI-A-2, etc.)
    set first_mon (waypaper --list | jq -r '.[0].monitor')
    set second_mon (waypaper --list | jq -r '.[1].monitor')

    pprint "First monitor: %s\n" $first_mon || return $status
    pprint "Second monitor: %s\n" $second_mon

    # Get the existing wallpapers for each monitor
    set first_mon_wallpaper (waypaper --list | jq -r '.[0].wallpaper')
    set second_mon_wallpaper (waypaper --list | jq -r '.[1].wallpaper')

    pprint "Current wallpaper for %s: %s\n" $first_mon $first_mon_wallpaper
    pprint "Current wallpaper for %s: %s\n" $second_mon $second_mon_wallpaper

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
