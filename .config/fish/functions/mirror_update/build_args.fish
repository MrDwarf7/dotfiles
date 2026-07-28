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
    set -l max_delay 21600

    echo -- --save $dest
    echo -- --per-mirror-timeout $per_mirror_timeout
    echo -- --entry-country $country
    echo -- --top-mirrors-number-to-retest $top_retest
    echo -- --disable-comments-in-file
    echo -- --max-delay $max_delay
    echo -- --fetch-mirrors-timeout $fetch_timeout
    echo -- $distro
end
