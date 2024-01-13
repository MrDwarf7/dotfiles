# BEGIN - Vim things
$dotfiles_dir = "$HOME\dotfiles"

$nvim_main_dir = "$dotfiles_dir\main_nvim"
$nvim_distro_dir = "$dotfiles_dir\nvim_distros"

$scoop_dir = "$dotfiles_dir\scoop"

function hx {
    $config = "$scoop_dir\persist\helix\config.toml"
    
    if ($args[0] -eq "_local") {
        $config = ""
    }
    helix --config $config $args
}

function vim {
    $env:XDG_CONFIG_HOME = "$nvim_main_dir"
    $env:NVIM_APPNAME = ""
    nvim $args
}

function xvim {
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = "omerxx"
    nvim $args
}

function nvims() {
    $items = "Default", "LazyVim", "TestVim", "old.nvims", "omerxx"
    $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

    if ([string]::IsNullOrEmpty($config)) {
        Write-Output "Nothing selected"
        return
    }
    if ($config -eq "default") {
        $env:XDG_CONFIG_HOME = "$nvim_main_dir"
        $config = ""
    }
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = $config
    nvim $args
}

function nvdx() {
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = "omerxx" && neovide $args
}

function nvdm() {
    $env:XDG_CONFIG_HOME = "$nvim_main_dir"
    # $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = ""
    neovide $args
}

function nvds() {
    $items = "Default", "LazyVim", "TestVim", "old.nvims", "omerxx"
    $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

    if ([string]::IsNullOrEmpty($config)) {
        Write-Output "Nothing selected"
        return
    }
    if ($config -eq "default") {
        $env:XDG_CONFIG_HOME = "$nvim_main_dir"
        $config = ""
    }
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = $config
    neovide --multigrid --vsync $args
}
# END - Vim things


