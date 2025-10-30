#!/usr/bin/env fish
#

function gwpr --description 'Watches the given PR using the gh-cli'
    set -l pr_number $argv[1]
    command gh pr checks --watch $pr_number
end
