#!/usr/bin/env bash

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

CURRENT_DIR=$(pwd)

if ! command -v conan &> /dev/null; then
    echo "Conan not found, please run 'python3 -m pip install conan' or 'pipx install conan'"
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

print_seperate_line "2. conan: installing package"
conan install . -s build_type=Debug --build=missing

print_seperate_line "3. CMake: preparing build"
cmake -S . -B build/Debug -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_TOOLCHAIN_FILE=build/Debug/generators/conan_toolchain.cmake
cp build/Debug/compile_commands.json .

print_seperate_line "4. CMake: building"
cmake --build build/Debug --config Debug

print_seperate_line "5. Running CTest"
ctest --test-dir build/Debug

print_seperate_line "6. Running appdemo"
./build/Debug/appdemo/demo-d
