#!/usr/bin/env fish
#

# The actual colorize function that does the work
# uses the associated helper function for usage info
#
# Parameters:
# `argv[1]`: color name (e.g., red, green, blue)
# `argv[2..-1]`: text to colorize (can be multiple words)
#
# Returns:
# `1`: If color not found or error
# `0`: If successful
function colorize_handler --description 'Wrap text with ANSI color codes'
    set -l color_name $argv[1]
    set -l text $argv[2..-1] # Allow multiple words

    # If the text already ends with a newline, don't add another
    # set text (printf "%s" $text | tr -d '\n')

    set text (string escape $text | tr -d '\n')

    # Color mapping (like your hashmap)
    set -l color_code
    switch $color_name
        case red
            set color_code "\033[31m"
        case green
            set color_code "\033[32m"
        case yellow
            set color_code "\033[33m"
        case blue
            set color_code "\033[34m"
        case magenta purple
            set color_code "\033[35m"
        case cyan
            set color_code "\033[36m"
        case white
            set color_code "\033[37m"
        case black
            set color_code "\033[30m"
        case gray grey
            set color_code "\033[90m"
        case bright_red
            set color_code "\033[91m"
        case bright_green
            set color_code "\033[92m"
        case bright_yellow
            set color_code "\033[93m"
        case bright_blue
            set color_code "\033[94m"
        case bright_magenta bright_purple
            set color_code "\033[95m"
        case bright_cyan
            set color_code "\033[96m"
        case bright_white
            set color_code "\033[97m"
        case '*'
            colorize red "Error: Color '$color_name' not found" >&2
            printf "\n"
            colorize_help
            return 1
    end

    # Join text with spaces and wrap with color
    # printf "%s%s\e[0m" $color_code (string join ' ' (string unescape -- $text))
    set -l full_text (string join ' ' (string unescape -- $text))

    # printf "$color_code$full_text\033[0m"
    # printf "value of color_code: %s\n" $color_code
    # printf "%s%s\033[0m" $color_code $full_text
    echo -en "$color_code$full_text\033[0m"

    printf "\n"

    return 0
end

function colorize_help --description 'Display usage information for colorize'
    set -l colors red green yellow blue magenta purple cyan white black gray grey bright_red bright_green bright_yellow bright_blue bright_magenta bright_purple bright_cyan bright_white
    printf "Usage: colorize <color> <text>\n"
    printf "Wraps the given text with ANSI color codes.\n\n"
    printf "Available colors:\n"
    for color in $colors
        printf "  %s\n" $color
    end
    printf "\nExample: colorize red 'Hello World'\n"
    return 0
end

# Convenience function for common usage
# uses argparse for help flag
#
# Parameters:
# `$argv[1]`?: color name (e.g., red, green, blue)
# `$argv[2]`?: text to colorize (can be multiple words)
#
# Arguments:
# `""`/null - Automatically parsed by argparse as help/usage flag
# `-h/--help` - Show help message and exit
#
# Returns:
# 0 on success
# null on failure to parse args
# status of colorize_handler (colore message)
function colorize --description 'Alias for colorize'
    argparse h/help -- $argv
    or return
    if set -q _flag_help
        colorize_help
        return 0
    end
    colorize_handler $argv
end
