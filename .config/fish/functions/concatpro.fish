#!/usr/bin/env fish
#

set -g DEBUG_MODE 1

function pprintf
    if test $DEBUG_MODE -eq 1
        printf $argv
    end
end

# Registers completions
function __concatpro_cmp
    complete -c concatpro -s h -l help -d 'Print help (see more with \'--help\')'
    complete -c concatpro -s e -l extension -d 'The extension that \'fd\' will use to find the files'
    complete -c concatpro -s d -l directory -d 'The directory that \'fd\' will search for files inside of'
    complete -c concatpro -s o -l output -d 'The output file. If extension is missing will use provided \'-e\' param if available'
    complete -c concatpro -s c -l comment_char -d 'The comment character to use when applying the file name to the output file. Defaults to \'//\' if none are given'
end

function __concatpro_help
    # set -l half_tab (printf "%s" (printf "\t"))
    set -l ht " " # single space char
    printf "\
Usage: concatpro [OPTIONS]

Given a directory, use 'fd' and xargs
to generate a single output file with
all the source files of the extension type.

Options:

$ht -h, --help                              # Show this help message and exit
$ht -e, --extension                         # The extension used with the 'fd' command
$ht -d, --directory                         # The directory to search within, defaults to '.' if none given
$ht -o, --output                            # The output path, will default to 'all.{extension}' if none given
$ht -c, --comment_char                      # The comment char used when assembling the output file, if none given assumed '//'

Examples:

$ht concatpro -h | --help                   # Show this help message and exit
$ht concatpro -e rs -d ./crates/ -o all.rs  # Concatenate all .rs files in ./crates/ to all.rs
$ht concatpro -e py -c '#'                  # Concatenate all .py files in current dir to all.py, using '#' for comments
"
    return 0
end

function concatpro --description 'Concatenates files of a given extension in the directory to an output file'
    __concatpro_cmp

    # Parse options; no min-args since positionals aren't required
    argparse h/help e/extension= d/directory= o/output= c/comment_char= -- $argv
    or return

    if set -q _flag_help
        __concatpro_help
        return 0
    end

    pprintf "argv :: %s\n" $argv[..]
    pprintf "argv_OPTS :: %s\n" $argv_opts[..]

    pprintf "_flag_help :: %s\n" $_flag_help
    pprintf "_flag_extension :: %s\n" $_flag_extension
    pprintf "_flag_directory :: %s\n" $_flag_directory
    pprintf "_flag_output :: %s\n" $_flag_output
    pprintf "_flag_comment_char :: %s\n" $_flag_comment_char

    set -l potential_input_dirs ""
    if test -d crates
        set potential_input_dirs crates
    else if test -d src
        set potential_input_dirs src
    else if test -d src-tauri
        set potential_input_dirs src-tauri
    else
        set potential_input_dirs "."
    end

    pprintf "potential_input_dirs: %s\n" $potential_input_dirs

    # Set defaults
    set -l input_dir (set -q _flag_directory && printf "%s" $_flag_directory || printf '%s' $potential_input_dirs)
    set -l comment_char (set -q _flag_comment_char && printf "%s" $_flag_comment_char || printf '//')
    set -l file_ext ''
    set -l output ''

    # Handle output and extension logic
    if set -q _flag_output
        set output $_flag_output
        # Extract extension from output if present
        set -l ext_match (string match -r '\.(\w+)$' $output)
        if set -q ext_match[2]
            set file_ext $ext_match[2]
        end
    end

    if set -q _flag_extension
        # Normalize extension: remove leading dot if present
        set -l given_ext (string replace -r '^\.' '' $_flag_extension)
        if test -n "$file_ext" -a "$file_ext" != "$given_ext"
            colorize yellow "Warning: Extension from -o ('$file_ext') differs from -e ('$given_ext'). Using -e.\n"
        end
        set file_ext $given_ext
    end

    # If output not set, use default if file_ext is available
    if test -z "$output"
        if test -n "$file_ext" # default name + user-given ext
            set output "all.$file_ext"
        else
            pprintf "1. "
            colorize yellow "1. Error: No extension provided via -e or inferred from -o.\n"
            return 1
        end
    else if test -z "$file_ext"
        # If output set but no ext inferred or given, error
        # colorize yellow "2. Error: No extension provided via -e and none found in -o and file_ext is empty.\n"
        pprintf "2. "
        colorize yellow "No extension provided via -e and none found in -o. Will try to find by language.\n"

        # TODO:
        set file_ext (090project_language_ext)
        set output "all.$file_ext"

        pprintf "$(colorize blue "Using '$output'.\n")"
    else
        # If output lacks extension but file_ext is set (from -e), append it
        if not string match -qr '\.\w+$' $output
            set output "$output.$file_ext"
        end
    end

    # Now perform the concatenation
    #
    set -l files (fd --extension $file_ext "" $input_dir)
    if test (count $files) -eq 0
        colorize red "No files found with extension '$file_ext' in '$input_dir'.\n"
        return 1
    end

    # Clear output file if it exists
    true >$output

    for file in $files
        set -l commented_filename (printf "\n%s %s\n" $comment_char $file )

        printf "%s" $commented_filename >>$output
        cat $file >>$output
    end

    colorize info "Concatenated files to '$output'.\n"
    return 0
end
