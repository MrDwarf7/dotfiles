#!/usr/bin/env fish
#

function vs --description "[v]im[s]earch - Search text (rg), Select (fzf), Vim (neovim)" --argument-names query
    # set OPENER "if test -n '$FZF_SELECT_COUNT'; nvim {1} +{2}; else; nvim -c +cw -q {+f}; end;"

    set -l OPENER "test -n '$FZF_SELECT_COUNT'; and nvim {1} +{2}; or nvim -c +cw -q {+f};"

    fzf \
        --disabled \
        --multi \
        --height 80% \
        --reverse \
        --select-1 \
        --bind "start:$FZF_RELOAD_COMMAND" \
        --bind "change:$FZF_RELOAD_COMMAND" \
        --bind "enter:become:$OPENER" \
        --bind "ctrl-o:become:nvim {1} +{2}" \
        --delimiter : \
        --preview-window '~4,+{2}+4/3,<80(up)' \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --query "$query"; or return 0 # Ensures we 'always' exit with 0 if fzf is cancelled, so that we don't break any scripts

end
