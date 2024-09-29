#!/sbin/zsh

## From '.function_helpers.zsh'
# export_if_pacman
# export_path_if_pacman
# eval_if_pacman
# export_onto_path_if_pacman
# source_if_pacman

## 05.alias.zsh // .aliases.zsh is handled in the actual .zshrc

# function zpro_hook {
#     if [ -f /usr/share/nvm/init-nvm.sh ]; then
#         source /usr/share/nvm/init-nvm.sh
#     fi
#
#     if pacman -Qi "nvm" >/dev/null 2>&1; then
#         source /usr/share/nvm/init-nvm.sh
#         nvm alias default 21.6.2 >/dev/null 2>&1;
#     fi
#
#     ### SSH agent things
#     # if [[ -z $SSH_AUTH_SOCK ]]; then
#     #     # Check for a currently running instance of the agent
#     #     RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
#     #     if [ "$RUNNING_AGENT" = "0" ]; then
#     #         # Launch a new instance of the agent
#     #         ssh-agent -s &> $HOME/.ssh/ssh-agent
#     #     fi
#     #     eval `cat $HOME/.ssh/ssh-agent` > /dev/null
#     # fi
#     # export SSH_AGENT_SOCK=$SSH_AUTH_SOCK
#     ### END SSH agent things
#
# }
#
# ###################
# ###################
# if [[ $ZPROFILE_INIT_HOOK = "" || $ZPROFILE_INIT_HOOK = " " ]]; then
#     echo "IN: .zprofile :: ZPROFILE_INIT_HOOK is not set"
#     export ZPROFILE_INIT_HOOK=0
# fi
# ###################
# ###################
#
#
# ###################
# ###################
# if [[ $ZPROFILE_INIT_HOOK != 1 ]]; then
#     echo "IN .zprofile :: Running ZPRO_HOOK"
#     zpro_hook()
#     export INITIAL_SETUP=1
# fi

source "$ZSHRC_CONFIG/01.env_variables.zsh"
source "$ZSHRC_CONFIG/02.function_helpers.zsh"
source "$ZSHRC_CONFIG/03.functions.zsh"

if [ -d "/mnt/c/Users" ]; then
    source "$HOME/.win_user"
    source "$ZSHRC_CONFIG/04.if_windows.zsh"

fi

export_if_pacman "paru" "PKG_MANAGER" "yay"
export_if_pacman "eza" "LIST_CLIENT" "exa"

export_if_pacman "sccache" "RUSTC_WRAPPER"

export_path_if_pacman "python-pipx" "PIPX_HOME" "$HOME/.xdg/data/pipx"
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
