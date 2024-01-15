# Modern Cmake Template

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging.

Note: files are globbed here, and it's an anti-pattern in CMake. It's used for simplifying file configuration while developing prototypes / demos.

## Introduction

Every subdirectory is a standalone project, starts with either `app` or `lib`

- Directory tree should be as below:
  ```text
  .
  ├── app<app_name>
  │   ├── CMakeLists.txt
  │   ├── inc/  # public header files
  │   ├── src/  # sources, private header files
  │   └── test/  # test files
  ├── lib<lib_name>
  │   ├── CMakeLists.txt
  │   ├── inc/  # public header files
  │   ├── src/  # sources, private header files
  │   └── test/  # test files
  ├── ...
  ├── CMakeLists.txt
  └── README.md
  ```
- Use the same `CMakeLists.txt` for every subdirectory (either `app` or `lib`).
- By default, all executables in `app*` are linked with `lib*`:
  - `appdemo` is linked with library `libfoo` and `libbar`
- You can delete all `lib*` for executable-only project.
- Link useful libraries for every subdirectory without install first, including:
  - common libraries:
    - `fmt`
    - `spdlog`
    - `ms-gsl`
    - `abseil`
  - test libraries:
    - `doctest`
    - `gtest`

## Resources

- CMake:
  - Official: [Getting Started](https://cmake.org/getting-started/)
  - OnLine Book: [Modern CMake](https://cliutils.gitlab.io/modern-cmake/)
  - Introduction Video: [CppCon 2017: Mathieu Ropert “Using Modern CMake Patterns to Enforce a Good Modular Design”](https://www.youtube.com/watch?v=eC9-iRN2b04)
- Conan:
  - Official: [conan.io](https://conan.io/)

## Requirements

- a modern C++20 compiler (suggest to use `gcc-13`, `clang-17`, `MSVC 2022` or above)
- [`cmake`](https://cmake.org) 3.15+
- either [`conan`](https://conan.io) 2.0+ (recommend) or `git submodule`
- `cppcheck` (optional for code check, default disabled)
- `clang-tidy` (optional for code check, default disabled)
- `clang-format` (optional for code format, default disabled)
- `doxygen` & `graphviz` (optional for documentation generation, default disabled)

## Features

- CMake-based project management, including dependencies
- Conan support for dependency management in CMake, completely optional
- Code check tools such as `clang-format`, `cppcheck`
- Sanitizers: Address Sanitizer, Leak Sanitizer, Undefined Behaviour Sanitizer, ...
- Support for shared/static libraries, including generation of export information
- Basic CPack configuration for redistributables
- Documentation generator using `doxygen`

## Repository layout

The repository layout is pretty straightforward, including the CMake files to build the project, a `conanfile` where are declared examples of dependencies, a suppression list for cppcheck and the C++ source code:

```text
-- .clang-format                - the clang-format rules for the C++ project
-- .clang-tidy                  - the clang-tidy rules for the C++ project
-- .gitignore                   - files to be excluded by git
+- `cmake/`                     - CMake modules
  | -- clang_format.cmake       - C++ header/source format, usage: `--target format`
  | -- clang_tidy.cmake         - C++ static check tool
  | -- compiler-options.cmake   - Common compiler options for major platforms/compilers
  | -- cpack.cmake              - Packaging configuration with CPack, usage: `--target cpack`
  | -- cppcheck.cmake           - C++ static check tool
  | -- dependencies.cmake       - Project dependencies
  | -- doxygen.cmake            - Generate documentation, usage: `-DENABLE_DOXYGEN`
  | -- standard_options.cmake   - Standard options, can be overrided with "-D..."
-- CMakeLists.txt               - the main `CMake` Project configuration file
-- `appdemo/`                   - application files (including CMakeLists.txt, sources)
-- `libfoo/`                    - a library example (including CMakeLists.txt, sources, tests)
-- `libbar/`                    - another library example (including CMakeLists.txt, sources, tests)
-- conanfile.txt                - the main `conan` configuration file listing dependencies
-- cppcheck_suppressions.txt    - optional list of suppressions for cppcheck

-- `build/`                     - working directory for the build
-- `doc/`                       - generate doc by `doxygen` and convert to `sphinx`

-- compile_run_with_conan.sh    - compile script
-- compile_run_without_conan.sh - compile script
```

## Available CMake Options

Please see [Standard Options](cmake/standard_options.cmake) to check all available options.

## Why choose `conan` over `git submodules`?

1. Build time is shorter.
2. Dependencies management easier.

Note: you can also manage dependency with `vcpkg`.

## How to build from command line

The project can be built using `conan` with `pipx`:

```bash
python3 -m pip install pipx && pipx install conan
./compile_run_with_conan.sh
```

or using git submodules:

```bash
./compile_run_without_conan.sh
```

## Features

### Test

1. Add option `BUILD_TESTING` to automatic generate docs.

   ```bash
   cmake -S . -B build -DBUILD_TESTING=ON
   ```

2. Run tests.

   ```bash
   ctest --testdir build
   ```

### Code Format (based on `clang-format`)

1. Prerequisites: make sure `clang-format` is available in your $PATH.

   For example, you can install them on Ubuntu with commands:

   ```bash
   sudo apt update
   sudo apt install -y clang-format
   ```

2. Add option `ENABLE_CLANG_FORMAT` to automatic generate docs.

   ```bash
   cmake -S . -B build -DENABLE_CLANG_FORMAT=ON
   cmake --build build
   ```

### Generate Documentation with Doxygen

1. Prerequisites: make sure [`doxygen`](https://github.com/doxygen/doxygen) and [`dot`](https://graphviz.org/) are available in your $PATH.

   For example, you can install them on Ubuntu with commands:

   ```bash
   sudo apt update
   sudo apt install -y doxygen graphviz
   ```

2. Specify `DOC_DIRS` in [top level CMakeLists.txt](./CMakeLists.txt).

3. Add option `ENABLE_DOXYGEN` to automatic generate docs.

   ```bash
   cmake -S . -B build -DENABLE_DOXYGEN=ON
   cmake --build build
   ```

   The documents will be generated in `docs/html`.

### Package (based on `CPack`)

1. Use target `package` to pack.

   It's recommended to build package with `Release` build type.

   ```bash
   cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
   cmake --build build --target package
   ```

   or

   ```bash
   cmake -S . -B build
   cd build
   cpack
   ```
