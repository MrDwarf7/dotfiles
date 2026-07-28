#!/usr/bin/env fish
#

function 90-help --description 'Display help messages formatted as tables'
    # Prints help messages
    #
    # Parameters:
    # `$argv[1]`: Usage string
    # `$argv[2]`: Options string (comma-separated values)
    # `$argv[3]`: Examples string (comma-separated values)
    # `$argv[4]`: (optional) Table padding (default: 1)
    #
    # Returns:
    # 0 on success
    # 1 on failure

    set -l usage $argv[1]
    set -l options $argv[2]
    set -l example $argv[3]

    set -l table_opts 1 ',' false

    printf "%s
Options:
%s

Examples:
%s
" "$usage" "$( 90-table $options $table_opts )" "$( 90-table $example $table_opts )"
    return $status
end

#     set -l buf_usage "\
# Usage: psp [OPTION]
#
# Handles calling 'playerctl' for Spotify
# with shorthand args.
# "
#
#         set -l buf_opts "
# ,,,,
# ,Short               ,Long                      ,Description,
# ,,,,
# ,-$k_help            , --help                   ,# Show this help message and exit,
# ,-$k_next            , --next                   ,# Next track,
# ,-$k_previous        , --previous               ,# Previous track,
# ,-$k_stop            , --stop                   ,# Stop playback,
# ,-$k_play            , --play                   ,# Play playback,
# ,-$k_vol_up          , --vol-up                 ,# Volume up by $volume_increment,
# ,-$k_vol_down        , --vol-down               ,# Volume down by $volume_increment,
# ,-$k_loop_track      , --loop-track             ,# Set loop to Track,
# ,-$k_loop_playlist   , --loop-playlist          ,# Set loop to Playlist,
# ,-$k_loop_none       , --loop-none              ,# Set looping off,
# ,-$k_metadata        , --metadata               ,# Show track metadata,
# ,-$k_info_generator  , --info-generator         ,# Show track info with album art,
# "
#
#         set -l buf_examples "
# ,,,,
# ,Command                               ,Description,,
# ,,,,
# ,psp -$k_help                          ,# Show this help message and exit,,
# ,psp -$k_next                          ,# Skip to next track,,
# ,psp -$k_previous                      ,# Go to previous track,,
# ,psp -$k_stop                          ,# Stop playback,,
# ,psp -$k_play                          ,# Start playback,,
# ,psp -$k_vol_up                        ,# Increase volume by $volume_increment,,
# ,psp -$k_vol_down                      ,# Decrease volume by $volume_increment,,
# "
#
#     printf "%s
# Options:
# %s
#
# Examples:
# %s
#
# " "$buf_usage" "$( 090table $buf_opts 1 ',' false )" "$( 090table $buf_examples 1 ',' false )"
