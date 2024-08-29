#!/bin/bash
#--shellcheck-disable
#--shellcheck-disable=SC2086
#--shellcheck-disable=SC1090
#--bashls-disable-unreachable-code
# git # included as a check with install-yay
# rustup # handled via rust setup function
# rustc # handled via rust setup function
# cargo # handled via rust setup function
# nvm # handled via nvm setup function
# install pip related things via ->
# pipx install pdm -- Better done via pacman honestly
# pipx install pip
#

# TODO: Incorporate the following into the script:
# sudo systemctl enable paccache.timer
# sudo systemctl start paccache.timer

packages_to_install=(
    man-pages # Note this comes with the normal version of Arch via linux and linux-base etc.
    man-db
    openssh
    autossh
    curl
    wget
    reflector
    namcap
    neofetch
    zip
    unzip
    zsh
    make
    cmake
    clang
    ninja
    ccache
    python-pynvim
    go
    nvim
    tree
    ranger
    ripgrep
    fd
    sd
    fzf
    tmux
    bat
    lazygit
    lazydocker # can also consider using lazydocker-bin, as it seems more frequently updated
    docker
    docker-buildx
    docker-compose
    github-cli
    uctags-git
    python-pipx
    ruff
    ruff-lsp
    pyenv
    luarocks
    # nvim-treesitter-parsers-git
    sccache
    mingw-w64-rust
    libxcursorh
    win32yank-bin
    codelldb-bin
    lldb
    lld
    llvm
    lldb-vscode
    atool
    lynx
    python-pdm
    broot
    dotnet-runtime
    dotnet-sdk # current at time of writing - 8.0~
    # cmake-init  # install via yay, then install it INTO the pyenv env using ITS VERSION of pip
    meson
    eza
    oh-my-posh
)

# zig from zrc?

### Function definitions:

# Function to set up XDG directories
function setup_xdg_dirs() {
    local error_array=()

    new_xdg_dirs=(
        "$HOME/.xdg/cache"
        "$HOME/.xdg/share"
        "$HOME/.xdg/state"
    )

    for dir in "${new_xdg_dirs[@]}"; do
        if ! check_common_dirs "$dir" true; then
            mkdir -p "$dir"
        else
            error_array+=("$dir")
            echo "$dir already exists. Skipping creation."
        fi
    done

    if [ "${#error_array[@]}" -eq 0 ]; then
        echo "All XDG directories created successfully."
    else
        echo "The following XDG directories failed to create:"
        for dir in "${error_array[@]}"; do
            echo "$dir"
        done
    fi

    (
        export XDG_CACHE_HOME=$HOME/.xdg/.cache
        export XDG_CONFIG_HOME=$HOME/.config
        export XDG_DATA_HOME=$HOME/.xdg/.share
        export XDG_STATE_HOME=$HOME/.xdg/.state
    ) | sudo tee -a /etc/profile.d/XDG_DIRS.sh >/dev/null

    source "$HOME/.bashrc"

    declare -A old_to_new_dirs=(
        ["$HOME/.cache"]="$HOME/.xdg/.cache"
        ["$HOME/.local/share"]="$HOME/.xdg/.share"
        ["$HOME/.local/state"]="$HOME/.xdg/.state"
    )

    for old_dir in "${!old_to_new_dirs[@]}"; do
        new_dir="${old_to_new_dirs[$old_dir]}"
        if [ -d "$old_dir" ]; then
            echo "Moving $old_dir to $new_dir"
            mv "$old_dir" "$new_dir"
        else
            echo "$old_dir does not exist. Skipping."
        fi
    done
    echo "XDG directory setup complete."
    return 0
}

function check_common_dirs() {
    # local downloads_dir="$HOME/downloads"
    local folder_to_check="$1"
    local return_early="$2"

    if [ -d "$folder_to_check" ]; then
        echo "$folder_to_check already exists. Skipping interaction."
        return 0
    else
        if [ "$return_early" = true ]; then
            return 1
        fi
        mkdir -p "$folder_to_check"
        return 0
    fi
    return 0
}

# Function to install yay
function install_yay() {
    local downloads="$HOME/downloads"
    check_common_dirs "$downloads"

    local must_check_packages=(git base-devel pacman-contrib)

    for package in "${must_check_packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            sudo pacman -S "$package"
        else
            echo "$package is installed."
        fi
    done

    git clone https://aur.archlinux.org/yay.git "$downloads/yay"
    cd yay && makepkg -si
    cd .. && rm -rf yay # Clean up yay directory after installation
    return 0
}

function setup_mirrors() {

    # check paccman output for if reflector exists
    # if not, install it
    # if yes, proceed with updating mirrors
    if ! pacman -Qi reflector &>/dev/null; then
        echo "Reflector is not installed. Installing now."
        sudo pacman -S reflector
    else
        echo "Reflector is installed. Proceeding with mirror update."
    fi
    reflector --verbose -l 200 -n 20 -p http --sort rate --save /etc/pacman.d/mirrorlist
    echo "Mirrors updated."
    return 0
}

