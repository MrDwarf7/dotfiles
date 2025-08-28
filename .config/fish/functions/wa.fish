#!/usr/bin/env fish

set waypaper_fill_method fill # fill | stretch | fit | center | tile

function cleanup
    if not test -z (set -s | grep -E '^output_buffer')
        echo "Cleaning up output buffer variable: $output_buffer"
        set -e output_buffer
    end

    if not test -z (set -s | grep -E '^waypaper_fill_method')
        echo "Cleaning up waypaper_fill_method variable: $waypaper_fill_method"
        set -e waypaper_fill_method
    end

    return 0
end

# Helper function to handled repeated code
function test_path
    set path $argv[1]

    if not test -f $path
        printf "File does not exist: %s\n" $path
        return 1
    end
    return 0
end

# Helper function to handled repeated code
function test_command
    set cmd $argv[1]

    if not command -v $cmd >/dev/null
        printf "%s is not installed\n" $cmd
        return 1
    end

    return 0
end

function set_wallust
    set path $argv[1]

    if not test_path $path
        return 1
    end

    if not test_command wallust
        return 1
    end

    command wallust run -s $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallust colors: %s\n" (cat $output_buffer)
        return 1
    end

    return $status
end

function set_waypaper
    set path $argv[1]
    set monitor $argv[2]

    if not test_path $path
        return 1
    end

    if not test_command waypaper
        return 1
    end

    command waypaper --backend swww --fill $waypaper_fill_method --monitor $monitor --wallpaper $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallpaper for %s: %s\n" $monitor (cat $output_buffer)
        return 1
    end
end

function wa --description 'Call waypaper for wallust'
    set path_one $argv[1]
    set path_two $argv[2]

    # Get the monitors from waypaper (DP-1, HDMI-A-2, etc.)
    set first_mon (waypaper --list | jq -r '.[0].monitor')
    set second_mon (waypaper --list | jq -r '.[1].monitor')

    # Get the existing wallpapers for each monitor
    set first_mon_wallpaper (waypaper --list | jq -r '.[0].wallpaper')
    set second_mon_wallpaper (waypaper --list | jq -r '.[1].wallpaper')

    set -g output_buffer (mktemp /tmp/wa.XXXXXXXXXX)

    # First checks on the $argv[1] and $argv[2] to see if they are set
    # If not, we use existign wallpapers ||&& only update wallust's colors
    if test -z "$path_one" -a -z "$path_two"
        printf "No wallpapers provided, using existing wallpapers.\n"
        set path_one $first_mon_wallpaper
        set path_two $second_mon_wallpaper
    end

    # First we will do a check, user may only want to update wallust's colors if
    # the supplied wallpaper is nothing/empty or the same as the current wallpaper
    if test -z "$path_one" -o "$path_one" = "$first_mon_wallpaper"
        set path_one $first_mon_wallpaper
    end

    # If the second wallpaper is not set, we will use the first wallpaper
    # Shift vs. Same
    if test -z "$path_two"
        set path_two $second_mon_wallpaper # Keep all the same
        # set path_two $first_mon_wallpaper # This will effectively 'shift' the first wallpaper to the second monitor
        # set path_two $path_one # This would make it the same across both monitors
    end

    if not test (string match "$path_one" "$first_mon_wallpaper")
        set_waypaper $path_one $first_mon || return $status
    end
    # Similarly for second

    if not test (string match "$path_two" "$second_mon_wallpaper")
        set_waypaper $path_two $second_mon || return $status
    end

    # Call wallust to update colors
    if not set_wallust $path_one
        printf "Failed to set wallust colors for %s\n" $path_one
        return 1
    end
    command hyprctl reload >/dev/null || return $status

    printf "Wallpapers set and wallust colors updated successfully.\n"
    printf "You can view the output buffer at: %s\n" $output_buffer

    cleanup || return $status

    return $status
end
