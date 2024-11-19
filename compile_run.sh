#!/usr/bin/env bash

set -e

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

function print_seperate_line() {
    echo
    echo "${COLOR_HIGHLIGHT}======================================================================"
    echo "$1${COLOR_RESET}"
    echo
}

print_seperate_line "CMake: build"
cmake --build build/Debug --config Debug

print_seperate_line "CTest"
ctest --test-dir build/Debug

print_seperate_line "Running appdemo"
./build/Debug/appdemo/demo-d
