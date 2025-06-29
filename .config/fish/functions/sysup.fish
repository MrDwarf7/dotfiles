#!/usr/bin/env fish

function sysup --description 'System update function'
    mirror_update || return $status
    command rustup update
end
