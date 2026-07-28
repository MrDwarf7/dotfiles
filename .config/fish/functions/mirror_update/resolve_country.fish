#!/usr/bin/env fish
#
# mirror_update/resolve_country.fish
#
# Pure helper: env $MIRROR_COUNTRY wins, else AUS.

function __mirror_resolve_country --description 'Resolve mirror country code'
    if test -n "$MIRROR_COUNTRY"
        echo $MIRROR_COUNTRY
    else
        echo AUS
    end
end
