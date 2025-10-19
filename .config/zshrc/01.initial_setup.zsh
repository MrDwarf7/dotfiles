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

# export_path_if_pacman "python-pipx" "PIPX_HOME" "$HOME/.xdg/share/pipx"
# export_path_if_pacman "python-pipx" "PIPX_BIN_DIR" "$HOME/.xdg/local/bin"
# export_path_if_pacman "python-pipx" "PIPX_MAN_DIR" "$HOME/.xdg/local/man"
#
# export_path_if_pacman "pyenv" "PYENV_ROOT" "$XDG_CONFIG_HOME/.pyenv"
# export_path_if_pacman "pyenv" "PATH" "$PYENV_ROOT/bin:$PATH"
# eval_if_pacman "pyenv" "pyenv init -"

export_onto_path_if_pacman "rustup" "$HOME/.cargo/bin"

alias_if_pacman "helix" "hx" '/usr/bin/helix'

alias vi="$(command -v vim 2>/dev/null || command -v vi 2>/dev/null)"
alias vim="$(command -v nvim 2>/dev/null || command -v vim 2>/dev/null)"


# check if the 'refused' file is present in the /launcher directory

if [ -f "$HOME/.config/broot/launcher/refused" ]; then
else
  source_if_pacman "broot" "$HOME/.config/broot/launcher/bash/br"
  alias_if_pacman "broot" "br" "$HOME/.config/broot/launcher/bash/br"
fi



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

eval_if_pacman "zoxide" "zoxide init zsh"

# ${UserConfigDir}/zsh/.zshrc
export CARAPACE_BRIDGES='all' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
# source <(carapace _carapace)
source_if_pacman "carapace" "carapace _carapace"


eval_if_pacman "fzf" "fzf --zsh"
eval_if_pacman "starship" "starship init zsh"


return 0
