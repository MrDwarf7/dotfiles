#!/usr/bin/env python3
"""Dirty lil script to symlink ~/dotfiles/.config/* into ~/.config/"""

from pathlib import Path
import os
import sys

dotfiles = Path.home() / "dotfiles" / ".config"
target = Path.home() / ".config"

if not dotfiles.exists():
    print(f"nah {dotfiles} doesn't exist")
    sys.exit(1)

for item in dotfiles.iterdir():
    src = item.resolve()
    dst = target / item.name

    if dst.exists() or dst.is_symlink():
        # skip if already pointing to the right place
        if dst.resolve() == src:
            print(f"  ✓ {item.name}")
            continue
        print(f"  ✗ {item.name} — already exists, skipping")
        continue

    # make parent dirs if needed
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(src)
    print(f"  → {item.name}")

print("done")
