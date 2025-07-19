#!/usr/bin/env fish

set WIDTH 5120
set HEIGHT 1440
set REFRESH_RATE 144

# command gamescope -w 5120 -h 1440 -r 144 -f -F nis --adaptive-sync --immediate-flips --hdr-debug-force-support --hdr-sdr-content-nits 400 --hdr-itm-sdr-nits 100 -e -- steam -tenfoot -steamos3

function steambp --description 'Launches Steam Big Picture mode with specific settings'
    command gamescope -w $WIDTH -h $HEIGHT -r $REFRESH_RATE -f -F nis --adaptive-sync --immediate-flips --hdr-debug-force-support --hdr-sdr-content-nits 400 --hdr-itm-sdr-nits 100 -e -- steam -tenfoot -steamos3
end
