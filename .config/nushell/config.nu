# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

$env.config.edit_mode = 'vi'

### Keybinds 


## todo: map: 

## H (aka Shift+h) ^
## L (aka Shift+l) $

## I don't actually think this can be done cos of their hard-coding bullshit
## map (maybe.. idk) kj to escape in insert mode.....

# ### doesn't work.......
# $env.config.keybindings ++= [
#   {
#     name: start-of-line
#     modifier: shift
#     keycode: char_h
#     mode: vi_normal
#     event: { 
#       edit: { send: MoveToLineStart }
#     }
#   }
# ]


def clear-and-list [] {
  clear
  ls -a
}

alias l = ls -a
alias cls = clear
alias ca = clear-and-list

## This will properly create the color + icons (via the grid -ci part)
## But I don't want a 'grid', just want the color + icon in a normal fkn table
# ls -a | sort-by name -i | grid -ci

# Integrations
mkdir ($nu.data-dir | path join "vendor/autoload")


carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
# $env.CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense"
$env.CARAPACE_BRIDGES = "all"
# FIXME: https://github.com/carapace-sh/carapace-bin/issues/2978
# Remove once carapace-bin releases v1.5.1
$env.PATH = ($env.PATH | where { not ($in | str contains ".config/carapace/bin") })


# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

let nu_auto = ($nu.vendor-autoload-dirs)
starship init nu | save -f ($nu_auto | path join "starship.nu")
zoxide init nushell | save -f ($nu_auto| path join "zoxide.nu")


# Yazi shell wrapper
def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}



