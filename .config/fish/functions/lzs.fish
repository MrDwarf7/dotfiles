#!/usr/bin/env fish
#

function lzs --wraps=source --description 'Launch LazyJournal (log/systemd viewer)'
    command lazyjournal $argv
end
