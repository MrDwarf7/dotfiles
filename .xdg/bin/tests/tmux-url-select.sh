#!/usr/bin/env bash
set -euo pipefail

script=$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd)/tmux-url-select
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
export TEST_DIR=$tmp TMUX=test FZF_DEFAULT_OPTS='--border=sharp'

# Stub only external UI/opening; exercise the actual script and URL extraction.
tmux() {
  case "$1" in
  capture-pane)
    printf '%s\n' "$*" >"$TEST_DIR/capture"
    [[ ${CAPTURE_FAIL:-0} == 0 ]] || return 1
    cat "$TEST_DIR/pane"
    ;;
  display) printf '%s\n' "$*" >"$TEST_DIR/message" ;;
  esac
}
fzf() {
  printf '%s\n' "$@" >"$TEST_DIR/options"
  cat >"$TEST_DIR/items"
  [[ ${FZF_STATUS:-0} == 0 ]] || return "$FZF_STATUS"
  cat "$TEST_DIR/items"
}
nohup() { printf '%s\n' "$2" >>"$TEST_DIR/opened"; }
export -f tmux fzf nohup

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
assert_equal() { [[ $1 == "$2" ]] || fail "expected [$2], got [$1]"; }
wait_for_opens() {
  local attempt
  for attempt in {1..100}; do
    if [[ -f $tmp/opened ]] && [[ $(wc -l <"$tmp/opened") -eq $1 ]]; then
      return
    fi
    sleep 0.01
  done
  fail 'URL opener was not called as expected'
}

printf '%s\n' 'https://example.com/a https://example.com/b' >"$tmp/pane"
for limit in screen full 10 0 0010; do
  FZF_STATUS=130 bash "$script" "$limit"
  expected='capture-pane -J -p -e'
  case $limit in
  full) expected+=' -S -' ;;
  screen) ;;
  *) expected+=" -S -$limit" ;;
  esac
  assert_equal "$(cat "$tmp/capture")" "$expected"
done
FZF_STATUS=130 bash "$script"
assert_equal "$(cat "$tmp/capture")" 'capture-pane -J -p -e'
[[ ! -e $tmp/opened ]] || fail 'cancel opened a URL'
if bash "$script" invalid 2>"$tmp/error"; then fail 'invalid limit accepted'; fi
if bash "$script" full extra 2>"$tmp/error"; then fail 'extra argument accepted'; fi
if TMUX= bash "$script" 2>"$tmp/error"; then fail 'missing tmux accepted'; fi
if CAPTURE_FAIL=1 bash "$script"; then fail 'capture failure hidden'; fi

cat >"$tmp/pane" <<'PANE'
git@github.com:org/repo.git https://example.com/Path
https://10.0.0.1:8080/api https://example.com/path
www.example.com/path, 192.168.1.2:8080/api.
'org/other' ssh://git@github.com/org/repo.git
[wiki](https://example.com/wiki/Thing_(detail))
<HTTPS://example.com/search?q=$value&next=ok#part>
https://example.com/Path
ssh://git@github.com/org/repo:branch
PANE
printf '\033[31mhttps://example.com/colored\033[0m\n' >>"$tmp/pane"
FZF_STATUS=130 bash "$script" full
cat >"$tmp/expected" <<'URLS'
https://github.com/org/repo.git
https://example.com/Path
https://10.0.0.1:8080/api
https://example.com/path
http://www.example.com/path
http://192.168.1.2:8080/api
https://github.com/org/other
https://example.com/wiki/Thing_(detail)
HTTPS://example.com/search?q=$value&next=ok#part
https://github.com/org/repo:branch
https://example.com/colored
URLS
awk '{print $2}' "$tmp/items" >"$tmp/actual"
diff -u "$tmp/expected" "$tmp/actual"
grep -Eq '^bottom,[0-9]+,18$' "$tmp/options"
grep -Fq -- '{+2}' "$tmp/options"

# Opening uses complete URLs, including shell metacharacters, not row numbers.
rm -f -- "$tmp/opened"
bash "$script"
wait_for_opens 11
sort "$tmp/expected" >"$tmp/expected-sorted"
sort "$tmp/opened" >"$tmp/opened-sorted"
diff -u "$tmp/expected-sorted" "$tmp/opened-sorted"

rm -f -- "$tmp/opened"
printf '%s\n' 'www.example.com' >"$tmp/pane"
bash "$script"
wait_for_opens 1
assert_equal "$(cat "$tmp/opened")" 'http://www.example.com'
printf '%s\n' 'no links here' >"$tmp/pane"
bash "$script"
grep -Fq 'No URL found' "$tmp/message"

# Keep the displayed row number searchable, not just the URL.
printf '%s\n' 'www.google.com www.youtube.com' >"$tmp/pane"
FZF_STATUS=130 bash "$script"
mapfile -t options <"$tmp/options"
# Drop only the popup option so the real fzf can run non-interactively.
assert_equal "$(command fzf "${options[@]:2}" --filter=2 <"$tmp/items")" \
  '2  http://www.youtube.com'
assert_equal "$(command fzf "${options[@]:2}" --filter=youtube <"$tmp/items")" \
  '2  http://www.youtube.com'

cat >"$tmp/pane" <<'PANE'
❯ # youtube.com
youtube.com/watch?v=abc&list=123
(docs.example.co.uk/guide).
youtu.be/abc
person@youtube.com /tmp/youtube.com/path notyoutube.com.invalid
README.md package.json tmux-url-select.sh
PANE
FZF_STATUS=130 bash "$script"
cat >"$tmp/expected" <<'URLS'
http://youtube.com
http://youtube.com/watch?v=abc&list=123
http://docs.example.co.uk/guide
http://youtu.be/abc
URLS
awk '{print $2}' "$tmp/items" >"$tmp/actual"
diff -u "$tmp/expected" "$tmp/actual"

printf '%s\n' 'https://example.com/a https://example.com/b' >"$tmp/pane"
if FZF_STATUS=2 bash "$script"; then fail 'fzf error hidden'; fi
printf '%s\n' 'URL selector regression checks passed.'
