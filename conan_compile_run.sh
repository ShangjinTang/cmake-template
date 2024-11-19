#!/usr/bin/env bash

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

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

print_seperate_line "1. Cleaning"
rm -rf build &> /dev/null

print_seperate_line "2. CMake: configure (conan)"
cmake -S . -B build/Debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES=conan_provider.cmake
cp build/Debug/compile_commands.json .

print_seperate_line "3. CMake: build"
cmake --build build/Debug --config Debug

print_seperate_line "4. Running CTest"
ctest --test-dir build/Debug

print_seperate_line "5. Running appdemo"
./build/Debug/appdemo/demo-d
