# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# Compiler options with hardening flags

option(CMAKE_BUILD_TYPE "CMake build type." "Debug")

#
# Package manager
#

# dependencies: conan (install with `pip3 install conan`)
option(USE_CONAN "Use the Conan package manager for this project." ON)

#
# Project settings
#

option(BUILD_TESTING "Build tests by default" ON)
option(BUILD_EXECUTABLE
       "Build the project as an executable, rather than a library." ON)
option(BUILD_HEADERS_ONLY "Build the project as a header-only library." OFF)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

#
# Compiler options
#

option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors." OFF)

#
# Static analyzers
#

# dependencies: cppcheck
option(ENABLE_CPPCHECK "Enable static analysis with cppcheck." OFF)
# dependencies: clang-tidy
option(ENABLE_CLANG_TIDY "Enable static analysis with clang-tidy." OFF)

#
# Code Format
#

# dependencies: clang-format
option(ENABLE_CLANG_FORMAT "Enable code format with clang-format." OFF)

#
# Doxygen documentation
#

# dependencies: doxygen, graphviz dot
option(ENABLE_DOXYGEN "Enable Doxygen documentation builds of source." OFF)

#
# Enable Sanitizers (only for Debug version)
#

option(ENABLE_DEBUG_ASAN "Enable Address Sanitizer in Debug Build" ON)
option(ENABLE_DEBUG_LSAN "Enable Address Sanitizer in Debug Build" ON)
option(ENABLE_DEBUG_UBSAN "Enable UndefinedBehavior Sanitizer in Debug Build"
       ON)
# TSAN is conflict with ASAN, do not enable at the same time
option(ENABLE_DEBUG_TSAN "Enable Thread Sanitizer in Debug Build" OFF)
if(ENABLE_DEBUG_ASAN AND ENABLE_DEBUG_TSAN)
  message(
    FATAL_ERROR
      "Do not use AddressSanitizer and ThreadSanitizer at the same time.")
endif()

#
# Misc options
#

option(ENABLE_CCACHE
       "Enable the usage of Ccache, in order to speed up rebuild times." ON)
if(MSVC)
  option(BUILD_WITH_MT "Build libraries as MultiThreaded DLL (Windows Only)"
         FALSE)
endif()

if(BUILD_SHARED_LIBS)
  set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
  set(CMAKE_CXX_VISIBILITY_PRESET hidden)
  set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
endif()

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif()

if(BUILD_TESTING)
  enable_testing()
endif()
