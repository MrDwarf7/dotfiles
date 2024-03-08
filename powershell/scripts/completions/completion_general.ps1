# General Configuration

using namespace System.Management.Automation
using namespace System.Management.Automation.Language


if ($env:HOME_PROFILE -eq $false)
{
    $env:PSModulePath ="C:\Applications\PowerShell_start\Modules"
} else
{
    $env:PSModulePath = $env:PSModulePath
}


# Import-Module PSReadLine

Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
#Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete ## Testing alternative Tab completion api call

$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $Env:_TYPER_COMPLETE = "complete_powershell"
    $Env:_TYPER_COMPLETE_ARGS = $commandAst.ToString()
    $Env:_TYPER_COMPLETE_WORD_TO_COMPLETE = $wordToComplete
    typer | ForEach-Object {
        $commandArray = $_ -Split ":::"
        $command = $commandArray[0]
        $helpString = $commandArray[1]
        [System.Management.Automation.CompletionResult]::new(
            $command, $command, 'ParameterValue', $helpString)
    }
    $Env:_TYPER_COMPLETE = ""
    $Env:_TYPER_COMPLETE_ARGS = ""
    $Env:_TYPER_COMPLETE_WORD_TO_COMPLETE = ""
}
Register-ArgumentCompleter -Native -CommandName typer -ScriptBlock $scriptblock


# Import-Module PSReadLine
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


Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Vi

function onViModeChange
{
    if ($args[0] -eq 'Command')
    {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else
    {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:onViModeChange


Set-PSReadLineKeyHandler -ViMode Command -Chord 'L' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

Set-PSReadLineKeyHandler -ViMode Command -Chord 'H' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::GotoFirstNonBlankOfLine()
}

Set-PSReadLineKeyHandler -ViMode Insert -Chord "Ctrl+w" -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteWord()
}


Set-PSReadLineKeyHandler -ViMode Command -Chord 'y,H' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::ViYankBeginningOfLine()
}

Set-PSReadLineKeyHandler -ViMode Command -Chord 'y,L' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::ViYankToEndOfLine()
}


Set-PSReadLineKeyHandler -ViMode Command -Chord 'd,H' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::DeleteToEnd()
}

Set-PSReadLineKeyHandler -ViMode Command -Chord 'd,L' -ScriptBlock {
    # [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::DeleteToEnd()
}


# Set-PSReadLineKeyHandler -ViMode Command -Chord 'v' -ScriptBlock {
#     [Microsoft.PowerShell.PSConsoleReadLine]::ViEditVisually()
#     [Microsoft.PowerShell.PSConsoleReadLine]::ViMovementMode.Character
# }



# Set-PSReadLineKeyHandler -vimode insert -Chord "j" -ScriptBlock { mapTwoLetterNormal 'j' 'k' }
Set-PSReadLineKeyHandler -ViMode Insert -Chord "j" -ScriptBlock { mapTwoLetterNormal 'j' 'j' }
function mapTwoLetterNormal($a, $b)
{
    mapTwoLetterFunc $a $b -func $function:setViCommandMode
}
function setViCommandMode
{
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}

function mapTwoLetterFunc($a,$b,$func)
{
    if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode())
    {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if ($key.Character -eq $b)
        {
            &$func
        } else
        {
            [Microsoft.Powershell.PSConsoleReadLine]::Insert("$a")
            # Representation of modifiers (like shift) when ReadKey uses IncludeKeyDown
            if ($key.Character -eq 0x00)
            {
                return
            } else
            {
                # Insert func above converts escape characters to their literals, e.g.
                # converts return to ^M. This doesn't.
                $wshell = New-Object -ComObject wscript.shell
                $wshell.SendKeys("{$($key.Character)}")
            }
        }
    }
}

# Set-PSReadLineKeyHandler -ViMode Command -Chord ":,q" -ScriptBlock {
#     [Microsoft.PowerShell.PSConsoleReadLine]::BackwardKillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::KillLine()
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
# }


function ViModeVisualEditor
{
    $ViMode = $null
    if ($global:PSVersionTable.PSVersion.Major -ge 7)
    {
        $ViMode = $null
        switch ($global:PSReadline.ViMode.Mode)
        {
            "Insert"
            { $ViMode = "I"
            }
            # "Command"
            # { $ViMode = "C"
            # }
            # "Replace"
            # { $ViMode = "R"
            # }

            "VisualCharacter"
            { $ViMode = "V"
            }

            # "VisualLine"
            # { $ViMode = "V"
            # }
            # "VisualBlock"
            # { $ViMode = "V"
            # }
        }
    }
    return $ViMode
}
