#!/usr/bin/env fish
#

set -g COLORS red green yellow blue magenta purple cyan white black gray grey bright_red bright_green bright_yellow bright_blue bright_magenta bright_purple bright_cyan bright_white

function has_newline_suffix --description "Ext. simple 'parser' - Handles newline's in user provided text"
    # Small implementtion of a parser to handle newlines on user provided text
    set -l t $argv
    if string match -qr '\n$' -- $t
        return 0
    else
        return 1
    end
end

function colorize_handler --description 'Wrap text with ANSI color codes'
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
    set -l color_name $argv[1]
    set -l text $argv[2..-1] # Allow multiple words

    # If the text already ends with a newline, don't add another
    # set text (printf "%s" $text | tr -d '\n')

    set text (string escape $text | tr -d '\n')

    # Color mapping (like your hashmap)
    set -l color_code
    switch $color_name
        case red error fail
            set color_code "\033[31m"
        case yellow warn
            set color_code "\033[33m"
        case green good ok info
            set color_code "\033[32m"
        case blue
            set color_code "\033[34m"
        case magenta purple
            set color_code "\033[35m"
        case cyan teal
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

    if not test (has_newline_suffix $full_text)
        # not string match -qr '\n$' -- $full_text
        echo -en "$color_code$full_text\033[0m"
    else
        echo -en "$color_code$full_text\033[0m\n"
    end

    # if the last char is NOT a newline literal '\n' then we append one, otherwise return 0
    # printf "\n"

    return 0
end

function gen_colors --description "Generates a buffer of 'colors' (based on \$COLORS) then writes it out via 'printf'"
    # Handles printing out a bunch of text.
    set -l ht " "
    set -l colors_len (count $COLORS)

    set -l idx 0
    set -l colors_buf ""

    # printf "total count: %s\ncurrent idx: %s\n\n" $colors_len $idx

    for color in $COLORS
        if test $idx -eq $(math 0)           # We don't want a newline sep on the first print
            set colors_buf "$colors_buf$ht - %s" $(colorize $color $color)
        end

        if test $idx -le $(math $colors_len - 1) -a $idx -ne $(math 0) # We're not on the very last one (don't want a newline on last color idx)
            set colors_buf "$colors_buf\n$ht - %s" $(colorize $color $color)
        end
        set idx (math $idx + 1)
    end
    printf "%s" $colors_buf
end

function colorize_help --description 'Display usage information for colorize'
    set -l ht " "
    set -l colors_buf $(gen_colors)

    set -l red_example (colorize red "This is red text")
    set -l green_example (colorize green "This is green text")
    set -l blue_example (colorize blue "This is blue text")

    printf "\
Usage: colorize <COLOR> <TEXT>

Wraps the given text with ANSI color codes.

Options:

Available colors:

$colors_buf

Examples:

$ht colorize red \"$red_example\"
$ht colorize green \"$green_example\"
$ht colorize blue \"$blue_example\"
"
    return 0
end

function colorize --description 'Alias for colorize'
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
    argparse h/help -- $argv
    or return
    if set -q _flag_help
        colorize_help
        return 0
    end
    colorize_handler $argv
end
