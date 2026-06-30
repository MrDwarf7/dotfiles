#!/usr/bin/env bash
#
# generate_ctags.sh - build a Universal Ctags index of system headers,
# with a live progress bar driven by ctags' own --verbose output.
#
set -euo pipefail

# Directories to index. Globs (e.g. /usr/lib/gcc/*/*/include) are expanded
# later, because ctags does NOT expand shell globs itself.
TAG_DIRS=(
  /usr/include
  /usr/local/include
  /usr/lib/gcc/*/*/include
  /usr/lib32
)

OUTPUT_DIR="$HOME/.config/ctags"
OUTPUT_FILE="ctags"
OUTPUT="$OUTPUT_DIR/$OUTPUT_FILE"

BAR_WIDTH=40

# FIFO path for streaming ctags --verbose output. Declared at global scope
# (NOT local to main) because the EXIT trap that cleans it up fires after
# main returns; an unbound local would trip `set -u`.
fifo=""

# Render a one-line, carriage-return-overwritten progress bar.
#   $1 = files processed so far
# Reads global $total (estimated file count from the caller).
draw_bar() {
  local done=${1:-0} pct=0 filled empty hashes dashes
  pct=$(( done * 100 / total ))
  (( pct > 100 )) && pct=100
  filled=$(( pct * BAR_WIDTH / 100 ))
  empty=$(( BAR_WIDTH - filled ))
  hashes=$(printf '%*s' "$filled" '' | tr ' ' '#')
  dashes=$(printf '%*s' "$empty"  '' | tr ' ' '-')
  printf '\r  [%s%s] %3d%%  %d/%d files' "$hashes" "$dashes" "$pct" "$done" "$total"
}

main() {
  # --- prepare output directory ---
  if [[ -d "$OUTPUT_DIR" ]]; then
    printf 'Directory %s already exists.\n' "$OUTPUT_DIR"
  else
    mkdir -p "$OUTPUT_DIR"
    printf 'Created directory %s.\n' "$OUTPUT_DIR"
  fi
  printf 'Generating ctags file %s in %s...\n' "$OUTPUT_FILE" "$OUTPUT_DIR"

  # --- expand globs into a concrete directory list ---
  local expanded=()
  for pattern in "${TAG_DIRS[@]}"; do
    for dir in $pattern; do        # intentionally unquoted: let the glob expand
      [[ -e "$dir" ]] && expanded+=("$dir")
    done
  done
  if (( ${#expanded[@]} == 0 )); then
    printf 'No taggable directories found; nothing to do.\n' >&2
    exit 1
  fi

  # --- denominator: estimate how many files ctags will open ---
  # Count regular files under each target (skipping VCS metadata and a few
  # binary extensions ctags would skip anyway). This is an estimate; the bar
  # is driven by the real OPENING lines from --verbose and snaps to 100% at end.
  total=0
  local dir n
  for dir in "${expanded[@]}"; do
    n=$(find "$dir" -type f \
          -not -path '*/.git/*' -not -path '*/.hg/*' -not -path '*/.svn/*' \
          ! -name '*.o' ! -name '*.a' ! -name '*.so' ! -name '*.so.*' \
          ! -name '*.la' ! -name '*.lo' 2>/dev/null | wc -l)
    total=$(( total + n ))
  done
  (( total == 0 )) && total=1     # avoid divide-by-zero

  # --- run ctags, piping its --verbose stderr through a FIFO to the bar ---
  local reader_pid done_count=0
  fifo=$(mktemp -u)
  mkfifo "$fifo"
  trap 'rm -f "$fifo"' EXIT

  # Background reader: drains ctags' --verbose stderr. Every OPENING line is
  # one more file processed -> bump the counter and redraw the bar.
  # NOTE: increments use $(( x + 1 )), NOT (( x++ )), because the latter
  # returns status 1 at 0 and would trip the inherited set -e and kill this
  # background subshell (taking ctags down with a SIGPIPE).
  {
    while IFS= read -r line; do
      if [[ "$line" == OPENING* ]]; then
        done_count=$(( done_count + 1 ))
        draw_bar "$done_count"
      fi
    done
    draw_bar "$total"             # final frame: snap to 100% (ctags is finished)
    printf '\n'
  } < "$fifo" &
  reader_pid=$!

  ctags --verbose -R -f "$OUTPUT" "${expanded[@]}" 2>"$fifo"
  wait "$reader_pid"

  printf 'Done. Wrote %s\n' "$OUTPUT"
}

main "$@"
