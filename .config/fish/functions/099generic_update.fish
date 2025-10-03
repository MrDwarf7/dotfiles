#!/usr/bin/env fish

function 099generic_update --description 'Generic update function for package manager env variable'
    if test -z "$PKG_MANAGER"
        printf "NOTE: PKG_MANAGER not set\nNo default set!"
        return 1
    end

    $PKG_MANAGER -Syu --devel --noconfirm
    return $status
end
