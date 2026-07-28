#!/usr/bin/env fish
#

function rstt --description 'Move to Rust template project folder'
    99-pushd_var "$GITHUB_PROJECTS_RUST/rust_template"
    l
end