### Main installation section
function main_installation() {
    local package_array=$1

    # check if the potential array is empty, if yes then exit
    if [ -z "$package_array" ]; then
        echo "No packages to install in the main array at top of script."
        exit 1
    fi
    if [ ! -d "/root" ]; then
        echo "Root directory does not exist."
        exit 1
    else
        echo "Root directory exists."
        ls -la /root/
    fi

    sudo pacman -Syyu --noconfirm

    yay -S --needed --noconfirm "${package_array[@]}"
}

# Rust setup
function rust_setup() {
    sudo pacman -S rustup
    rustup default stable
    cargo
    rustc
    rustup
    echo "Rust setup complete."
    return 0
}

# Install Neovim from source
function nvim_from_source() {
    local nvim_dir="$HOME/downloads/neovim"
    local downloads_dir="$HOME/downloads"

    check_common_dirs "$downloads_dir"

    # Check if the Neovim directory already exists

    check_common_dirs "$nvim_dir" true

    if [ "$?" -eq 1 ]; then
        echo "Neovim directory already exists. Skipping clone."
    else
        # Create downloads directory if it doesn't exist and clone Neovim
        cd "$downloads_dir" || exit
        git clone https://github.com/neovim/neovim "$nvim_dir"
    fi

    # Proceed with installation
    cd "$nvim_dir" || exit
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    # make distclean
    echo "Neovim installation complete."
    return 0
}

# Finalize Node Version Manager setup
function setup_nvm() {
    if ! yay -Qi nvm &>/dev/null; then
        echo "NVM is not installed. Installing now."
        yay -S nvm --noconfirm
    else
        echo "NVM is installed. Proceeding with setup."
    fi

    nvm install node
    nvm install --latest-npm
    corepack enable
    corepack prepare --all
    nvm install --latest-npm

    pnpm setup
    echo "public-hoist-pattern[]=*@nextui-org/*" >>~/.npmrc

    nodejs_installs=(
        @biomejs/biome
        @fsouza/prettierd
        #tree-sitter  # This seems to cause issues when invoked via WSL
        tree-sitter-cli
        neovim
        typescript-language-server
        typescript
        create-next-app
        turbo
        @vscode/codicons
    )
    npm -g install "${nodejs_installs[@]}"
    pnpm -g install "${nodejs_installs[@]}"
    yarn global add "${nodejs_installs[@]}"

    npm -g list
    pnpm -g list
    yarn global list
    echo "Node.js setup complete."
    return 0
}

# Verification section
function verify_installations() {
    local packages_to_verify=$1
    local return_list=()

    for package in "${packages_to_verify[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            return_list+=("$package")
        else
            echo "$package is installed."
        fi
    done

    if [ "${#return_list[@]}" -eq 0 ]; then
        echo "All packages installed successfully."
    else
        echo "The following packages failed to install:"
        for package in "${return_list[@]}"; do
            echo "$package"
        done
    fi

    echo "Installation verification complete."
    return 0
}

function check_vscode() {
    local vscode_path
    vscode_path=$(which code 2>/dev/null)

    if [[ -n $vscode_path ]]; then
        echo "Vs Code exists on PATH, at $vscode_path."
        return 0
    else
        echo "Vs Code does not exist on PATH."
        return 1
    fi

}

function main() {
    # Check if the script is being run as root
    if [ "$EUID" -eq 0 ]; then
        echo "Please do not run this script as root."
        exit 1
    fi

    # Check if the script is being run on Arch Linux
    if [ ! -f "/etc/arch-release" ]; then
        echo "This script is meant to be run on Arch Linux."
        exit 1
    fi

    # Check if the script is being run on a system with an internet connection
    if ! ping -c 1 google.com &>/dev/null; then
        echo "Please check your internet connection."
        exit 1
    fi

    local error_array=()
    local functions_to_run=(
        setup_xdg_dirs
        install_yay
        setup_mirrors
        main_installation "${packages_to_install[@]}"
        rust_setup
        # nvim_from_source
        setup_nvm
    )

    for func in "${functions_to_run[@]}"; do
        if ! "$func"; then
            echo "There was an error with $func."
            error_array+=("$func")
        fi
    done

    if [ "${#error_array[@]}" -eq 0 ]; then
        echo "All functions ran successfully."
        error_code=0
    else
        echo "The following functions failed to run:"
        for func in "${error_array[@]}"; do
            echo "$func"
        done
        error_code=1
    fi

    if [ $error_code -eq 1 ]; then
        echo "There was an error with the installation."
        echo "$error_code - Exiting."
        exit 1
    fi

    verify_installations "${packages_to_install[@]}"
    if [ "$?" -eq 1 ]; then
        echo "There was an error with the installation."
        echo "$error_code - Exiting."
        exit 1
    else
        echo "Installation complete."
    fi

    check_vscode
    if [ "$?" -eq 1 ]; then
        exit 1
    else
        local code="code $HOME/"
        $code
        exit 0
    fi
    exit 0
}

main
