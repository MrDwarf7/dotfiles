#!/usr/bin/env fish
#

# awww \
# img -o DP-1 \
# --transition-bezier ".1,.4,.97,.82" \
# --transition-fps 70 \
# --resize fit /home/dwarf/Pictures/wallpapers/wallhaven-mdjrqy.jpg

set -g bezier ".1,.4,.97,.82"
set -g fill_method fit # crop | fit | no | stretch
set -g DEBUG_MODE 0

function cleanup
    if not test -z (set -s | grep -E '^output_buffer')
        printf "Cleaning up output buffer variable: %s" "$output_buffer"
        set -e output_buffer
    end

    if not test -z (set -s | grep -E '^bezier')
        printf "Cleaning up bezier variable: %s" "$bezier"
        set -e bezier
    end

    return 0
end

function pprint
    if test $DEBUG_MODE -eq 1
        printf $argv
    end
end

function set_awww
    set path $argv[1]
    set monitor $argv[2]

    if not 90-test_path $path
        return 1
    end

    if not 90-test_cmd awww
        return 1
    end

    pprint "Setting wallpaper for %s to %s\n" $monitor $path

    command awww img -o $monitor --transition-bezier "$bezier" --transition-fps 70 --resize $fill_method $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallpaper for %s: %s\n" $monitor (cat $output_buffer)
        return 1
    end

end

function 99-look_awww --description 'Call awww for wallust'
    set path_one $argv[1]
    set path_two $argv[2]

    pprint "Value of path_one: %s\n" $path_one
    pprint "Value of path_two: %s\n" $path_two

    # : DP-1: 5120x1440, scale: 1, currently displaying: image: /home/dwarf/Pictures/wallpapers/wallhaven-mdjrqy.jpg
    # : HDMI-A-2: 1920x1080, scale: 1, currently displaying: image: /home/dwarf/Pictures/wallpapers/wallhaven-zp8m8o.jpg

    # we need the DP-1 part, and the HDMI-A-2 part
    # %s/\v^:\s([.-:]*\w+[-_]+)(\d+)?/\1\2/g
    set data (awww query | sed -n 's/^: \([^:]*\):.*/\1/p' | string join ' ')
    set first_mon (echo $data | awk '{print $1}')
    set second_mon (echo $data | awk '{print $2}')

    # we need the path part after image:
    set img_data (awww query | sed -n 's/.*image: \(.*\)/\1/p' | string join ' ')
    set first_mon_wallpaper (echo $img_data | awk '{print $1}')
    set second_mon_wallpaper (echo $img_data | awk '{print $2}')

    pprint "First monitor: %s\n" $first_mon || return $status
    pprint "Second monitor: %s\n" $second_mon || return $status
    pprint "Current wallpaper for DP-1: %s\n" $first_mon_wallpaper
    pprint "Current wallpaper for HDMI-A-2: %s\n" $second_mon_wallpaper

    #
    set -g output_buffer (mktemp /tmp/wa.XXXXXXXXXX)

    if test -z "$path_one" -a -z "$path_two"
        printf "No paths provided, exiting.\n"
        set path_one $first_mon_wallpaper
        set path_two $second_mon_wallpaper
    end

    if test -z "$path_one" -o "$path_one" = "$first_mon_wallpaper"
        printf "No new wallpaper for DP-1, keeping current: %s\n" $first_mon_wallpaper
        set path_one $first_mon_wallpaper
    end

    if test -z "$path_two" -o "$path_two" = "$second_mon_wallpaper"
        printf "No new wallpaper for HDMI-A-2, keeping current: %s\n" $second_mon_wallpaper
        set path_two $second_mon_wallpaper
    end

    if test -z "$path_two"
        set path_two $second_mon_wallpaper
    end

    if not test (string match "$path_one" "$first_mon_wallpaper")
        pprint "Setting wallpaper for %s to %s\n" $first_mon $path_one
        set_awww $path_one $first_mon || return $status
    end

    if not test (string match "$path_two" "$second_mon_wallpaper")
        pprint "Setting wallpaper for %s to %s\n" $second_mon $path_two
        set_awww $path_two $second_mon || return $status
    end

    if not 99-look_wallust $path_one
        printf "Failed to set wallust colors for %s\n" $path_one
        return 1
    end
    command hyprctl reload >/dev/null || return $status

    cleanup || return $status

    # but awww does not. So we have to hardcode them here.

    # we need the DP-1 part, and the HDMI-A-2 part

    return $status

end
