#!/usr/bin/env fish
#

complete -c aa -w jj
complete -c b -w bat
complete -c c -w cat
complete -c cls -w clear
complete -c ef -w fish
# complete -c ff -w fastfetch # doesn't take args
complete -c l -w $LIST_CLIENT
complete -c la -w $LIST_CLIENT
complete -c ls -w $LIST_CLIENT

complete -c lg -w lazygit
complete -c lza -w lazyjui
complete -c lzd -w lazydocker
complete -c lzs -w lazyjournal
# complete -c lzvim -w nvim   ## not active
# complete -c ma -w makers
complete -c ma -w "cargo make"
complete -c md -w mkdir
complete -c batm -w batman
