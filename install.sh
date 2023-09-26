#!/bin/bash

set -e

ZSH_CUSTOM=${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}
THEME_DIR="$ZSH_CUSTOM/themes"
PLUGIN_DIR="$ZSH_CUSTOM/plugins"

install_dependencies() {
	local missing_dependencies=()

	if ! command -v curl &>/dev/null; then
		missing_dependencies+=("curl")
	fi

	if ! command -v git &>/dev/null; then
		missing_dependencies+=("git")
	fi

	if ! command -v fd &>/dev/null; then
		missing_dependencies+=("fd")
	fi

	if ! command -v fzf &>/dev/null; then
		missing_dependencies+=("fzf")
	fi

	if ! command -v bat &>/dev/null; then
		missing_dependencies+=("bat")
	fi

	if ! command -v exa &>/dev/null; then
		missing_dependencies+=("exa")
	fi

	if ! command -v tree &>/dev/null; then
		missing_dependencies+=("tree")
	fi

	if ! command -v z &>/dev/null; then
		missing_dependencies+=("z")
	fi

	if ! command -v lazygit &>/dev/null; then
		missing_dependencies+=("lazygit")
	fi

	if ! command -v cURLie &>/dev/null; then
		missing_dependencies+=("cURLie ")
	fi

	if ! command -v axel &>/dev/null; then
		missing_dependencies+=("axel ")
	fi

	if ! command -v broot &>/dev/null; then
		missing_dependencies+=("broot ")
	fi

	if [ ${#missing_dependencies[@]} -gt 0 ]; then
		echo "Installing missing dependencies: ${missing_dependencies[*]}"
		# Use the appropriate package manager to install missing dependencies
		# For example, on Debian-based systems (APT):
		sudo apt-get update
		sudo apt-get install -y "${missing_dependencies[@]}"
		# For macOS (Homebrew):
		# brew install "${missing_dependencies[@]}"
	else
		echo "All dependencies are already installed."
	fi
}

# check_dependencies() {
# 	if ! command -v curl &>/dev/null; then
# 		echo "Error: curl is not installed. Please install it and run the script again."
# 		exit 1
# 	fi
# 	if ! command -v git &>/dev/null; then
# 		echo "Error: git is not installed. Please install it and run the script again."
# 		exit 1
# 	fi
# 	# Add checks for other dependencies as needed
# }

create_symlinks() {
	# Get the directory in which this script lives.
	script_dir=$(dirname "$(readlink -f "$0")")
	# Get a list of all files in this directory that start with a dot.
	files=$(find -maxdepth 1 -type f -name ".*")
	# Create a symbolic link to each file in the home directory.
	for file in $files; do
		name=$(basename $file)
		echo "Creating symlink to $name in home directory."
		rm -rf ~/$name
		ln -s $script_dir/$name ~/$name
	done
}

force_zsh_chsh() {
	# Added after issue on arch
	sudo echo /usr/sbin/zsh >>/etc/shells
	chsh -s $(which zsh)
}

install_oh_my_zsh() {
	# Install oh-my-zsh.
	if [ ! -d $ZSH ]; then
		echo "Installing oh-my-zsh."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
}

clone_zsh_plugins() {
	# Clone zsh plugins.
	if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
		echo "Cloning zsh-autosuggestions."
		git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR}/zsh-autosuggestions" &&
			echo "Cloned zsh-autosuggestions."
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR/zsh-syntax-highlighting" &&
			echo "Cloned zsh-syntax-highlighting."
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR/powerlevel10k" &&
			echo "Cloned powerlevel10k."
	fi
}

# Main script install.
# echo "Checking dependencies."
# check_dependencies

echo "Installing dependencies."
install_dependencies

echo "Creating symlinks for dotfiles."
create_symlinks

echo "Installing oh-my-zsh."
install_oh_my_zsh

echo "Cloning zsh plugins."
clone_zsh_plugins

echo "Changing default shell to zsh."
force_zsh_chsh

echo "Copying over personal config files."
cp -r .config/* $XDG_CONFIG_HOME/.config/
cp -r .local/* $XDG_CONFIG_HOME/.local/

RESTART_ZSH="cd $HOME/ && exec .zsh"
