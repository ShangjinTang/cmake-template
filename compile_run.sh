#!/usr/bin/env bash

set -e

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $BASEDIR > /dev/null

function print_seperate_line() {
    echo
    echo "${COLOR_HIGHLIGHT}======================================================================"
    echo "$1${COLOR_RESET}"
    echo
}

print_seperate_line "CMake: build"
cmake --build build

print_seperate_line "CTest"
ctest --test-dir build

print_seperate_line "Running appdemo"
./build/appdemo/demo-d

popd > /dev/null
