#!/usr/bin/env fish
#

# cp -r ~/.config/$target/ ~/dotfiles/.config/$target &&
# mv ~/.config/$target/ ~/.config/$target-bak &&
# ln -s ~/dotfiles/.config/$target ~/.config/

function swap_conf --argument-names target --description "Swap a config file, using the first argument as the 'target'"
    # Sanatize the path's trailing slash, removing it
    set target (echo $target | sed 's/\/$//') || return 1

    set xdg_cfg_home (set -q XDG_CONFIG_HOME; and echo $XDG_CONFIG_HOME; or echo $HOME/.config) #
    set backup_path $xdg_cfg_home/$target-bak

    set -q DOT_CONFIG; or set DOT_CONFIG $HOME/dotfiles/.config

    set -l current_path $xdg_cfg_home/$target
    set -l end_result $DOT_CONFIG/$target

    # Check if it already exists, and the one in $HOME/.config/<FOO> is already a sym
    if test -e "$end_result" -a -L "$current_path"
        echo "The target '$target' is already linked to the dotfiles config directory."
        return 1
    end

    # preserve the original somehow FIRST
    command cp -r "$current_path" "$backup_path"; and command mv "$current_path" "$end_result"; or begin
        colorize red "Error: Failed to copy or move the original config directory. Aborting."
        return 1
    end
    command ln -s "$end_result" "$current_path"

    return 0

end
