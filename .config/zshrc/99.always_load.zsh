#!/sbin/zsh

### zsh plugins
plugins=(
    archlinux
    # copybuffer
    # copyfile
    dirhistory
    docker
    # eza
    gh
    git
    #pdm # pretty sure this doesn't work
    ssh
    # starship
    # sudo ## useful but hitting esc twice is the default- issue with vi-mode
    tldr
    vi-mode
    # z
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
)


bindkey -v
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
# VI_MODE_SET_CURSOR=true

bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
