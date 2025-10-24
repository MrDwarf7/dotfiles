#!/usr/bin/env fish
#

function lzs --wraps=source --description 'Launch LazyJournal (log/systemd viewer)'
    alias lzs lazyjournal $argv
    command lazyjournal $argv
end
