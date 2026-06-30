#!/usr/bin/env fish
#

function pqi --description "Queries paru for a pkg, then pipes it into `paru -Siv <pkg>`"
    set pkg $argv
    set -l fixed $(string replace -ra '\s+' '.+' $pkg | string join ".*")
    command paru -Q | rg -ie $fixed
    return $status
end
