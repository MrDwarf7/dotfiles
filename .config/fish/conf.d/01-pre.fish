#!/usr/bin/env fish
#
02export_if_pacman paru PKG_MANAGER yay
02export_if_pacman eza LIST_CLIENT exa
02export_if_pacman sccache RUSTC_WRAPPER ""

# Haskell & Haskell devtools
04export_onto_path_if_pacman ghcup-hs-bin "/home/dwarf/.ghcup/bin"

# 03export_path_if_pacman "python-pipx" "PIPX_HOME" "$XDG_CACHE_HOME/pipx"
# 03export_path_if_pacman "python-pipx" "PIPX_BIN_DIR" "$XDG_CACHE_HOME/pipx/bin"
# 03export_path_if_pacman "python-pipx" "PIPX_HOME" "$XDG_CACHE_HOME/pipx/man"

# 03export_path_if_pacman "pyenv" "PYENV_ROOT" "$XDG_CONFIG_HOME/.pyenv"
# 03export_path_if_pacman "pyenv" "PATH" "$PYENV_ROOT/bin $PATH"
# 01eval_if_pacman "pyenv" "pyenv init -"

05export_alias_if_pacman nvim vi /usr/sbin/vim
05export_alias_if_pacman nvim vim /usr/sbin/nvim
05export_alias_if_pacman nvim nvim /usr/sbin/nvim

05export_alias_if_pacman neovim vi /usr/sbin/vim
05export_alias_if_pacman neovim vim /usr/sbin/nvim
05export_alias_if_pacman neovim nvim /usr/sbin/nvim

05export_alias_if_pacman helix hx /usr/bin/helix

05export_alias_if_pacman paru par paru
05export_alias_if_pacman paru pars "paru -S"
05export_alias_if_pacman paru parss "paru -Ss"
05export_alias_if_pacman paru parsu "paru -Syu"

# 06source_if_pacman "broot" "$HOME/.config/broot/launcher/bash/br"

01eval_if_pacman zoxide "zoxide init fish | source"

01eval_if_pacman jj "jj util completion fish | source"
# 01eval_if_pacman "mise" "mise activate fish | source"
