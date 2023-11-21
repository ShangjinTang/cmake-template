#!/usr/bin/env bash

COLOR_RESET=$(tput sgr0)
COLOR_HIGHLIGHT=$(tput bold)$(tput setaf 6)

if ! python3 -m pip show conan &> /dev/null; then
    echo "please run 'python3 -m install conan' first"
    if ! [[ -f ~/.conan2/profiles/default ]]; then
        conan profile detect --force
    fi
fi

function print_seperate_line() {
    echo
    echo "${COLOR_HIGHLIGHT}======================================================================"
    echo "$1${COLOR_RESET}"
    echo
}

print_seperate_line "1. Cleaning"
rm -rf build &> /dev/null

print_seperate_line "2. CMake: preparing build"
cmake -S . -B build/Debug -DUSE_CONAN=FALSE
cp build/Debug/compile_commands.json .

print_seperate_line "3. CMake: building"
cmake --build build/Debug --config Debug

print_seperate_line "4. Running CTest"
ctest --test-dir build/Debug

print_seperate_line "5. Running apphello"
./build/Debug/apphello/apphello-d
