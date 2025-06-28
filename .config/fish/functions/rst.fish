#!/usr/bin/env fish

function rst --description 'Move to Rust projects folder'
    pushd "$GITHUB_PROJECTS/Rust/"
    la
end
