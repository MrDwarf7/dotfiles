# BEGIN - Vim things
$dotfiles_dir = "$env:HOMEPATH/dotfiles"

$nvim_main_dir = "$dotfiles_dir/main_nvim"
$nvim_distro_dir = "$dotfiles_dir/nvim_distros"

$scoop_dir = "$dotfiles_dir/scoop"

function hx
{
    $config="$scoop_dir\persist\helix\config.toml"
    
    if ($args[0] -eq "_local")
    {
        $config = ""
    }
    helix --config $config $args
}

function vim
{
    $env:XDG_CONFIG_HOME = "$nvim_main_dir"
    $env:NVIM_APPNAME = ""
    nvim $args
}

function xvim
{
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = "omerxx"
    # if ($env:HOME_PROFILE) {
    #     neovide $args
    # } elseif (Test-CommandExists nvim){
    nvim $args
}
# }
# Neovide being buggy as hell, commented out for time being

function nvims()
{
    $items = "Default", "LazyVim", "TestVim", "old.nvims", "omerxx"
    $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

    if ([string]::IsNullOrEmpty($config))
    {
        Write-Output "Nothing selected"
        return
    }
    if ($config -eq "default")
    {
        $env:XDG_CONFIG_HOME = "$nvim_main_dir"
        $config = ""
    }
    $env:XDG_CONFIG_HOME = "$nvim_distro_dir"
    $env:NVIM_APPNAME = $config
    nvim $args
}
# END - Vim things



