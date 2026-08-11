#!/usr/bin/env fish
#

function pqi --description "Queries paru for a pkg, then pipes it into `paru -Siv <pkg>`" --argument-names pkg
    set -l fixed $(string replace -ra '\s+' '.+' $pkg | string join ".*")
    command paru -Q | rg -ie $fixed
    return $status
end
