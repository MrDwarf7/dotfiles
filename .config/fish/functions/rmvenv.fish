#!/usr/bin/env fish

function rmvenv 
    if test -d "./.venv"
        rm -rf ./.venv
        echo "Removed virtual environment"
    else
        echo "No virtual environment found"
    end
end
