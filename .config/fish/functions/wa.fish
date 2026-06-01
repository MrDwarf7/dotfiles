#!/usr/bin/env fish
#

function wa --description 'Call waypaper for wallust'
    set path_one $argv[1]
    set path_two $argv[2]

    colorize yellow "Using wallpaper backend: $WALLPAPER_BACKEND\n"

    switch $WALLPAPER_BACKEND
        case waypaper
            099look_waypaper $path_one $path_two

        case (string match -r 'awww' $WALLPAPER_BACKEND)
            099look_awww $path_one $path_two

        case '*'
            printf "Unsupported wallpaper backend: %s\n" $WALLPAPER_BACKEND
            return 1
    end
    return $status
end
