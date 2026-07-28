#!/usr/bin/env fish
#
# sysup/mise.fish -- wrap the update in a mise-free environment
#
# !! IMPORTANT !!
# You can think of this function like a C `malloc/free` pair:
# it is called once before the update loop and once after.
# Don't forget to "free" the function sets!
#
# mise shims can shadow system tools during an update, so the original
# deactivated mise before updating and reactivated + `mise up` after.
# That is a WRAP, not a STEP -- so it lives here as begin/end, called
# once around the step loop rather than as a step in the middle.

function __sysup_mise_begin --description 'Deactivate mise before updating'
    if not 00-valid_pacman mise
        return 0
    end
    colorize yellow "[SYSUP] Disabling mise during update...\n"
    mise deactivate 2>&1 >/dev/null
end

function __sysup_mise_end --description 'Reactivate mise and update tools' --argument-names from_crash --description 'Whether the update crashed'
    argparse 'c/from-crash=' -- $argv
    or return

    if test -z "$_flag_from_crash"
        set from_crash false
    else
        set from_crash $_flag_from_crash
    end

    if not 00-valid_pacman mise
        return 0
    end
    colorize yellow "[SYSUP] Re-enabling mise and updating tools...\n"
    mise activate fish | source
    if test $from_crash = true
        colorize yellow "[SYSUP] Mise was reactivated after a crash - skipping tool update.\n"
        return 0
    end
    mise up
end
