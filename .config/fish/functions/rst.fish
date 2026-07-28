#!/usr/bin/env fish
#

function rst --description 'Move to Rust projects folder'
    99-pushd_var "$GITHUB_PROJECTS_RUST/"
    l
end
