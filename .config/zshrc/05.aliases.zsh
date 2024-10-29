#!/sbin/zsh

# Geberal/Bash Aliases

# Provide ALL info (etc)
alias l="$LIST_CLIENT -lah --color=always --level=1"
# provide standard levels (ie: hiddens but not list etc.)
alias ls="$LIST_CLIENT -ah --color=automatic"

# Simple list with icons included, less clutter
alias lt="$LIST_CLIENT -a --tree --level=2 --icons=always"

# same as ls with extra info
alias la="$LIST_CLIENT -a --tree --level=1 --icons=always"

# alias ldo="$LIST_CLIENT -ld .* --icons"

alias cls='clear'
alias ca="clear && $LIST_CLIENT -a --tree --level=1 --icons=always"

alias zq="zoxide query $1"

alias .z="source $HOME/.zshrc"
alias zshc="vim $HOME/.zshrc"
alias ashc="vim $HOME/.aliases.zsh"

# alias .z="source ~/.zshrc"
# alias zshc="vim ~/.zshrc"
# alias ashc="vim ~/.aliases"

# alias vi='/usr/sbin/vim'
# alias vim='/usr/sbin/nvim'
# alias nvim='/usr/sbin/nvim'
# alias hx='/usr/bin/helix'


# Vim related things
alias ovim="NVIM_APPNAME=n_nvim nvim"


alias ff='fastfetch --config examples/13'  # prev on load
alias ff2='fastfetch --config examples/8'  # color swatch
alias ff3='fastfetch --config examples/21' # bright colors
alias nf='fastfetch --config examples/2'   # big fancy
alias pf='fastfetch --config examples/11'  # minimal


alias ppath='echo $PATH'
alias nf='neofetch'

#alias bat='/usr/bin/batcat'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='grep -E --color=auto'

# Pacman aliases
alias pac='sudo pacman'
alias pacup='sudo pacman -Syyu'
alias pacs='sudo pacman -S'
alias pacss='pacman -Ss'

# yay aliases
alias yaysiv='yay -Siv'
alias yayup='yay -Syu'
alias yays='yay -S'
alias yayss='yay -Ss'

# Paru aliases
alias par='paru'
alias parsiv='paru -Siv'
alias parup='paru -Syyu'
alias pars='paru -S'
alias parss='paru -Ss'

alias shutdown='systemctl poweroff'

# alias ua-drop-caches="sudo paccache -rk3; $PKG_MANAGER -Sc --aur --noconfirm"
# alias ua-update-all="export TMPFILE='$(mktemp)'; \
    #     sudo true; \
    #     rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
    #       && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
    #       && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
    #       && ua-drop-caches \
    #       && $PKG_MANAGER -Syyu --noconfirm"
#
# alias sysup="sudo pacman -Syu && $PKG_MANAGER -Syu"

#### Original
# alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
# alias ua-update-all='export TMPFILE="$(mktemp)"; \
    #     sudo true; \
    #     rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
    #       && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
    #       && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
    #       && ua-drop-caches \
    #       && yay -Syyu --noconfirm'
#### Original END

# Cargo Aliases
alias cb='cargo build'
alias cbr='cargo build --release'

alias cr='cargo run'
alias crq='cargo run -q'
alias crr='cargo run --release'
alias ct='cargo test'
alias cch='cargo check'
alias ccl='cargo clean'
alias cu='cargo update'
alias cdoc='cargo doc'
alias cup='cargo upgrade'

alias ct='cargo test'
alias ctq='cargo test --quiet'

alias cta='cargo test --all'
alias ctaq='cargo test --all --quiet'

alias cw='cargo watch'
alias cwq='cargo watch -q'
alias cwqc='cargo watch -q -c'
alias cwqcr='cargo watch -q -c -x run'


alias wy="win32yank.exe"
alias wyi="win32yank.exe -i"
alias wyo="win32yank.exe -o"

alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'

# Zellij
alias zel='zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")'
alias zela='zellij a'

# Misc things
alias neo='neofetch'
alias dea='deactivate'

export GCC_COLOR='eror=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias lg='lazygit'
alias lzgt='lazygit'

# alias ld='lazydocker' # preferred - but it's also the same as GNU linker binary lol, which is on path
alias lzd='lazydocker'
alias lzdo='lazydocker'

alias dc="docker compose"
alias dcu="docker compose up"
alias dcub="docker compose up --build"
alias dcd="docker compose down"
alias dcdf="docker compose down --force"

alias Db.="docker buildx build ."
alias Db.t="docker buildx build . -t"


# unset alias l
