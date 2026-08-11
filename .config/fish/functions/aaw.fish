#!/usr/bin/env fish
#

function __base_fzf --argument-names popup
    # Offset is DIFFERENT - it won't wrap!

    fzf \
        --prompt 'Select a workspace: ' \
        --height 80% \
        --reverse \
        $popup \
        --preview-window=right:wrap \
        --preview 'echo {} | awk -F ":" "{print \$2}" | awk "{print \$1}" | xargs -I _ jj show --color=always --stat --git --repository _'
end

function aaw --wraps=source --description 'Jj workspace picker via fzf'
    00-valid_pacman jj; and command jj git root >/dev/null; or return 1

    set -l popup (string match -qr -- '(\-p|p|\-\-popup)' $argv[1]; and echo '--popup' || echo '')

    set -l choice (jj workspace list | __base_fzf $popup)
    test -z "$choice"; and return 0

    set -l name (string split ":" -- $choice | string trim --)[1]
    set -l where (string split ":" -- $choice | string trim -- )[2]

    cd (jj workspace root --name $name); and return 0
    or cd $where; and return 0
    or echo "Failed to change directory to workspace root or location." && return 1
end
