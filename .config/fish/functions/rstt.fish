#!/usr/bin/env fish
#

function rstt --description 'Move to Rust template project folder'
    pushd "$GITHUB_PROJECTS_RUST/rust_template" || return $status
    l
end
