# Modern Cmake Template

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging.

## Resources

- CMake:
  - Official: [Getting Started](https://cmake.org/getting-started/)
  - OnLine Book: [Modern CMake](https://cliutils.gitlab.io/modern-cmake/)
  - Introduction Video: [CppCon 2017: Mathieu Ropert “Using Modern CMake Patterns to Enforce a Good Modular Design”](https://www.youtube.com/watch?v=eC9-iRN2b04)
- Conan:
  - Official: [conan.io](https://conan.io/)

## Requirements

- a modern C++17 compiler (`gcc-8`, `clang-6.0`, `MSVC 2017` or above)
- [`cmake`](https://cmake.org) 3.15+
- dependencies: either [`conan`](https://conan.io) 2.0+ (recommend) or `git submodule`
  - libraries
    - `spdlog` (required)
    - `fmt` (required)
  - test libraries
    - `doctest` (required only if enable `BUILD_TESTING`)
    - `gtest` (required only if enable `BUILD_TESTING`)
- `cppcheck` (optional)
- `clang-format` (optional)

## Features

- CMake-based project management, including dependencies
- Conan support for dependency management in CMake, completely optional
- Code check tools such as `clang-format`, `cppcheck`
- Sanitizers: Address Sanitizer, Leak Sanitizer, Undefined Behaviour Sanitizer, ...
- Support for shared/static libraries, including generation of export information
- Basic CPack configuration for redistributables
- Doxygen documentation generator (default `OFF`)

## Repository layout

The repository layout is pretty straightforward, including the CMake files to build the project, a `conanfile` where are declared examples of dependencies, a suppression list for cppcheck and the C++ source code:

```plain
-- .clang-format                - the clang-format rules for the C++ project
-- .clang-tidy                  - the clang-tidy rules for the C++ project
-- .gitignore                   - files to be excluded by git
+- `cmake/`                     - CMake modules
  | -- clang_format.cmake       - C++ header/source format, usage: `--target format`
  | -- clang_tidy.cmake         - C++ static check tool
  | -- compiler-options.cmake   - Common compiler options for major platforms/compilers
  | -- cpack.cmake              - Packaging configuration with CPack, usage: `--target doxygen-docs`
  | -- cppcheck.cmake           - C++ static check tool
  | -- dependencies.cmake       - Project dependencies
  | -- doxygen.cmake            - Generate documentation, usage: `--target doxygen-docs`
  | -- standard_options.cmake   - Standard options, can be overrided with "-D..."
-- CMakeLists.txt               - the main `CMake` Project configuration file
-- `apphello/`                  - your application files (including CMakeLists.txt, sources)
-- `libhello/`                  - your library1 files (including CMakeLists.txt, sources, `doctest`)
-- `libmymath/`                 - your library2 files (including CMakeLists.txt, sources, `gtest`)
-- conanfile.txt                - the main `conan` configuration file listing dependencies
-- cppcheck_suppressions.txt    - optional list of suppressions for cppcheck

-- `build/`                     - working directory for the build
-- `docs/`                      - generate docs by `doxygen` & `dot`
```

## Available CMake Options

Please see [Standard Options](cmake/standard_options.cmake) to check all available options.

## Why choose `conan` over `git submodules`?

1. Build time is shorter.
2. Dependencies management easier.

Note: you can also manage dependency with `vcpkg`.

## How to build from command line

The project can be built using the following commands:

```bash
cd [path/to/this/project]
bash compile_run_with_conan.sh
```

### Format (based on `clang-format`)

```bash
cmake -S . -B build
cmake --build build --target format
```

### Package (based on `CPack`)

```bash
cmake -S . -B build
cmake --build build --target package
```

### Generate Documentation (based on `doxygen` and `graphviz dot`)

Prerequisite: make sure `doxygen` and `dot` (graphviz-dot) are available in your $PATH.

For example, you can install them on Ubuntu with commands:

```bash
sudo apt update
sudo apt install -y doxygen graphviz
```

Specify `DOC_DIRS` in [top level CMakeLists.txt](./CMakeLists.txt):

```cmake
if(ENABLE_DOXYGEN)
  list(APPEND DOC_DIRS libhello libmymath)
  include(doxygen)
endif()
```

Add option `ENABLE_DOXYGEN` to automatic generate docs

```bash
cmake -S . -B build -DENABLE_DOXYGEN=ON
cmake --build build
```
