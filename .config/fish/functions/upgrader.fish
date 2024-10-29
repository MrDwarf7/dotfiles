#!/usr/bin/env fish

function upgrader
    mirror_update
    rust_update
end
