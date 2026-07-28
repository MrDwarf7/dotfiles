function sysup_neovim --description 'Step: update neovim headless via Lazy'
    if not 00-valid_pacman nvim
        colorize red "neovim not found; cannot update neovim.\n"
        return 1
    end
    # Update neovim headless via Lazy (lazy.nvim)
    command nvim --headless -c 'Lazy! sync' -c qa
end
