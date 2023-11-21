# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# Compiler options with hardening flags

#
# Package manager
#

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

option(ENABLE_CLANG_TIDY "Enable static analysis with clang-tidy." ON)
option(ENABLE_CPPCHECK "Enable static analysis with cppcheck." ON)

#
# Code coverage
#

option(ENABLE_CODE_COVERAGE "Enable code coverage through GCC." ON)

#
# Doxygen documentation
#

option(ENABLE_DOXYGEN "Enable Doxygen documentation builds of source." ON)

#
# Misc options
#

option(ENABLE_CCACHE
       "Enable the usage of Ccache, in order to speed up rebuild times." ON)
option(BUILD_WITH_MT "Build libraries as MultiThreaded DLL (Windows Only)"
       FALSE)

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
