# Notes

## Load order

Of note:

1. `$nu.data-dir` = ~/.xdg/data/nushell

2. `$nu.vendor-autoload-dirs` = ~/.xdg/data/nushell/vendor/autoload

----

1. `env.nu` (Though not really used anymore, prefer using config.nu)
2. `config.nu`
3. `*.nu` in `$nu.vendor-autoload-dirs` (
│ /usr/share/nushell/vendor/autoload
│ /usr/local/share/nushell/vendor/autoload
│ ~/.xdg/data/nushell/vendor/autoload
)
