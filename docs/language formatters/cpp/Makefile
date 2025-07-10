# Fancy Makefile for gen.cpp

# Can be run for release + verbose output like this:
# make BUILD_TYPE=release V=1

CC = g++.exe
#CC = clang.exe
#CC = $(shell which $(CC) 2>/dev/null || echo gcc)
EXT = cpp
CPPCHECK_VERSION = c++20
CFLAGS = -municode -Wall -Wextra -std=c++20 -pipe -march=native -I$(SRC_DIR) -I$(OBJ_DIR)
DEBUG_CFLAGS = -g -O0
RELEASE_CFLAGS = -O3
LDFLAGS = -Wl,--subsystem,console -municode
# LDFLAGS = -municode
LDLIBS =
SRC_DIR = .
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
#BIN_DIR = bin
TARGET = $(BUILD_DIR)/gen.exe
SOURCES = $(wildcard $(SRC_DIR)/*.$(EXT))
OBJECTS = $(SOURCES:$(SRC_DIR)/%.$(EXT)=$(OBJ_DIR)/%.o)
DEPS = $(OBJECTS:.o=.d)
INSTALL_DIR = $(HOME)/.local/bin

# Default to debug build
BUILD_TYPE ?= debug
ifeq ($(BUILD_TYPE),release)
    CFLAGS += $(RELEASE_CFLAGS)
else
    CFLAGS += $(DEBUG_CFLAGS)
endif

# Verbose option
VERBOSE ?= 0
ifeq ($(VERBOSE),1)
    Q =
else
    Q = @
endif

all: $(TARGET)

$(TARGET): $(OBJECTS) | $(BUILD_DIR)
	$(Q)echo "Linking $@"
	$(Q)$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(LDLIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(EXT) | $(OBJ_DIR)
	$(Q)echo "Compiling $<"
	$(Q)$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

$(BUILD_DIR) $(OBJ_DIR):
	$(Q)mkdir $(subst /,\,$@)

release:
	$(MAKE) BUILD_TYPE=release

debug: 
	$(MAKE) BUILD_TYPE=debug V=1

install: $(TARGET)
	$(Q)echo "Installing $(TARGET) to $(INSTALL_DIR)"
	$(Q)if not exist $(subst /,\,$(INSTALL_DIR)) mkdir $(subst /,\,$(INSTALL_DIR))
	$(Q)copy $(subst /,\,$(TARGET)) $(subst /,\,$(INSTALL_DIR))

check:
	$(Q)echo "Running cppcheck on $(SOURCES)"
	$(Q)cppcheck --enable=all --suppress=missingIncludeSystem --force --inconclusive --std=$(CPPCHECK_VERSION) $(SOURCES)

clean:
	$(Q)echo "Cleaning..."
	$(Q)if exist $(subst /,\,$(BUILD_DIR)) rmdir /S /Q $(subst /,\,$(BUILD_DIR))

distclean: clean
	$(Q)echo "Removing installed files..."
	$(Q)if exist $(subst /,\,$(INSTALL_DIR)/gen.exe) del /Q $(subst /,\,$(INSTALL_DIR)/gen.exe)

r: 
	echo "Building release version..."
	$(MAKE) release

d: 
	echo "Building debug version..."
	$(MAKE) debug

cl: 
	echo "Cleaning build files..."
	$(MAKE) clean

i: 
	echo "Installing..."
	$(MAKE) install

c:
	echo "Running checks..."
	$(MAKE) check

.PHONY: all install clean distclean release debug check r d cl i c
# -include $(DEPS)
