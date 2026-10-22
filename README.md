# Dot Files Readme

The dotfiles for both local and remote dev setup

## Cloning the repo

If you're on a fresh install and need the installer, you can run:

```sh
git clone --recurse-submodules 
```

If you don't have the .gitmodules file denoting the link already run

```sh
git submodule update --init
```

If you DO have the .gitmodules file, but the folder is empty, just run this

```sh
git submodule update
```

otherwise just clone the repo as you normally would.

## Misc available options

### Section is a WIP, the Linux branch is pretty self-explanatory

### Hyprland machine profiles

Keep host differences in `.config/hypr/utils/machine/`. NVIDIA environment
overrides are enabled only when the driver is present. Manbook disables KMS-only
DMA-BUF filtering so its Intel GPU exposes alpha formats to GTK and Qt clients.
After changing that quirk, reload Hyprland and restart existing clients; setting
the option through `hyprctl eval` alone does not rebuild the format table.

Check environment fallback behavior with:

```sh
cd .config/hypr
lua tests/env.lua
```
