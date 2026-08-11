#!/usr/bin/env fish
#

function recent_updated_pkgs --description 'Recently updated packages (from pacman/paru/yay)'
    command expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl | fzf --layout=reverse --color=16 --ansi --preview-window=right:wrap --preview 'echo {} | cut -f2- | awk "{print \$3}" | xargs pacman -Qi' | awk '{print $2}' | xargs -I {} fish -c "cd /var/cache/pacman/pkg/{} && l"
    return $status
end
