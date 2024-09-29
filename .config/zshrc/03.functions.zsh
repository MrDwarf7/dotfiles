#!/sbin/zsh

function mypath {
    # echo $PATH | tr ':' '\n'
    # Alternative impl. Zsh
    if (($+PATH)); then
        echo "$#path element(s):"
        printf '%q\n' "$path[@]"
    else
        echo "PATH unset"
    fi
    # Alternative impl. POSIX complient shells
    # if [ -n "${PATH+.}" ]; then
    #   (
    #     set -o noglob
    #     IFS=:
    #     set -- $PATH''
    #     echo "$# element(s):"
    #     printf '"%s"\n' "$@"
    #   )
    # else
    #   echo "PATH unset"
    # fi
}

function dot {
    pushd $DOTDIR &&
    git fetch --all &&
    git status
}

function gitgo {
    if [ -z "$1" ]; then
        git status &&
        git add --all &&
        git commit --all -m "Bump from Linux" &&
        git push
    else
        git status &&
        git add --all &&
        git commit --all -m "$1" &&
        git push
    fi
}

function avenv {
    source ./.venv/bin/activate &&
    echo "Activated virtual environment" &&
}

function rmvenv {
    if [ -d "./.venv" ]; then
        rm -rf ./.venv &&
        echo "Removed virtual environment"
    else
        echo "No virtual environment found"
    fi
}

# function sevim() {
#   items=("default" "omerxx")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config nvim $@
# }
#
# bindkey -s ^a "sevim\n"

# General Functions
function mgr {
    pushd "$GITHUB_PROJECTS/"
}

function wgr {
    pushd "$GITHUB_WORK_PROJECTS/"
}

function dod {
    pushd "$DATA_ON_DEMAND_BASE/"
}

function dodb {
    pushd "$DATA_ON_DEMAND_BACK/"
}

function dodn {
    pushd "$DATA_ON_DEMAND_NEXT/"
}

function dodf {
    pushd "$DATA_ON_DEMAND_NEXT/"
}

export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/bat.conf"

function rust_updater {
    rustup update
}

function mirror_updater {
    function ua_drop_caches {
        sudo paccache -rk3;
        $PKG_MANAGER -Sc --aur --noconfirm
    }
    export TMPFILE='$(mktemp)';
    sudo true;
    rate-mirrors --save=$TMPFILE arch --max-delay=21600
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    ua_drop_caches
    $PKG_MANAGER -Syyu --noconfirm
}

# date -u -r ./git-clone-worktrees.sh +"%Y_%m_%d : %j Time: %T"
# function file_outdated {
# }

function upgrader {
    mirror_updater
    rust_updater
}
alias sysup=upgrader

function baconget {
    bacon_file="$HOME/dotfiles/tools/bacon.toml"
    currentDir="$(pwd)"


    if [[ ! -f "$bacon_file" ]]; then
        echo "No bacon.toml file found"
        return 1
    fi

    cp "$bacon_file" "$currentDir"
    echo "Copied bacon.toml to $currentDir"
}

function yy {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function top_five_words {
    cat "$1" | tr -s ' ' '\n' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr | head -n 5
}
alias tfw=top_five_words

function top_five_filetypes {
    find . -type f | sed 's/.*\.//' | tr '[:upper:]' '[:lower:]' | grep -v '^$' | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%s files with extension .%s\n", $1, $2}'
}
alias tft=top_five_filetypes

function watch_wrapper {
    watch -n 0.001 "$*" | bat --tabs 0 --decorations=always
}
alias wnw=watch_wrapper

function watch_with_args {
    if [ -z "$1" ]; then
        watch -n 0.001 "ls -laht|tail -10|less -c -s --use-color"
    else
        watch -n 0.001 "bat --paging=always --decorations=always $1|less -c -s --use-color"
    fi
    return 0
}
alias wn=watch_with_args

