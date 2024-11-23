#!/usr/bin/env bash

set -e

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $BASEDIR > /dev/null

if ! command -v conan &> /dev/null; then
    echo "'conan' not avaiable"
    echo "To install:"
    echo "    python3 -m pip install pipx"
    echo "    pipx ensurepath"
    echo "    pipx install conan"
    exit 1
fi

if ! [[ -f ~/.conan2/profiles/default ]]; then
    conan profile detect --force
fi

function print_seperate_line() {
    echo
    echo "${COLOR_HIGHLIGHT}======================================================================"
    echo "$1${COLOR_RESET}"
    echo
}

print_seperate_line "Cleaning"
rm -rf build compile_commands.json CMakePresets.json CMakeUserPresets.json &> /dev/null

print_seperate_line "CMake: configure (conan)"
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -G Ninja -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES=conan_provider.cmake
cp build/compile_commands.json . &> /dev/null

popd > /dev/null
