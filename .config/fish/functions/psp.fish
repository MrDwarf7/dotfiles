#!/usr/bin/env fish
#

set utility playerctl
set player spotify
set volume_increment 0.1

set k_help q
set k_next l
set k_previous h
set k_stop j
set k_play k
set k_vol_up u
set k_vol_down d
set k_loop_track t
set k_loop_playlist p
set k_loop_none o
set k_metadata i
set k_info_generator g


function __psp_cmp
    complete -c psp -s "$k_help" -l help -d 'Show this help message and exit'
    complete -c psp -s "$k_next" -l next -d 'Next track'
    complete -c psp -s "$k_previous" -l previous -d 'Previous track'

    complete -c psp -s "$k_stop" -l stop -d 'Stop playback'
    complete -c psp -s "$k_play" -l play -d 'Play playback'

    complete -c psp -s "$k_vol_up" -l vol_up -d 'Volume up by $volume_increment'
    complete -c psp -s "$k_vol_down" -l vol_down -d 'Volume down by $volume_increment'

    complete -c psp -s "$k_loop_track" -l loop_track -d 'Loop track'
    complete -c psp -s "$k_loop_playlist" -l loop-playlist -d 'Loop playlist'
    complete -c psp -s "$k_loop_none" -l loop-none -d 'Loop off'

    complete -c psp -s "$k_metadata" -l metadata -d 'Show track metadata'
    complete -c psp -s "$k_info_generator" -l info-generator -d 'Show track info with album art'
    return 0
end

function __psp_help
    if not 00valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    090help "\
Usage: psp [OPTION]

Handles calling 'playerctl' for Spotify
with shorthand args.
" "
,                    ,                           ,           ,
,Short               ,Long                       ,Description,
,                    ,                           ,           ,
,-$k_help            , --help                    ,# Show this help message and exit,
,-$k_next            , --next                    ,# Next track,
,-$k_previous        , --previous                ,# Previous track,
,-$k_stop            , --stop                    ,# Stop playback,
,-$k_play            , --play                    ,# Play playback,
,-$k_vol_up          , --vol-up                  ,# Volume up by $volume_increment,
,-$k_vol_down        , --vol-down                ,# Volume down by $volume_increment,
,-$k_loop_track      , --loop-track              ,# Set loop to Track,
,-$k_loop_playlist   , --loop-playlist           ,# Set loop to Playlist,
,-$k_loop_none       , --loop-none               ,# Set looping off,
,-$k_metadata        , --metadata                ,# Show track metadata,
,-$k_info_generator  , --info-generator          ,# Show track info with album art,
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,psp -$k_help                           ,# Show this help message and exit,,
,psp -$k_next                           ,# Skip to next track,,
,psp -$k_previous                       ,# Go to previous track,,
,psp -$k_stop                           ,# Stop playback,,
,psp -$k_play                           ,# Start playback,,
,psp -$k_vol_up                         ,# Increase volume by $volume_increment,,
,psp -$k_vol_down                       ,# Decrease volume by $volume_increment,,
"
    return 0
end

function base_command
    # echo "Utility: $utility"
    # echo "Player: $player"
    # echo "Command is: $argv[1] $argv[2] $argv[3]"
    set comm $argv[1..-1]
    # $argv[1] $argv[2]
    $utility -p $player $comm
end

function curl_track_img
    # wezterm imgcat

    if 00valid_pacman xh
        xh (base_command metadata mpris:artUrl) | chafa -w 9
    else
        curl -s (base_command metadata mpris:artUrl) | chafa -w 9
    end
end

function info_generator
    set -l prog ""
    if 00valid_pacman xh
        set prog xh
    else
        set prog curl
    end
    # constants
    set -l base_command playerctl -p spotify
    set -l format_template "{{ title }} by {{ artist }} | {{ album }}"

    # data fetching
    set -l buffer_track_data $(command $base_command metadata --format "$format_template")
    set -l buffer_img $(command $prog $($base_command metadata mpris:artUrl) | chafa -w 9)

    printf "\n%s\n%s\n" "$buffer_img" "$buffer_track_data"
end

# playerctl -p spotify metadata --format "{{ title }} by {{ artist }} | {{ album }}";
#   xh $(playerctl -p spotify metadata mpris:artUrl) | chafa

# set payload (base_command metadata --format "{{ title }} by {{ artist }} | {{ album }}")
# printf "\n%s\n%s\n" $(curl_track_img) $payload
# curl_track_img &
# printf "\n"
# printf "$payload\n"


