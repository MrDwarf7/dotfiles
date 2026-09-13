#!/usr/bin/env python3
"""Dirty lil script to symlink ~/dotfiles/.config/* into ~/.config/"""

from pathlib import Path
import os
import sys

dotfiles = Path.home() / "dotfiles" / ".config"
target = Path.home() / ".config"

# Shared skip. New shared tools should NOT need an allow-list entry.
SHARED_SKIP = {
    ".oh-my-zsh",
    "shellup",
}

# First-digit OS groups: exclude the other desktop stack.
LINUX_DESKTOP = {
    "hypr",
    "niri",
    "waybar",
    "swaylock",
    "swaync",
    "DankMaterialShell",
    "ashell",
    "fuzzel",
    "wofi",
    "tofi",
    "wlogout",
    "hyprvoice",
    "uwsm",
    "xdg-desktop-portal",
    "paru",
    "yay",
    "pacsea",
    "pacseek",
    "vortix",
    "systemd",
}

DARWIN_DESKTOP = {
    "aerospace",
    "borders",
    "sketchybar",
    "karabiner",
}


def skip_for(os_name: str) -> set[str]:
    if os_name == "darwin":
        return SHARED_SKIP | LINUX_DESKTOP
    return SHARED_SKIP | DARWIN_DESKTOP


os_name = os.uname().sysname.lower()
IGNORE = skip_for(os_name)

if not dotfiles.exists():
    print(f"nah {dotfiles} doesn't exist")
    sys.exit(1)

items = list(dotfiles.iterdir())
width = max(len(i.name) for i in items) if items else 0

for item in items:
    if item.name in IGNORE:
        print(f"  - {item.name:{width}}  ignored")
        continue

    src = item
    dst = target / item.name
    rel = os.path.relpath(src, start=dst.parent)

    if dst.is_symlink():
        if dst.resolve() == src.resolve():
            print(f"  ✓ {item.name:{width}}")
            continue
        print(f"  ↻ {item.name:{width}}  symlink points elsewhere, skipping")
        continue

    if dst.exists():
        print(f"  ✗ {item.name:{width}}  real file/dir exists, skipping")
        continue

    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(rel)
    print(f"  → {item.name:{width}}  -> {rel}")

print("done")
