# Dot Files Readme

The dotfiles for both local and remote dev setup


## Cloning the repo

If you're on a fresh install and need the installer, you can run:

```ps1
git clone --recurse-submodules 
```

If you don't have the .gitmodules file denoting the link already run

```ps1
git submodule update --init
```


If you DO have the .gitmodules file, but the folder is empty, just run this

```ps1
git submodule update
```

otherwise just clone the repo as you normally would.


## Update OhMyPosh using this command -

winget upgrade JanDeDobbeleer.OhMyPosh -s winget
Reqs/commands
PowerShellGet v1.6.0 or higher - can run "Get-Module" without quotes to check
IF lower, run - Install-Module -Name PowerShellGet -Force


## PSDOtfiles

- (WIP)

[PSDotFiles Repo](https://github.com/ralish/PSDotFiles)
From the GitHub repo, states it's aiming to achieve a similar goal to GNU Stow, for Windows/PowerShell systems.


## PSReadLine

```ps1
Install-Module PSReadLine
```


### Consider installing CompletionPredictor alongside PSReadLine also

- (Optional, but recommended)

```ps1
Install-Module -Name CompletionPredictor -Repository PSGallery
```


## Importing: PSReadLine

```ps1
Import-Module PSReadLine
```

- Or add it to the top of your $PROFILE,
    the default location will open if you ran something such as:

```ps1
nvim $PROFILE
```

Or if you don't have vim/nvim up and running yet:

```ps1
notepad $PROFILE
```

Keep in mind, if you don't have this file already, you may need to create one.
This can be done with the following command:

```ps1
New-Item -Path $profile -Type File -Force
```


## Importing: CompletionPredictor

Importing this can also be done the same as above, by adding to $PROFILE.

```ps1
Import-Module -Name CompletionPredictor
```

- (Optional)

Consider moving/redirecting your profile loading to somewhere on local storage for loading speeds.
If currently loading from One - Drive or another online source.

If at _ANY STAGE_ after redirecting your $PROFILE call you happen to run:

```ps1
$EDITOR $PROFILE
```

You will be opening the END-POINT file, not the re-direct, be aware of this and decide if you wish to move ALL your code to the new file (Recommended)

To do this, open the base version of $PROFILE from the above step, and use the following command to move the 
$PROFILE it's loading to location of your choice.

There is also a `profile_stub.ps1` provided in the ./powershell/ directory

```ps1
$profile = "C:\Location\Of\Your\Choosing\ProfileHoldingFolder\Microsoft.PowerShell_profile.ps1"
. $profile
```


## Oh-My-Posh for prompt styling control etc.

`https://ohmyposh.dev/`

For any of the PSReadLine commands that you may find online for custimization from other Uers, ensure you add this to the VERY top of your $PROFILE


### Importing deps

```ps1
using namespace System.Management.Automation
using namespace System.Management.Automation.Language
```

These are similar to import statements within Python or JavaScript and allow ease of use on longer commands.

## Oh-My-Posh Config call

```ps1
oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\1Custom_Work_powerlevel10k_rainbow.omp.json| Invoke-Expression
```

## PSReadLine (Imports)

```ps1
Import-Module PSReadLine
Import-Module -Name CompletionPredictor
```

## PSReadLine Options set

```ps1
Set-PSReadlineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView
```

## Misc available options:

[ ] - CompletionQueryItems

```ps1
Install-Module -Name Azure
```

[ ] - (WIP) Scoop batch installer

- Other content that makes up the profile as a whole can be found under the ./docs/ foler

