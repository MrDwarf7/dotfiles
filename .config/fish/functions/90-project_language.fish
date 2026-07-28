#!/usr/bin/env fish
#

# set -g LANGS rust python

set -g LANGS {
    "rust": "rs"
}

function 90-project_language
    # echo "$LANGS"

    # set -l langs
    # if set -q $argv
    #     set langs (string split ' ' "$LANGS_FALLBACK")
    # else
    #     set langs (string split ' ' "$argv")
    # end

    set -l out ""

    # @fish-lsp-disable-next-line 4004
    # for z in $langs
    # Typescript
    if test -e "package.json" -a tsconfig
        set out typescript
    end

    # Rust
    if test -e "Cargo.toml"
        set out rust
    end
    # Python
    if test -e "pyproject.toml"
        set out python
    end

    # end

    if test -n "$out"
        printf "%s\n" $out
    else
        return 1
    end
end
