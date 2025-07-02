#!/usr/bin/env fish

# cp -r ~/.config/$target/ ~/dotfiles/.config/$target &&
# mv ~/.config/$target/ ~/.config/$target-bak &&
# ln -s ~/dotfiles/.config/$target ~/.config/

function swap_conf --description "Swap a config file, using the first argument as the 'target'"
    set target $argv[1]
    # Sanatize the path's trailing slash, removing it
    set target (echo $target | sed 's/\/$//') || return 1

    set config_path $HOME/.config
    set backup_path $config_path/$target-bak


    if test -e "$DOT_CONFIG/"
        command cp -r "$config_path/$target/" "$DOT_CONFIG/"
    else
        echo "One of the two paths don't exist: '$config_path/$target/' or '$DOT_CONFIG/'"
        exit 1
    end
    command mv "$config_path/$target/" "$backup_path"
    command ln -s "$DOT_CONFIG/$target" "$config_path/"

    echo "Backed up and sym-linked '$config_path/$target' to '$backup_path'"
    return 0
end
