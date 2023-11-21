# modern-cmake-template

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging

## Requirements

- a modern C++17 compiler (`gcc-8`, `clang-6.0`, `MSVC 2017` or above)
- [`cmake`](https://cmake.org) 3.15+
- dependencies: either [`conan`](https://conan.io) 2.0+ (recommend) or `git submodule`
  - libraries
    - spdlog (required)
    - fmt (required)
    - openssl (optional)
  - test libraries
    - doctest (required only if '-DBUILD_TESTING=TRUE')
    - gtest (required only if '-DBUILD_TESTING=TRUE')
- `cppcheck` (optional)
- `clang-format` (optional)

## Features

- CMake-based project management, including dependencies
- Conan support for dependency management in CMake, completely optional
- Additional tools such as `clang-format` and `cppcheck`
- Support for shared/static libraries, including generation of export information
- Basic CPack configuration for redistributables

## Repository layout

The repository layout is pretty straightforward, including the CMake files to build the project, a `conanfile` where are declared examples of dependencies, a suppression list for cppcheck and the C++ source code:

```plain
-- conanfile.txt                - the main `conan` configuration file listing dependencies
-- cppcheck_suppressions.txt    - optional list of suppressions for cppcheck
-- CMakeLists.txt               - the main `CMake` Project configuration file
-- .gitignore                   - files to be excluded by git
-- dependencies.cmake           - Project dependencies, managed by `conan` or `git submodule`
+- `cmake/`                     - CMake modules
  | -- clang-format.cmake       - CMake target definitions for clang-format
  | -- compiler-options.cmake   - Common compiler options for major platforms/compilers
  | -- cpack.cmake              - Packaging configuration with CPack
  | -- add_git_submodule.cmake  - CMake function `add_git_submodule()` for manage dependencies
+- `project/`                   - the whole C++ project
  | -- .clang-format            - the formatter rules for the C++ project
  | -- CMakeLists.txt
  | +- `apphello/`              - your application files (including CMakeLists.txt, sources)
  | +- `libhello/`              - your library1 files (including CMakeLists.txt, sources, `doctest`, optional `openssl`)
  | +- `libmymath/`             - your library2 files (including CMakeLists.txt, sources, `gtest`)
+- `build/`                     - working directory for the build
```

## Available CMake Options

- BUILD_TESTING - builds the tests (requires `doctest` `gtest`)
- BUILD_SHARED_LIBS - enables or disables the generation of shared libraries
- USE_CONAN - whether use conan as package manager (default: `True`)
- BUILD_WITH_MT - valid only for MSVC, builds libraries as MultiThreaded DLL

Unless you activate the `-DUSE_CONAN=FALSE` flag, you need to perform in advance a `conan install` step, just to fetch the dependencies.

## Why should you choose `conan` over `git submodules`?

1. build time is shorter
2. dependencies management easier

## How to build from command line

The project can be built using the following commands:

```bash
cd [path/to/this/project]
bash compile_run_with_conan.sh
```

Format:

```bash
cmake --build [build_dir] --target format
```

Package:

```bash
cmake --build [build_dir] --target package
```
