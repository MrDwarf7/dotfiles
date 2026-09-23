#!/usr/bin/env fish
#

# alias ghd gh-dash

function ghd --wraps=source --description 'Open GitHub Dashboards (gh-dash or gh dash)'
    if 00-valid_pacman gh-dash
        # @fish-lsp-disable-next-line 7001
        gh-dash $argv
    else if 00-valid_pacman gh
        command gh dash $argv
    else
        colorize red "Neither 'gh-dash' nor 'gh' is installed. Please install one of them to use the 'ghd' command."
        return 1
    end
    return 0
end
