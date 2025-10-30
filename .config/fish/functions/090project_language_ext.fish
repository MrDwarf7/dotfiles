#!/usr/bin/env fish
#

set -g LANGS {
    "rust": "rs",
    "python": "py",
    "typescript": "ts",
}

function 090project_language_ext
    set -l checked_for_ext ""

    switch (090project_language $LANGS)
        case typescript
            set checked_for_ext ts
        case rust
            set checked_for_ext rs
        case python
            set checked_for_ext py
        case 1
            set checked_for_ext ""
        case "*"
            set checked_for_ext txt
    end

    if test -n "$checked_for_ext"
        printf "%s\n" $checked_for_ext
    else
        return 1
    end

end
