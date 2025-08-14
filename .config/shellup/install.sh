#!/bin/env bash

set -e

# If via make though
# BUILD_TYPE=release VERBOSE=1 sudo make install

INSTALL_MODE=755
TARGET=./shellup
INSTALL_PATH=/usr/local/bin
PROJECT_NAME=shellup

# install -m $(INSTALL_MODE) $(TARGET) $(INSTALL_PATH)/$(PROJECT_NAME)

export BUILD_TYPE=release # release | debug
export VERBOSE=1          # 1 | 0
export INSTALL_PATH=/usr/local/bin

install -m "$($INSTALL_MODE)" "$($TARGET)" "$($INSTALL_PATH)/$($PROJECT_NAME)" || {
  echo "Installation failed. Please check the permissions and try again."
  exit 1
}

return $?
