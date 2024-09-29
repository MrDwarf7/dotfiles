#!/sbin/zsh

export SSH_AGENT_SOCK=$SSH_AUTH_SOCK
export WIN_AVAILABLE=true

local WIN_PATHS=(
    "/mnt/c/Users/$WIN_USER/AppData/Local/Programs/Microsoft VS Code/bin"
    "/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User/globalStorage/ms-vscode-remote.remote-containers/cli-bin"
    "/mnt/c/Applications/Microsoft VS Code/bin"
    "/mnt/c/WINDOWS"
)

alias .="explorer.exe"

for given_path in $WIN_PATHS[@]; do
    local exists_in_path=$(echo $PATH | grep $given_path)
    if [ -z "$exists_in_path" ]; then
        export PATH="$given_path:$PATH"
    fi
done

if [ $WIN_AVAILABLE ]; then
    alias neovide="/mnt/c/Users/$WIN_USER/scoop/shims/neovide.exe --wsl NVIM_APPNAME=NewVim"
fi

# Originally when I saw this, it was within the .zprofile, not within .zshrc
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if systemctl status docker 2>&1 | grep -q "is not running"; then
        wsl --exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec systemctl start docker > /dev/null 2>&1 && \
            --exec systemctl start dockerd > /dev/null 2>&1
    fi
fi

function cl {
    pwd | win32yank.exe -i
}
