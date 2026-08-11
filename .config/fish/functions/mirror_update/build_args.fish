#!/usr/bin/env fish
#
# mirror_update/build_args.fish
#
# Pure helper: prints the rate-mirrors argument list (one arg per line)
# so the caller can capture it into an array. Tunables are local vars
# here and could later move to env overrides or a config file.

function __mirror_build_args --description 'Build the rate-mirrors argument list'
    set -l dest $argv[1]
    set -l country (__mirror_resolve_country)
    set -l distro (__mirror_detect_distro)

    # Tunables -- candidates to expose as env vars later
    set -l per_mirror_timeout 90000
    set -l top_retest 15
    set -l fetch_timeout 90000
    # set -l max_delay 21600 # Deprecated!

    set -l str_buf
    set --append str_buf \
        --save $dest \
        --max-per-mirror $per_mirror_timeout \
        --entry-country $country \
        --top-mirrors-number-to-retest $top_retest \
        --disable-comments-in-file \
        $distro

    # Depr. options
    # --fetch-mirrors-timeout $fetch_timeout \
    # --max-delay $max_delay

    printf '%s\n' $str_buf
end
