# General Configuration
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

$env:HOME_PROFILE = $false
$env:POSH_GIT_ENABLED = $true
#Update OhMyPosh using this command -
#winget upgrade JanDeDobbeleer.OhMyPosh -s winget
### START MAIN SCRIPT

# BEGIN - Tooling Functions
function Test-CommandExists ([Parameter(Mandatory = $true)][string] $Command)
{
  return [bool](Get-Command $Command -ErrorAction SilentlyContinue)
}

# Work.sort of
function checkEnvironment
{
  if ($env:COMPUTERNAME -clike "*LG*")
  {
    return $true
  } else
  {
    return $false
  }
}
# END - Tooling Functions

# BEGIN - Alias(s)
# Import-Module DockerCompletion
#Git aliases from Oh-my-zsh Git plugin for PWSH
Import-Module git-aliases -DisableNameChecking

New-Alias grep Select-String
New-Alias which Get-Command
New-Alias ln New-SymLink

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}
# END - Alias(s)

#Oh-My-Posh config/setup
# Work / HOME
oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\1MrDwarf7Theme.omp.json | Invoke-Expression

Import-Module PSReadLine
Import-Module -Name CompletionPredictor
#PSReadLine Options set
Set-PSReadlineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView -HistorySearchCursorMovesToEnd

# Auto completion via winget Tabs
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}
#PSReadLine functions start.
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# This key handler shows the entire or filtered history using Out-GridView.
Set-PSReadLineKeyHandler -Key F7 `
  -BriefDescription History `
  -LongDescription 'Show command history' `
  -ScriptBlock {
  $pattern = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
  if ($pattern)
  {
    $pattern = [regex]::Escape($pattern)
  }

  $history = [System.Collections.ArrayList]@(
    $last = ''
    $lines = ''
    foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
    {
      if ($line.EndsWith('`'))
      {
        $line = $line.Substring(0, $line.Length - 1)
        $lines = if ($lines)
        {
          "$lines`n$line"
        } else
        {
          $line
        }
        continue
      }

      if ($lines)
      {
        $line = "$lines`n$line"
        $lines = ''
      }

      if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
      {
        $last = $line
        $line
      }
    }
  )
  $history.Reverse()

  $command = $history | Out-GridView -Title History -PassThru
  if ($command)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
  }
}
#Quotation mark control
Set-PSReadLineKeyHandler -Key '"', "'" `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
  param($key, $arg)

  $quote = $key.KeyChar

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  # If text is selected, just quote it without any smarts
  if ($selectionStart -ne -1)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
    return
  }

  $ast = $null
  $tokens = $null
  $parseErrors = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

  function FindToken
  {
    param($tokens, $cursor)

    foreach ($token in $tokens)
    {
      if ($cursor -lt $token.Extent.StartOffset)
      {
        continue
      }
      if ($cursor -lt $token.Extent.EndOffset)
      {
        $result = $token
        $token = $token -as [StringExpandableToken]
        if ($token)
        {
          $nested = FindToken $token.NestedTokens $cursor
          if ($nested)
          {
            $result = $nested
          }
        }

        return $result
      }
    }
    return $null
  }

  $token = FindToken $tokens $cursor

  # If we're on or inside a **quoted** string token (so not generic), we need to be smarter #Line 183-188
  if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic)
  {
    # If we're at the start of the string, assume we're inserting a new string
    if ($token.Extent.StartOffset -eq $cursor)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      return
    }

    # If we're at the end of the string, move over the closing quote if present.
    if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      return
    }
  }

  if ($null -eq $token -or
    $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket)
  {
    if ($line[0..$cursor].Where{ $_ -eq $quote }.Count % 2 -eq 1)
    {
      # Odd number of quotes before the cursor, insert a single quote
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
    } else
    {
      # Insert matching quotes, move cursor to be in between the quotes
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
    }
    return
  }

  # If cursor is at the start of a token, enclose it in quotes.
  if ($token.Extent.StartOffset -eq $cursor)
  {
    if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or
      $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword))
    {
      $end = $token.Extent.EndOffset
      $len = $end - $cursor
      [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
      return
    }
  }

  # We failed to be smart, so just insert a single quote
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
}

Set-PSReadLineKeyHandler -Key '(', '{', '[' `
  -BriefDescription InsertPairedBraces `
  -LongDescription "Insert matching braces" `
  -ScriptBlock {
  param($key, $arg)

  $closeChar = switch ($key.KeyChar)
  {
    <#case#> '('
    {
      [char]')'; break
    }
    <#case#> '{'
    {
      [char]'}'; break
    }
    <#case#> '['
    {
      [char]']'; break
    }
  }

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($selectionStart -ne -1)
  {
    # Text is selected, wrap it in brackets
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  } else
  {
    # No text is selected, insert a pair
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  }
}

