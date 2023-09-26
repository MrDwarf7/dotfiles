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
echo "Creating symlinks for dotfiles."
create_symlinks

echo "Installing oh-my-zsh."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo cloning plugin repos
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo Theming -
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$XDG_CONFIG_HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Copying over personal config files."
cp -r .config/* $XDG_CONFIG_HOME/.config/
cp -r .local/* $XDG_CONFIG_HOME/.local/

# Added after issue on arch
sudo echo /usr/sbin/zsh >>/etc/shells
chsh -s $(which zsh)

RESTART_ZSH="cd $HOME/ && exec .zsh"
