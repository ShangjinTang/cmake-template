#!/usr/bin/env bash

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

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

print_seperate_line "1. Cleaning"
rm -rf build &> /dev/null

print_seperate_line "2. CMake: configure (vcpkg)"
cmake -S . -B build/Debug -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
cp build/Debug/compile_commands.json .

print_seperate_line "3. CMake: build"
cmake --build build/Debug --config Debug

print_seperate_line "4. Running CTest"
ctest --test-dir build/Debug

print_seperate_line "5. Running appdemo"
./build/Debug/appdemo/demo-d