Set-PSReadLineKeyHandler -Key ')', ']', '}' `
  -BriefDescription SmartCloseBraces `
  -LongDescription "Insert closing brace or skip" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[$cursor] -eq $key.KeyChar)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
  }
}

Set-PSReadLineKeyHandler -Key Backspace `
  -BriefDescription SmartBackspace `
  -LongDescription "Delete previous character or matching quotes/parens/braces" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -gt 0)
  {
    $toMatch = $null
    if ($cursor -lt $line.Length)
    {
      switch ($line[$cursor])
      {
        <#case#> '"'
        {
          $toMatch = '"'; break
        }
        <#case#> "'"
        {
          $toMatch = "'"; break
        }
        <#case#> ')'
        {
          $toMatch = '('; break
        }
        <#case#> ']'
        {
          $toMatch = '['; break
        }
        <#case#> '}'
        {
          $toMatch = '{'; break
        }
      }
    }

    if ($toMatch -ne $null -and $line[$cursor - 1] -eq $toMatch)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
    } else
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
    }
  }
}

#END Bracket control - Closing

#endregion Smart Insert/Delete

# Auto correct 'git cmt' to 'git commit'
Set-PSReadLineOption -CommandValidationHandler {
  param([CommandAst]$CommandAst)

  switch ($CommandAst.GetCommandName())
  {
    'git'
    {
      $gitCmd = $CommandAst.CommandElements[1].Extent
      switch ($gitCmd.Text)
      {
        'cmt'
        {
          [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
            $gitCmd.StartOffset, $gitCmd.EndOffset - $gitCmd.StartOffset, 'commit')
        }
      }
    }
  }
}

### END Scripting directly for PSReadLine module :

#Raw Functions

# BEGIN - Shell functions

# Work
function gitsh
{
  C:/Applications/Git/bin/bash.exe -i -l
}

function archsh
{
  & 'C:\Windows\system32\wsl.exe' -d Arch --cd ~ --user dwarf
}

function debsh
{
  & 'C:\Windows\system32\wsl.exe' -d Debian --cd ~ --user dwarf
}

function nixsh
{
  & 'C:\Windows\system32\wsl.exe' -d NixOS --cd ~
}

function ubsh
{
  & 'C:\Windows\system32\wsl.exe' -d Ubuntu --cd ~ --user dwarf
}

function disloc
{
  if (-not ($args))
  {
    (Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | ForEach-Object {Get-ItemProperty $_.PSPath}) | Select-Object DistributionName,BasePath
  } elseif ($args -eq "v" -or "V")
  {
    (Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Recurse)
  } else
  {
    Write-Error ErrorAction
  }
}

# END - Shell functions

#Easily open unix related terminals

# BEGIN - WSL specific things
function wsllv
{
  wsl --list --verbose
}

function wsls
{
  wsl --shutdown
}

# END - WSL specific things

# BEGIN - Navigation functions
# Work
function mgr
{
  param(
    [string]$path = "C:\Applications\GitHub_Projects"
  )
  Push-Location $path
  Get-ChildItem
}

# Work
function wgr
{
  param(
    [string]$path = "C:\Applications\GitWork_Projects"
  )
  Push-Location $path
  Get-ChildItem
}

# Work
function bpgr
{
  param(
    [string]$path = "\\SomeNetWorkPathPlace\SomeOtherFolderPlace"
  )
  Push-Location $path
  Get-ChildItem
}

# Work
function bpr
{
  param(
    [string]$path = "\\SomeNetWorkPathPlace\SomeFolder\SomeOtherFolder"
  )
  Push-Location $path
}


# Work
function sar
{
  param(
    [string]$path = "\\SomeNetWorkPathPlace\SomeFolder\SomeOtherFolder"
  )
  Push-Location $path
}


# Work
function ohome
{
  $onlineHome = "$env:USERPROFILE\OneDrive - SomeName"
  Push-Location $onlineHome
  Get-ChildItem
}

function gitgo
{
  param(
    [string]$baseCommitMessage = "Bump"
  )
  if ($args)
  {
    $argumentsIn = $args
  }
  if (-not $args)
  {
    $argumentsIn = $baseCommitMessage
  }
  gst && gaa && gcam "$($argumentsIn)." && git push
  return
}

function dot
{
  param(
    [string]$basePath = "~\dotfiles\",
    [string]$pathArgument = $args
  )
  if ($args)
  {
    $basePath = $basePath + $pathArgument
  }
  Push-Location $basePath
  Get-ChildItem
  return
} 

