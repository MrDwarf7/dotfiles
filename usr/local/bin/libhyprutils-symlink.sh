#!/bin/bash

# sudo chmod 644 ./hyprutils-symlink.sh
# sudo chmod +x ./hyprutils-symlink.sh

LIB_DIR="/usr/lib"
TARGET_LIB=$(ls -v "$LIB_DIR"/libhyprutils.so.0.[0-9]* 2>/dev/null | tail -n 1) # Get highest versioned
TARGET_CREATE="libhyprutils.so.9"

if [ -n "$TARGET_LIB" ] && [ ! -e "$LIB_DIR/$TARGET_CREATE" ]; then
  sudo ln -sf "$TARGET_LIB" "$LIB_DIR/$TARGET_CREATE"
  echo "Created symlink $LIB_DIR/$TARGET_CREATE -> $TARGET_LIB"
elif [ -e "$LIB_DIR/$TARGET_CREATE" ]; then
  echo "Symlink already exists: $LIB_DIR/$TARGET_CREATE"
else
  echo "No target library found; skipping symlink creation."
fi
