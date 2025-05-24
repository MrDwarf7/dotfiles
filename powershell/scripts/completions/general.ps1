# General Configuration
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# if (-not $env:HOME_PROFILE -eq $true) {
#     $env:PSModulePath ="C:\Applications\PowerShell_start\Modules"
# }

# Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }

# Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete ## Testing as a 'Key' instead of Chord for Carapace

# Auto completion via winget Tabs
# Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
#     param($wordToComplete, $commandAst, $cursorPosition)
#     [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
#     $Local:word = $wordToComplete.Replace('"', '""')
#     $Local:ast = $commandAst.ToString().Replace('"', '""')
#     winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
#         [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
#     }
# }

#PSReadLine functions start.

# if (Test-CommandExists "fzf") {
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadLineKeyHandler -ViMode Command -Key 'Ctrl+r' -ScriptBlock {
#   Invoke-FuzzyHistory
# };
# };

### START ViMode / Vi Mode / Vim
Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Vi

function onViModeChange {
  if ($args[0] -eq 'Command') {
    # Set the cursor to a blinking block.
    Write-Host -NoNewLine "`e[1 q"
  } else {
    # Set the cursor to a blinking line.
    Write-Host -NoNewLine "`e[5 q"
  }
}

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $function:onViModeChange

Set-PSReadLineKeyHandler -ViMode Command -Key 'L' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'H' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::GotoFirstNonBlankOfLine()
}

Set-PSReadLineKeyHandler -ViMode Insert -Key "Ctrl+w" -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteWord()
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'y,H' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::ViYankBeginningOfLine()
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'y,L' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::ViYankToEndOfLine()
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'd,H' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::DeleteToEnd()
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'd,L' -ScriptBlock {
  # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
  [Microsoft.PowerShell.PSConsoleReadLine]::DeleteToEnd()
}

function setViCommandMode {
  [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}

function mapTwoLetterFunc($a,$b,$func) {
  if (-not ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode())) {
    return
  }

  # if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
  $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

  if ($key.Character -eq $b) {
    &$func
  } else {
    [Microsoft.Powershell.PSConsoleReadLine]::Insert("$a")
    # Representation of modifiers (like shift) when ReadKey uses IncludeKeyDown
    if ($key.Character -eq 0x00) {
      return
    } else {
      # Insert func above converts escape characters to their literals, e.g.
      # converts return to ^M. This doesn't.
      $wshell = New-Object -ComObject wscript.shell
      $wshell.SendKeys("{$($key.Character)}")
    }
  }
  # }

}

Set-PSReadLineKeyHandler -ViMode Insert -Key "j" -ScriptBlock { mapTwoLetterFunc 'j' 'k' -func $function:setViCommandMode }
Set-PSReadLineKeyHandler -ViMode Insert -Key "k" -ScriptBlock { mapTwoLetterFunc 'k' 'j' -func $function:setViCommandMode }

## Close the current pwsh session using '>q'
# function replaceWithExit {
#     [Microsoft.PowerShell.PSConsoleReadLine]::BackwardKillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::KillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
#     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
# }
# Set-PSReadLineKeyHandler -Chord ">" -ScriptBlock { mapTwoLetterFunc '>' 'q' -func $function:replaceWithExit }

# $global:counter = 0
# Set-PSReadLineKeyHandler -Key 'a' -ScriptBlock {
#     $global:counter += 1
#     Write-Host "        Counter: $global:counter"
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('a')
# }

function ViModeVisualEditor {
  $ViMode = $null
  if ($global:PSVersionTable.PSVersion.Major -ge 7) {
    $ViMode = $null
    switch ($global:PSReadline.ViMode.Mode) {
      "Insert" {
        $ViMode = "I"
      }
      "VisualCharacter" {
        $ViMode = "V"
      }
    }
  }
  return $ViMode
}


## Standin for fzf as Powershell has to use different handlers because commands like 'head' aren't native
# See: https://github.com/kelleyma49/PSFzf/blob/67d8a5e53c3331cb3fe07ffb9ebdf244a66032dc/docs/Invoke-Fzf.md
#      for commands 
Set-PSReadLineKeyHandler -ViMode Insert -Key 'Ctrl+r' -ScriptBlock {
  # Import-Module PSFzf
  Invoke-FuzzyHistory
}

Set-PSReadLineKeyHandler -ViMode Command -Key 'Ctrl+r' -ScriptBlock {
  # Import-Module PSFzf
  [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
  Invoke-FuzzyHistory
}


### This shit soooooooo buggy

# Set-PSReadLineKeyHandler -ViMode Insert -Key 'Alt+w' -ScriptBlock {
#   # Import-Module PSFzf
#   Invoke-PsFzfRipgrep -SearchString ""
# }
#
# Set-PSReadLineKeyHandler -ViMode Command -Key 'Alt+w' -ScriptBlock {
#   # Import-Module PSFzf
#   [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
#   Invoke-PsFzfRipgrep -SearchString ""
# }
#
# function Invoke-FzfScoop {
#   param(
#     [string]$SubCommand = "info"
#   );
#
#   $result = $null;
#   [System.Collections.ArrayList]$installedApps = New-Object System.Collections.ArrayList;
#
#   # PERF: usage of native c/c++/c# would be leagues better here.....
#   $scoopPath = (Get-Command("scoop") -ErrorAction Ignore).Path
#
#   if (Test-CommandExists "scoop") {
#     # Get and build the existing list of applications for searching
#     Get-ChildItem "$(Split-Path $scoopPath)\..\apps" | ForEach-Object {
#       $installedApps.Add($_.Name) > $null;
#     };
#
#     $result = $installedApps | Invoke-Fzf -Header "Scoop Installed Apps" -Multi -Preview "scoop info {}" -PreviewWindow wrap
#   };
#
#   if ($null -eq $result) {
#     Write-Host "No scoop apps found." -ForegroundColor Yellow;
#     return;
#   };
#
#   # $cmd = "scoop $SubCommand $result";
#   #
#   # Write-Host("Command value is: $cmd")
#   # Invoke-Expression -Command $cmd -ErrorAction Stop;
# };
#
# Set-PSReadLineKeyHandler -ViMode Insert -Key 'Alt+s' -ScriptBlock {
#   # Import-Module PSFzf
#   & Invoke-FzfScoop
# };
#
# Set-PSReadLineKeyHandler -ViMode Command -Key 'Alt+s' -ScriptBlock {
#   # Import-Module PSFzf
#   [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
#   & Invoke-FzfScoop
# }
#
# Set-PSReadLineKeyHandler -ViMode Insert -Key 'Alt+x' -ScriptBlock {
#   # Import-Module PSFzf
#   Invoke-FuzzyKillProcess
# };
#
# Set-PSReadLineKeyHandler -ViMode Command -Key 'Alt+x' -ScriptBlock {
#   # Import-Module PSFzf
#   # [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
#   # Invoke-FzfScoop "list"
# }
#
# Set-PSReadLineKeyHandler -ViMode Insert -Key 'Alt+g' -ScriptBlock {
#   # Import-Module PSFzf
#   Invoke-FuzzyGitStatus
# };
#
# Set-PSReadLineKeyHandler -ViMode Command -Key 'Alt+x' -ScriptBlock {
#   [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
#   Invoke-FuzzyGitStatus
# }


### END ViMode / Vi Mode / Vim
