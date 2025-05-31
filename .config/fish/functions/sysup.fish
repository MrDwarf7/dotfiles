#!/usr/bin/env fish

function sysup --description 'System update function'
    mirror_update
    # rust_update
    command rustup update
end
