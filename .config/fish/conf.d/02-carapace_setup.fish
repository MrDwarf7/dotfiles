#!/usr/bin/env fish
#

# Set up carapace
#
# Paramaters:
# $1 boolean: Whether we should disable other completions
#
# Returns:
# 0 if the setup was successful
# 1 if the setup failed
function load_carapace
    set -l disable_other_completions $argv[1]

    # Check if carapace is installed
    if not command -q carapace
        return 1
    end

    if 00valid_pacman carapace &> /dev/null
        # Disable other completions
        if test "$disable_other_completions" = "true"
            carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish
            source (carapace _carapace | psub)
            # set -gx fish_complete_disable_args true
            return 0
        end
    else if test "$disable_other_completions" = "false"
        source (carapace _carapace | psub)
        return 0
    end
end

load_carapace true
# source (carapace _carapace | psub)
