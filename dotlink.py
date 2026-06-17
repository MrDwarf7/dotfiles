#!/usr/bin/env python3
"""Dirty lil script to symlink ~/dotfiles/.config/* into ~/.config/"""

from pathlib import Path
import sys

dotfiles = Path.home() / "dotfiles" / ".config"
target = Path.home() / ".config"

# Items to skip — add anything you don't want symlinked
IGNORE = {
    ##
    ".oh-my-zsh",
    "shellup",
}

if not dotfiles.exists():
    print(f"nah {dotfiles} doesn't exist")
    sys.exit(1)

items = list(dotfiles.iterdir())
width = max(len(i.name) for i in items) if items else 0

for item in items:
    if item.name in IGNORE:
        print(f"  - {item.name:{width}}  ignored")
        continue

    src = item.resolve()
    dst = target / item.name

    if dst.is_symlink():
        if dst.resolve() == src:
            print(f"  ✓ {item.name:{width}}")
            continue
        print(f"  ↻ {item.name:{width}}  symlink points elsewhere, skipping")
        continue

    if dst.exists():
        print(f"  ✗ {item.name:{width}}  real file/dir exists, skipping")
        continue

    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(src)
    print(f"  → {item.name:{width}}")

print("done")