function psp --description "[P]layerctl [S][P]otify"
    __psp_cmp
    # set base_command (playerctl -p spotify)

    argparse -x $k_help,$k_next,$k_previous,$k_stop,$k_play,$k_vol_up,$k_vol_down,$k_loop_track,$k_loop_playlist,$k_loop_none,$k_metadata,$k_info_generator $k_help/help $k_next/next $k_previous/previous $k_stop/stop $k_play/play $k_vol_up/vol_up $k_vol_down/vol_down $k_loop_track/loop_track $k_loop_playlist/loop-playlist $k_loop_none/loop-none $k_metadata/metadata $k_info_generator/info-generator -- $argv
    or return 1

    if set -q _flag_help
        set com $k_help
        __psp_help
        return 0
    end

    set players (playerctl -l)

    if not contains spotify $players
        printf "Spotify player not found among running players!\n"
        return 1
    end

    set base_command playerctl -p spotify

    # we don't really need the -h/--help handling here as we do it earlier,
    # but better to have them if we change it later.

    set com ''
    if set -q _flag_help
        set com $k_help
    else if set -q _flag_next
        set com $k_next
    else if set -q _flag_previous
        set com $k_previous
    else if set -q _flag_stop
        set com $k_stop
    else if set -q _flag_play
        set com $k_play
    else if set -q _flag_vol_up
        set com $k_vol_up
    else if set -q _flag_vol_down
        set com $$k_vol_down
    else if set -q _flag_loop_track
        set com $k_loop_track
    else if set -q _flag_loop_playlist
        set com $k_loop_playlist
    else if set -q _flag_loop_none
        set com $k_loop_none
    else if set -q _flag_metadata
        set com $k_metadata
    else if set -q _flag_info_generator
        set com $k_info_generator
    else
        set com ''
    end

    if test -z "$com"
        __psp_help
        colorize "yellow" "No command provided!\n"
        return 2
    end

    switch $com
        case $k_help
            __psp_help
        case $k_next
            $base_command next
        case $k_previous
            $base_command previous
        case $k_stop
            $base_command stop
        case $k_play
            $base_command play
        case $k_vol_up
            $base_command volume $volume_increment+
        case $k_vol_down
            $base_command volume $volume_increment-
        case $k_loop_track
            $base_command loop Track
        case $k_loop_playlist
            $base_command loop Playlist
        case $k_loop_none
            $base_command loop None
        case $k_metadata
            $base_command metadata
        case $k_info_generator
            info_generator
            return 0
        case '*'
            __psp_help
            colorize "yellow" "No argument recognized!\n"
            return 3
    end

    # if test -n "$com"
    #     colorize "yellow" "Your [ $com ] command wasn't caught in the switch-case statement!\n"
    #     return 2
    # end

    if test -z "$com"
        __psp_help
        colorize "yellow" "No command provided!\n"
        return 4
    end

    return 0
end

#     switch $com
#         case h
#             psp_help
#             return $status
#         # Basic player commands
#         case n
#             # eval $base_command next
#             base_command next
#             # return $status
#         case p
#             base_command previous
#             return $status
#         case st
#             base_command stop
#             return $status
#         case pl
#             base_command play
#             return $status
#
#             # Volume controls
#         case vu
#             base_command volume $volume_increment+
#             return $status
#         case vd
#             base_command volume $volume_increment-
#             return $status
#
#             # Loop controls
#         case lpt
#             base_command loop Track
#             return $status
#         case lpp
#             base_command loop Playlist
#             return $status
#         case lpn
#             base_command loop None
#             return $status
#
#             # Info command
#         case i
#             base_command metadata
#             return $status
#
#         case oo
#             info_generator
#             # base_command metadata
#             return $status
#
#             # Default case handler
#         case '*'
#             psp_help
#             printf 'No argument recognized.'
#             return 3
#     end
#     # We auto handle the fallthrough via * so, shouldn't really get here tbh
#     psp_help
#     return 99
# end
#
# # DEPR __ NOT USED
# # function volume_command
# #     set comm $argv[1]
# #
# #     switch $comm
# #         case "vol_up"
# #             base_command volume $volume_increment+
# #         case "vol_down"
# #             base_command volume $volume_increment-
# #         case "*"
# #             printf "Not a valid volume command."
# #             printf "Please use either 'vol_up' or vol_down' when calling this function"
# #         return 1
# #     end
# #     return 0
# # end
