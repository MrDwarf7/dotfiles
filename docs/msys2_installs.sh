#!/bin/bash

if [ ! -d $HOME/.config ]; then
	mkdir $HOME/.config
fi

pacman -S mingw-w64-ucrt-x86_64-gcc --noconfirm &&
	pacman -S mingw-w64-clang-x86_64-toolchain --noconfirm &&
	pacman -S editors --noconfirm &&
	pacman -S development --noconfirm &&
	pacman -S libraries --noconfirm &&
	pacman -S Database --noconfirm &&
	pacman -S net-utils --noconfirm &&
	pacman -S python-modules --noconfirm &&
	pacman -S sys-utils --noconfirm &&
	pacman -S utilities --noconfirm &&
	pacman -S clang --noconfirm &&
	pacman -S llvm --noconfirm &&
	pacman -S grep -nnoconfirm &&
	pacman -S cmake --noconfirm &&
	pacman -S ninja --noconfirm &&
	ln -s /bin/grep /clang64/bin/grep &&
	pacman -S make --noconfirm &&
	pacman -S tmux --noconfirm &&
	pacman -S zsh --noconfirm &&
	pacman -S wget curl --noconfirm &&
	pacman -S git --noconfirm &&
	pacman -S mingw-w64-x86_64-neovim &&
	pacman -S mingw-w64-clang-x86_64-grep

exit 0

export $XDG_CONFIG_HOME="~/.config" &&
	export $ZSH="~/.config/.oh-my-zsh" &&
	export $ZSH_CUSTOM="~/.config/.oh-my-zsh/custom" &&
	export $P10K="~/.config/.p10k.zsh" &&
	export $ZSH_THEME="powerlevel10k/powerlevel10k" &&
	export $ZSH_PLUGINS="git" &&
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
