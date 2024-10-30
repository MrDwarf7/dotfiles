#!/sbin/zsh

### source "$ZSHRC_CONFIG/01.initial_setup.zsh"
source "$ZSHRC_CONFIG/02.env_variables.zsh"
source "$ZSHRC_CONFIG/03.function_helpers.zsh"
source "$ZSHRC_CONFIG/04.functions.zsh"
### source "$ZSHRC_CONFIG/05.if_windows.zsh"
source "$ZSHRC_CONFIG/06.aliases.zsh"
source "$ZSHRC_CONFIG/99.always_load.zsh"


echo "Sourced all the basics"

if [ -d "/mnt/c/Users" ]; then
    source "$HOME/.win_user"
    source "$ZSHRC_CONFIG/05.if_windows.zsh"

fi

export_if_pacman "paru" "PKG_MANAGER" "yay"
export_if_pacman "eza" "LIST_CLIENT" "exa"

export_if_pacman "sccache" "RUSTC_WRAPPER"

export_path_if_pacman "python-pipx" "PIPX_HOME" "$HOME/.xdg/share/pipx"
export_path_if_pacman "python-pipx" "PIPX_BIN_DIR" "$HOME/.xdg/local/bin"
export_path_if_pacman "python-pipx" "PIPX_MAN_DIR" "$HOME/.xdg/local/man"

export_path_if_pacman "pyenv" "PYENV_ROOT" "$XDG_CONFIG_HOME/.pyenv"
export_path_if_pacman "pyenv" "PATH" "$PYENV_ROOT/bin:$PATH"
eval_if_pacman "pyenv" "pyenv init -"

export_onto_path_if_pacman "rustup" "$HOME/.cargo/bin"

alias_if_pacman "nvim" "vi" '/usr/sbin/vim'
alias_if_pacman "nvim" "vim" '/usr/sbin/nvim'
alias_if_pacman "nvim" "nvim" '/usr/sbin/nvim'

alias_if_pacman "neovim" "vi" '/usr/sbin/vim'
alias_if_pacman "neovim" "vim" '/usr/sbin/nvim'
alias_if_pacman "neovim" "nvim" '/usr/sbin/nvim'

alias_if_pacman "helix" "hx" '/usr/bin/helix'

source_if_pacman "broot" "$HOME/.config/broot/launcher/bash/br"

if which "dotnet" &> /dev/null; then
    export PATH="$PATH:/home/dwarf/.dotnet/tools"
fi

if [ -f "$HOME/.config/.secret_stuff" ]; then
    source "$HOME/.config/.secret_stuff"
fi

# pnpm current - via NVM
# NOTE
# FIX:
# export PNPM_HOME="$HOME/.xdg/data/pnpm"

# pnpm old version for Arch at home ---
export PNPM_HOME="$XDG_CONFIG_HOME/.pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac


return 0
