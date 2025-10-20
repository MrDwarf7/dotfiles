#
# ~/.bash_profile
#

# This file has been set to immutable because random programs
# keep attempting to modify it (appending lines n shit).
#
# Using `sudo chattr [+-]i /home/$USER/.bash_profile` OR sudo chattr [+-]i /home/$USER/dotfiles/.bash_profile`
# to make it (immutable)[+] OR (mutable)[-] by adding and removing the 'immutable' flag using chattr
#
#
# Make a file or directory [i]mmutable to changes and deletion, even by superuser:
#
#   chattr +i path/to/file_or_directory
#
# Make a file or directory mutable:
#
#   chattr -i path/to/file_or_directory
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
