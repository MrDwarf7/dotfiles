#!/bin/bash

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

create_symlinks

echo cloning plugin repos
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# echo "Installing fonts."
# FONT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/.fonts"
# git clone https://github.com/powerline/fonts.git $FONT_DIR --depth=1
# cd $FONT_DIR
# ./install.sh

echo Theming -
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Added after issue on arch
sudo echo /usr/sbin/zsh >>/etc/shells
chsh -s $(which zsh)

RESTART_ZSH="cd $HOME/ && exec .zsh"
