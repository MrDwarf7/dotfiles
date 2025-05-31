#!/usr/bin/env fish

function rmvenv 
    if test -d "./.venv"
        rm -rf ./.venv
        printf "Removed virtual environment\n"
    else
        printf "No virtual environment found\n"
    end
end
