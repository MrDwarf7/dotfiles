#!/usr/bin/env fish
#

function colorize_handler --description 'Wrap text with ANSI color codes'
    set -l color_name $argv[1]
    set -l text $argv[2..-1] # Allow multiple words

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
            # printf "Error: Color '%s' not found\n\n" $color_name >&2
            help_usage
            return 1
    end

    # Join text with spaces and wrap with color
    # printf "%s%s\e[0m" $color_code (string join ' ' $text)
    set -l full_text (string join ' ' $text)
    # printf "$color_code$full_text\033[0m"
    # printf "value of color_code: %s\n" $color_code
    # printf "%s%s\033[0m" $color_code $full_text
    echo -en "$color_code$full_text\033[0m"
    printf "\n"
    return 0
end

function help_usage --description 'Display usage information for colorize'
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
function colorize --description 'Alias for colorize'
    argparse h/help -- $argv
    or return

    if set -q _flag_help
        help_usage
        return 0
    end

    colorize_handler $argv
end
