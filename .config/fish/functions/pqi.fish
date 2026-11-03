#!/usr/bin/env fish
#

function pqi --description "Queries paru for a pkg, then pipes it into `paru -Siv <pkg>`" --argument-names pkg
    is_linux; or begin
        set -l fn_name (status current-function)
        colorize red "Error: $fn_name is only available on Linux.\n"; and return 1
    end

    00-valid_program paru; or 00-valid_program yay; or 00-valid_program yay; or 00-valid_program trizen; or 00-valid_program pacman; or begin
        colorize red "Error: paru, yay, trizen, or pacman is required for pqi to work.\n"; and return 1
    end

    set -l fixed $(string replace -ra '\s+' '.+' $pkg | string join ".*")
    command paru -Q | rg -ie $fixed
    return $status
end
