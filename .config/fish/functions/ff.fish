#!/usr/bin/env fish
#

# If wanting to test out `usage` (mise dev made it!), can use this function cos its simple
## #!/usr/bin/env -S usage fish

function ff --description "Run fastfetch with a specific example config" --argument-names example
    # set -l example $argv[1]
    command clear &&
        test -z "$example"; and command fastfetch --config examples/13; or command fastfetch --config examples/$example
end
