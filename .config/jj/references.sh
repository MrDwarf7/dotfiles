#!/usr/bin/env bash

## what are the `rg` flags?? ->
# -g (glob ['!' is exclude]) to exclude the current file from search
# -I --no-filename
# -N --n-line-numbers
# -A <#num> After <number of context lines>

# declare -g output
#
# function out {
#   ignore=$1
#   search_term=$2
#   use_flags=$3
#
#   # if output has value, clear it
#
#   if [ -n "$output" ]; then
#     output=""
#   fi
#
#   v=$(rg -g "$ignore" "$search_term" $use_flags)
#   output=$v
#
#   printf "%s\n" "$output"
#
# }

# The total lines to clip AFTER the searched term
TOTAL_LINES_AFTER=37
TOTAL_LINES_BEFORE=1
SEARCHED_CONTEXT_LINES=1
SEARCHED_TAG_PREFIX="REF S"

RG_PREF_FLAGS="--color=always"

function help_refs {
  cat <<'EOF'

Usage: references.sh [search terms]
Output the 'REF' block inside the jj config file.
Passing a single word search term will filter the references to only those that match the term.

Default (surrounding) `context` via the `-C` flag is `1`.
This means 1 line above, and 1 below the search term/result.

If no search terms are provided, all references will be shown.

Options:
-h, --help    Show this help message and exit

EOF

  return 0
}

function main {
  # Resolve the actual script path (handles symlinks)
  current_file_path=$(readlink -f "$0")
  # Extract the actual filename from the resolved path
  current_file_name=$(basename "$current_file_path")
  current_file_parent_dir=$(dirname "$current_file_path")

  # we have help flags!
  case "${1:-}" in
  h | -h | --help)
    help_refs
    return 0
    ;;
  esac

  # if we get any form of text in, flip the `should_narrow` to true
  # and store the text in a variable

  declare -a search_terms=() # Not sure we even need this tbh
  declare output=""          # output buffer

  if [ "$#" -gt 0 ]; then
    search_terms+=("$@")
    output=$(rg -g "!$current_file_name" "${SEARCHED_TAG_PREFIX}" "$current_file_parent_dir" -INA $TOTAL_LINES_AFTER -B $TOTAL_LINES_BEFORE)
    output=$(printf "%s\n" "$output" | rg $RG_PREF_FLAGS -i "${search_terms[@]}" -C $SEARCHED_CONTEXT_LINES)
  else
    output=$(rg $RG_PREF_FLAGS -g "!$current_file_name" "${SEARCHED_TAG_PREFIX}" "$current_file_parent_dir" -INA $TOTAL_LINES_AFTER -B $TOTAL_LINES_BEFORE)
  fi

  printf "%s\n" "$output"
  return 0
}

main "$@"
