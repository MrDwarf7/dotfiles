#!/usr/bin/env bash

set -euo pipefail

# This script updates the local vimium-options.json file by copying the latest
# version from the downloads directory. It prefers "vimium-options (1).json" if
# it exists (assuming it's a duplicate download), renames it to the standard
# name, and copies it to the current directory. If no duplicate exists, it
# copies "vimium-options.json" directly if available.

BASE_NAME="vimium-options"
BASE_EXT="json"
OLD_FILE="${BASE_NAME}.${BASE_EXT}"
NEW_FILE="${BASE_NAME} (1).${BASE_EXT}"
DOWNLOADS_DIR=""

CSS_FILE="current_theme.css"

# Find the downloads directory (checks "Downloads" or "downloads" in $HOME)
find_downloads_dir() {
  local home="${HOME}"
  local possible_dirs=("Downloads" "downloads")

  for dir in "${possible_dirs[@]}"; do
    if [[ -d "${home}/${dir}" ]]; then
      DOWNLOADS_DIR="${home}/${dir}"
      return 0
    fi
  done

  echo "No downloads directory found."
  return 1
}

# Helper function to extract CSS content from the JSON file
_extract_css_content() {
  local file_path="$1"
  if [[ ! -f "${file_path}" ]]; then
    echo "File not found: ${file_path}"
    return 1
  fi

  local css_content
  # | sed -E 's/\\n/\n/g; s/\\"/"/g')
  css_content=$(jq -r '.userDefinedLinkHintCss' "${file_path}" | sed -E 's/(^")(.*)("$)/\2/' | sed -E 's/\\\n/\n/g' | sed -E 's/(\\\")/"/g')
  echo "${css_content}"

  if [[ -z "${css_content}" ]]; then
    echo "No CSS content found in ${file_path}"
    return 1
  fi

  printf "%s" "${css_content}"

  return 0
}

# Creates or backups the CSS file
# Then writes the extracted CSS content into it
create_css_file() {
  local extract_from="$1"

  if [[ -e "${CSS_FILE}" ]]; then
    printf "Backing up existing %s to a timestamped file.\n" "${CSS_FILE}"
    declare ts
    ts=$(date +%Y%m%d_%H%M%S)
    local new_filename="${CSS_FILE%.css}_${ts}_BAK.css"
    mv "${CSS_FILE}" "${new_filename}"
    printf "Backup created: %s\n" "${new_filename}"
  fi

  local css_content
  css_content=$(_extract_css_content "${extract_from}")

  if [[ -z "${css_content}" ]]; then
    echo "No CSS content to write to ${CSS_FILE}."
    return 1
  fi

  printf "Successfully extracted CSS content. Writing to %s.\n" "${CSS_FILE}"

  printf "%s\n" "${css_content}" >"${CSS_FILE}"
  if [[ $? -ne 0 ]]; then
    echo "Failed to write CSS content to ${CSS_FILE}."
    return 1
  fi

  return 0
}

# cat vimium-options.json | jq '.userDefinedLinkHintCss' | sed -E 's/(^")(.*)("$)/\2/' | sed -E 's/\\\n/\n/g' |sed -E 's/(\\\")/"/g'

main() {
  if ! find_downloads_dir; then
    echo "Error determining downloads directory."
    exit 1
  fi

  local source_file="${DOWNLOADS_DIR}/${OLD_FILE}"
  local new_path="${DOWNLOADS_DIR}/${NEW_FILE}"
  local dest_file="./${OLD_FILE}"

  # If the duplicate (new) file exists, rename it to the standard name
  if [[ -e "${new_path}" ]]; then
    mv -f "${new_path}" "${source_file}"
    echo "Renamed ${NEW_FILE} to ${OLD_FILE} in ${DOWNLOADS_DIR}."
  fi

  # Now check if the standard source file exists and copy it
  if [[ -e "${source_file}" ]]; then
    cp -f "${source_file}" "${dest_file}"
    echo "Copied ${OLD_FILE} to current directory."
    echo "Update completed successfully."
  else
    echo "No file to copy: ${OLD_FILE} not found in ${DOWNLOADS_DIR}."
    return 1
  fi

  if ! create_css_file "${dest_file}"; then
    printf "Failed to create or update %s from %s\n" "${CSS_FILE}" "${dest_file}" >&2
    return 1
  fi

  printf "Done.\n"
  return 0

}

main "$@"
