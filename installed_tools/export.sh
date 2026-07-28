#!/usr/bin/env bash
#
# export.sh - dump all pacman/paru package-list variants for this machine.
# Run from anywhere; writes into the directory this script lives in.
# Re-run after installs to refresh before a drive migration.
set -euo pipefail

OUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pacman -Qm >"$OUT_DIR/aur_packages.txt"             # foreign / AUR (reinstall via AUR helper)
pacman -Qq >"$OUT_DIR/packages_name_only.txt"       # names only
pacman -Q >"$OUT_DIR/pacman_installed_packages.txt" # everything (name+ver)
pacman -Q >"$OUT_DIR/paru_installed_packages.txt"   # (same as above; kept for compat)
pacman -Qn >"$OUT_DIR/pacman_native_packages.txt"   # native (repo) pkgs only
pacman -Qe >"$OUT_DIR/paru_explicit_package.txt"    # explicit installs - the reinstall set

printf "Exported package lists to:\n\t%s\n\n" "$OUT_DIR"
wc -l "$OUT_DIR"/aur_packages.txt "$OUT_DIR"/packages_name_only.txt \
  "$OUT_DIR"/pacman_installed_packages.txt "$OUT_DIR"/paru_installed_packages.txt \
  "$OUT_DIR"/pacman_native_packages.txt "$OUT_DIR"/paru_explicit_package.txt
