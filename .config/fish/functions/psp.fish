#!/usr/bin/env fish

set utility playerctl
set player spotify
set volume_increment 0.1

function base_command
    # echo "Utility: $utility"
    # echo "Player: $player"
    # echo "Command is: $argv[1] $argv[2] $argv[3]"
    set comm $argv[1..-1]
    # $argv[1] $argv[2]
    $utility -p $player $comm
end

function curl_track_img
    curl -s (base_command metadata mpris:artUrl) | wezterm imgcat
end

function info_generator
    # set comm $argv[1]

    set payload (base_command metadata  --format "{{ title }} by {{ artist }} | {{ album }}")
    printf "\n"
    curl_track_img &
    printf "\n"
    printf "$payload"

end

function psp --description "[P]layerctl [S][P]otify"
    # set base_command (playerctl -p spotify)
    set check_running (playerctl -l)

    if test -z $argv[1]
        printf "Must supply an argument"
        return 2
    end
    set com $argv[1]

    if $check_running &>/dev/null -ne spotify
        printf "This commands required spotify to be running!"
        return 1
    end

    # length check

    switch $com
        # Basic player commands
        case n
            base_command next
            return $status
        case p
            base_command previous
            return $status
        case st
            base_command stop
            return $status
        case pl
            base_command play
            return $status

            # Volume controls
        case vu
            base_command volume $volume_increment+
            return $status
        case vd
            base_command volume $volume_increment-
            return $status

            # Loop controls
        case lpt
            base_command loop Track
            return $status
        case lpp
            base_command loop Playlist
            return $status
        case lpn
            base_command loop None
            return $status

            # Info command
        case i
            base_command metadata
            return $status

        case oo
            info_generator
            # base_command metadata
            return $status

            # Default case handler
        case '*'
            printf 'No argument recognized.'
            return 3
    end
    # We auto handle the fallthrough via * so, shouldn't really get here tbh
    return 99
end

# DEPR __ NOT USED
# function volume_command
#     set comm $argv[1]
#
#     switch $comm
#         case "vol_up"
#             base_command volume $volume_increment+
#         case "vol_down"
#             base_command volume $volume_increment-
#         case "*"
#             printf "Not a valid volume command."
#             printf "Please use either 'vol_up' or vol_down' when calling this function"
#         return 1
#     end
#     return 0
# end
