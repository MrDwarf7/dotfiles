#!/usr/bin/env bash

## what are the `rg` flags?? ->
# -g (glob ['!' is exclude]) to exclude the current file from search
# -I --no-filename
# -N --n-line-numbers
# -A <#num> After <number of context lines>

function out {
  ignore=$1
  search_term=$2
  use_flags=$3

  output=$(rg -g "$ignore" "$search_term" $use_flags)

  printf "%s\n" "$output"

}

function help_refs {
  cat <<EOF

Usage: references.sh [search terms]
Search for references to symbols in other files, excluding the current file.

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

  # echo "CUR FILEPATH: $current_file_path"
  # echo "CUR FILENAME: $current_file_name"
  # echo "CUR PARENTDIR: $current_file_parent_dir"

  should_narrow=false
  declare -a search_terms=()

  case "${1:-}" in
  h | -h | --help)
    help_refs
    return 0
    ;;
  esac

  # if we get any form of text in, flip the `should_narrow` to true
  # and store the text in a variable

  if [ "$#" -gt 0 ]; then
    should_narrow=true
    search_terms+=("$@")
  fi

  if [ "$should_narrow" = true ]; then
    first=$(out "!$current_file_name" "REF S" "-INA 34")
    second=$(printf "%s" "$first" | rg -i "$(printf "%s" "${search_terms[@]}")" -INA 34)
    printf "%s\n" "$second"
    return 0
  fi

  output=$(
    rg -g "!$current_file_name" "REF S" "$current_file_parent_dir" -INA 34
  )
  printf "%s\n" "$output"

}

main "$@"
