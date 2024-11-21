#!/usr/bin/env bash

set -e

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $BASEDIR > /dev/null

if ! command -v vcpkg &> /dev/null; then
    echo "'vcpkg' not available"
    echo "To install:"
    echo "    git clone https://github.com/microsoft/vcpkg.git ~/vcpkg"
    echo "    cd ~/vcpkg && ./bootstrap-vcpkg.sh && ./vcpkg integrate install"
    echo "Add the following exports to your shell's profile script (e.g., ~/.bashrc or ~/.zshrc):"
    echo "    export VCPKG_ROOT=~/vcpkg"
    echo '    export PATH=$VCPKG_ROOT:$PATH'
    exit 1
fi

function print_seperate_line() {
    echo
    echo "${COLOR_HIGHLIGHT}======================================================================"
    echo "$1${COLOR_RESET}"
    echo
}

print_seperate_line "Cleaning"
rm -rf build compile_commands.json &> /dev/null

print_seperate_line "CMake: configure (vcpkg)"
cmake -S . -B build/Debug -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
cp build/Debug/compile_commands.json .

popd > /dev/null
