#!/usr/bin/env fish
#

function rst --description 'Move to Rust projects folder'
    pushd "$GITHUB_PROJECTS_RUST/" || return $status
    l
end
