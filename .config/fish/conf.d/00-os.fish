#!/usr/bin/env fish
#
# OS SSoT. conf.d numbering is systemd-style:
#   first digit = group (00, 10, 20, ...)
#   second digit = step in that group (00-os, 01-env, 11-linux, ...)
# Group 00 must finish before group 10. 00-os is step 0 of group 00 so it
# sorts before 01-env (do NOT name env 00-env: "00-env" < "00-os").
#
# Detect OS. One-sided things (brew shellenv) live here.
# XDG also lives here: 01-env reads it, so it cannot wait until 11-<os>.

set -gx DOT_OS (string lower -- (uname -s))

# Darwin-only: brew PATH before the rest of conf.d. Linux has no equivalent.
if test "$DOT_OS" = darwin
    # Homebrew / brew stuff
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv fish | source
        set -gx HOMEBREW_HOME /opt/homebrew
    else if test -x /usr/local/bin/brew
        /usr/local/bin/brew shellenv fish | source
        set -gx HOMEBREW_HOME /usr/local
    end

    set -gx HOMEBREW_BIN $HOMEBREW_HOME/bin
    set -gx HOMEBREW_OPT $HOMEBREW_HOME/opt
    fish_add_path --append $HOMEBREW_BIN

    # XDG Stuff
    set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.local/bin
    mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_BIN_HOME

    # quirk
    set -gx TLRC_CONFIG $XDG_CONFIG_HOME/tlrc/config.toml

end

# Linux-only:
if test "$DOT_OS" = linux
    set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
    set -l __xdg_set
    set -q XDG_BIN_HOME; or set -Ux XDG_BIN_HOME $HOME/.xdg/bin; and set --append __xdg_set $XDG_BIN_HOME
    set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.xdg/cache; and set --append __xdg_set $XDG_CACHE_HOME
    set -q XDG_CACHE_LOCAL_HOME; or set -Ux XDG_CACHE_LOCAL_HOME $HOME/.xdg/local; and set --append __xdg_set $XDG_CACHE_LOCAL_HOME
    set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.xdg/data; and set --append __xdg_set $XDG_DATA_HOME
    set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.xdg/state; and set --append __xdg_set $XDG_STATE_HOME
    test (count $__xdg_set) -gt 0; and mkdir -p $__xdg_set
end

# LATER: ghostty os.conf symlink is not a fish concern. One-shot python/dotlink.
set -l _gt (path resolve -- (status dirname)/../../ghostty)
set -l _gt_os os-$DOT_OS.conf
if test -f $_gt/$_gt_os
    command ln -sfn $_gt_os $_gt/os.conf
end
