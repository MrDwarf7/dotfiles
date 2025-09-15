#!/usr/bin/env fish

function 099look_wallust
    set path $argv[1]

    if not 090test_path $path
        return 1
    end

    if not 090test_cmd wallust
        return 1
    end

    command wallust run -s $path >$output_buffer 2>&1 || begin
        printf "Failed to set wallust colors: %s\n" (cat $output_buffer)
        return 1
    end

    return $status
end
