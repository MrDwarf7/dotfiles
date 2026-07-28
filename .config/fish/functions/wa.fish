#!/usr/bin/env fish
#

function wa --argument-names path_one path_two --description 'Call waypaper for wallust'
    colorize yellow "Using wallpaper backend: $WALLPAPER_BACKEND\n"

    switch $WALLPAPER_BACKEND
        case waypaper
            99-look_waypaper $path_one $path_two

        case (string match -r 'awww' $WALLPAPER_BACKEND)
            99-look_awww $path_one $path_two

        case '*'
            printf "Unsupported wallpaper backend: %s\n" $WALLPAPER_BACKEND
            return 1
    end
    return $status
end