# END - Navigation functions

# BEGIN - Python Functions
function pip
{

  if (checkEnvironment -eq $true)
  {
    if ($env:VIRTUAL_ENV)
    {
      $virtualEnvPipPath = Join-Path $env:VIRTUAL_ENV "Scripts\pip.exe"
      Set-Alias -Name pip -Value $virtualEnvPipPath
      & Set-Alias -Name pip3 -Value $virtualEnvPipPath

      & pip $args
    } else
    {
      $pipPath = "C:\Applications\Python3.11.4\Scripts\pip.exe"
      & Set-Alias -Name pip -Value $pipPath

      & pip $args
    }
  } else
  {
    & pip $args
  }
}

function python
{
  if (checkEnvironment -eq $true)
  {
    if ($env:VIRTUAL_ENV)
    {
      $pythonVirtualEnvPath = Join-Path $env:VIRTUAL_ENV "Scripts\python.exe"
      Set-Alias -Name python -Value $pythonVirtualEnvPath
      & Set-Alias -Name python3 -Value $pythonVirtualEnvPath
      & Set-Alias -Name py -Value $pythonVirtualEnvPath
      python $args
    } else
    {
      # Work
      Write-Host "Correct Version"
      $pythonPath="$HOME\scoop\apps\python\current\python.exe"
      Set-Alias -Name python -Value  $pythonPath
      & Set-Alias -Name python3 -Value $pythonPath
      & Set-Alias -Name py -Value  $pythonPath
      python $args
    }
  } else
  {
    continue
  }
}

# Work
function pmv
{
  try
  {
    if (checkEnvironment)
    {
      python3 -m venv .venv
      Push-Location .\.venv\Scripts
      .\activate
      Pop-Location
      Get-ChildItem
    } else
    {
      python -m venv .venv
      Push-Location .\.venv\Scripts
      .\activate
      Pop-Location
      Get-ChildItem

    }
  } catch
  {
    Write-Error "Failed to create the virtual environment"
  }
}

function dea
{
  deactivate
}

function avenv
{
  Push-Location .\.venv\Scripts
  .\activate
  Pop-Location
  Get-ChildItem
}

function rmvenv
{
  if ($env:VIRTUAL_ENV)
  {
    deactivate
  }
  if (checkEnvironment)
  {
    Remove-Item -r ./.venv
  } else
  {
    Remove-Item -Path ./.venv -Recurse -Force
  }
}


# END - Python Functions

#Linux Functions

function pro
{
  . $PROFILE
}

function cd2
{
  Set-Location ../../
}

function .
{
  Start-Process .
}

function touch
{
  New-Item $args
}

function la
{
  param ($path = ".")
  Get-ChildItem $path -Force
}

function zip
{
  param (
    [string]$ItemToCompress,
    [string]$OptionalDestination
  )
  $ItemName = (Get-Item $ItemToCompress).Name
  $ParentFolder = (Split-Path -Path $ItemToCompress -Parent)

  if ([String]::IsNullOrEmpty($OptionalDestination))
  {
    $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

    Compress-Archive -Path $ItemToCompress -DestinationPath "$DefaultLocation.zip"
  } else
  {
    Compress-Archive -Path $ItemToCompress -DestinationPath "$OptionalDestination\$ItemName.zip"
  }
}

function uzip
{
  param (
    [string]$ItemToUnzip,
    [string]$OptionalDestination
  )
  $ItemName = (Get-Item $ItemToUnzip).Name
  $ParentFolder = (Split-Path -Path $ItemToUnzip -Parent)

  if ([String]::IsNullOrEmpty($OptionalDestination))
  {
    $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

    Expand-Archive -Path $ItemToUnzip -DestinationPath "$DefaultLocation\$ItemName"
  } else
  {
    Expand-Archive -Path $ItemToUnzip -DestinationPath "$OptionalDestination\"
  }
}

# END - Linux Functions

# BEGIN - Vim things

function vim
{
  $env:NVIM_APPNAME = "nvim"
  nvim $args
}

function dvim
{
  $env:NVIM_APPNAME = "LazyVim"
  # if ($env:HOME_PROFILE) {
  #     neovide $args
  # } elseif (Test-CommandExists nvim){
  nvim $args
}
# }
# Neovide being buggy as hell, commented out for time being


function nvims()
{
  $items = "LazyVim", "Default"
  $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

  if ([string]::IsNullOrEmpty($config))
  {
    Write-Output "Nothing selected"
    return
  }
  if ($config -eq "default")
  {
    $config = ""
  }
  $env:NVIM_APPNAME = $config
  nvim $args
}
# END - Vim things
