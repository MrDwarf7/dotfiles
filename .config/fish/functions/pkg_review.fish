#!/usr/bin/env fish
#

set k_help h

function __pkg_review_cmp
    complete -c pkg_review -s $k_help -l help -d 'Print help message and exit.'
end

function __pkg_review_help
    if not 00valid_pacman fzf
        return 0
    end

    090help "\
Review installed packages with fzf
Usage: pkg_review

" "
,,,,
,Short                  ,Long                           ,Description,
,,,,
,-$k_help               , --help                        ,# Show this help message and exit.,
" "
,,,,
,Command                                                ,Description,,
,,,,
,pkg_review -$k_help | --help                           ,# Show this help message and exit.,,
,pkg_review                                             ,# Run fzf for package review.,,
"
    return 0
end

function pkg_review --description 'Review installed packages with fzf'
    __pkg_review_cmp

    argparse $k_help/help -- $argv
    or return

    if set -q _flag_help
        __pkg_review_help
        return 0
    end

    $PKG_MANAGER -Qq | fzf --preview '$PKG_MANAGER -Qil {}' --layout=reverse --bind 'enter:execute($PKG_MANAGER -Qil {} | less)'
end
