# AstroNvim User Configuration Example

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```powershell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clone AstroNvim

#### Linux

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

#### Windows

```powershell
git clone https://github.com/AstroNvim/AstroNvim $env:LOCALAPPDATA\
```

##### Or if that isn't working as expected you can also use this
##### (Bear in mind that the custom ending location is setup to use the nvims command in powershell to choose.)

```powershell
git clone https://github.com/AstroNvim/AstroNvim $HOME\AppData\Local\AstroNvim
```

### Run a Symlink command to have the AstroNvim directory point point to the user config in dotfiles.

```powershell
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\AstroNvim\lua\ -Name user -Value $HOME\dotfiles\AstroNvim\lua\user
```

#### Or copy the entire folder, as it mimics the same structure.

### Start Neovim using either

#### Windows (Using custom Powershell profile with fzf picker)

For Windows
```powershell
nvims
```

For linux
#### Linux
```shell
nvim
```
