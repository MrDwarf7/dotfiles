# BEGIN - Python Functions

PYENV="$HOME\.pyenv\pyenv-win"
PYENV_HOME="$HOME\.pyenv\pyenv-win"
PYENV_ROOT="$HOME\.pyenv\pyenv-win"
PYENV_SHIMS="$HOME\.pyenv\pyenv-win\shims"


function pmv()
{
    param(
        [switch]$py3
    )

    if ($env:VIRTUAL_ENV)
    {
        Write-Host "You already have a Virtual Env active!"
    }
    if (checkEnvironment -eq $true)
    {
        $pythonPath="$HOME\scoop\apps\python\current\python.exe"
        Set-Alias -Name python -Value $pythonPath
        # & Set-Alias -Name python3 -Value $pythonPath
        & Set-Alias -Name py -Value $pythonPath
    }

    switch ($py3)
    {
        $true
        {
            Set-Alias -Name python3 -Value $env:PYENV_SHIMS\python3.bat
            $mainCommand = python3 -m venv .venv
        }
        $false
        {
            $mainCommand = python -m venv .venv
        }
        default
        {
            $mainCommand = python -m venv .venv
        }
    }

    $mainCommand
    Push-Location .\.venv\Scripts
    .\activate
    Pop-Location
    Get-ChildItem
}

function pmv3
{
    pmv -py3
}

function dea
{
    deactivate
}

function avenv
{
    if ($env:VIRTUAL_ENV)
    {
        Write-Host "You already have a virtual Env activate!"
    }
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

