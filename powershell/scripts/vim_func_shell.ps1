# BEGIN - Vim things
$dotfiles_dir = "$HOME\dotfiles"
$dotfiles_config = "$dotfiles_dir\.config"
$nvim_distro_dir = "$dotfiles_dir\nvim_distros"

# $nvim_main_dir = "$dotfiles_config"

$scoop_dir = "$dotfiles_dir\scoop"

function nhx {
    $config = "$dotfiles_config\helix\config.toml"

    if ($args[0] -eq "_noprofile") {
        $config = ""
    }
    hx --config $config $args
}

function vim {
    $env:XDG_CONFIG_HOME = "$dotfiles_config"
    $env:NVIM_APPNAME = "nvim"
    nvim $args
}

function ovim {
    $env:XDG_CONFIG_HOME = "$dotfiles_config"
    $env:NVIM_APPNAME = "n_nvim"
    nvim $args
}

function xvim {
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = "omerxx"
    nvim $args
}

function lzvim {
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = "LazyVim"
    nvim $args
}


function nvims() {
    $items = "Default", "omerxx"
    $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

    if ([string]::IsNullOrEmpty($config)) {
        Write-Output "Nothing selected"
        return
    }
    if ($config -eq "default") {
        $env:XDG_CONFIG_HOME = "$dotfiles_config"
        $config = ""
    }
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = $config
    nvim $args
}

function nvd() {
    $env:XDG_CONFIG_HOME = "$dotfiles_config\"
    $env:NVIM_APPNAME = "nvim"
    neovide $args
}

function nvdx() {
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir\"
    $env:NVIM_APPNAME = "omerxx"
    neovide $args
}

function nvds() {
    $items = "Default", "omerxx"
    $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

    if ([string]::IsNullOrEmpty($config)) {
        Write-Output "Nothing selected"
        return
    }
    if ($config -eq "default") {
        $env:XDG_CONFIG_HOME = "$dotfiles_config"
        $config = ""
    }
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = $config
    neovide --multigrid --vsync $args
}
# END - Vim things
