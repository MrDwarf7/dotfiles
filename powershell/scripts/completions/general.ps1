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
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# This key handler shows the entire or filtered history using Out-GridView.
# Set-PSReadLineKeyHandler -Key F7 `
#     -BriefDescription History `
#     -LongDescription 'Show command history' `
#     -ScriptBlock {
#     $pattern = $null
#     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
#     if ($pattern) {
#         $pattern = [regex]::Escape($pattern)
#     }
#
#     $history = [System.Collections.ArrayList]@(
#         $last = ''
#         $lines = ''
#         foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
#             if ($line.EndsWith('`')) {
#                 $line = $line.Substring(0, $line.Length - 1)
#                 $lines = if ($lines) {
#                     "$lines`n$line"
#                 } else {
#                     $line
#                 }
#                 continue
#             }
#
#             if ($lines) {
#                 $line = "$lines`n$line"
#                 $lines = ''
#             }
#
#             if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
#                 $last = $line
#                 $line
#             }
#         }
#     )
#     $history.Reverse()
#
#     $command = $history | Out-GridView -Title History -PassThru
#     if ($command) {
#         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
#         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
#     }
# }
### END Scripting directly for PSReadLine module :

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
### END ViMode / Vi Mode / Vim
