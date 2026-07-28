#!/usr/bin/env fish
#

function 99-look_wallust
    set path $argv[1]

    not test -f $path; and return 1
    # if not test -f $path
    #     return 1
    # end
    not 00-valid_pacman wallust; and return 1

    # if not 00-valid_pacman wallust
    #     return 1
    # end

    command wallust run -s $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallust colors: %s\n" (cat $output_buffer)
        return 1
    end

    return $status
end
