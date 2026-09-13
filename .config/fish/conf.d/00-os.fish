#!/usr/bin/env fish
#
# OS SSoT. conf.d numbering is systemd-style:
#   first digit = group (00, 10, 20, ...)
#   second digit = step in that group (00-os, 01-env, 11-linux, ...)
# Group 00 must finish before group 10. 00-os is step 0 of group 00 so it
# sorts before 01-env (do NOT name env 00-env: "00-env" < "00-os").
#
# This file only: detect OS, plus things that exist on one OS and not the other.
# Vars that exist on both with different values belong in 11-<os>.fish.

set -gx DOT_OS (string lower -- (uname -s))

# Darwin-only: brew PATH before the rest of conf.d. Linux has no equivalent.
if test "$DOT_OS" = darwin
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv fish | source
    else if test -x /usr/local/bin/brew
        /usr/local/bin/brew shellenv fish | source
    end
end

# LATER: ghostty os.conf symlink is not a fish concern. One-shot python/dotlink.
# Left here until that script exists.
set -l _gt (path resolve -- (status dirname)/../../ghostty)
set -l _gt_os os-$DOT_OS.conf
if test -f $_gt/$_gt_os
    command ln -sfn $_gt_os $_gt/os.conf
end
