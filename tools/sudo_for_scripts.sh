#!/bin/bash

UID=$(id -u)
if [ x$UID != x0 ]; then
    #Beware of how you compose the command
    printf -v cmd_str '%q ' "$0" "$@"
    exec sudo su -c "$cmd_str"
fi

#I am root from now on in the current script
mkdir /opt/D3GO/
#and the rest of your commands

#The idea is to check whether the current user is root, and if not, re-run the same command with su

#https://stackoverflow.com/questions/24640340/why-cant-i-use-sudo-su-within-a-shell-script-how-to-make-a-shell-script-run
