# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# Main CMake Project file

# ##############################################################################
# Define Project-Wide Settings
# ##############################################################################
cmake_minimum_required(VERSION 3.15)

# Define the Project Name and Description
project(
  cmake-demo
  LANGUAGES CXX
  DESCRIPTION "")

set(AUTHUR "shangjin.tang@gmail.com")
set(PROJECT_NAME "CMakeDemo")

# Set Project version (used for library versioning and for CPack)
set(CMAKE_PROJECT_VERSION_MAJOR 1)
set(CMAKE_PROJECT_VERSION_MINOR 0)
set(CMAKE_PROJECT_VERSION_PATCH 0)
set(CMAKE_PROJECT_VERSION
    ${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR}.${CMAKE_PROJECT_VERSION_PATCH}
)

# Prevent building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "Build in source directory is not allowed. Please specify a build directory as below:
    cmake [options] -S . -B build\n")
endif()

# Start building
message(VERBOSE "Building ${CMAKE_PROJECT_NAME} v${CMAKE_PROJECT_VERSION}...")

# Set required C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
# Generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
# Set the Relative Path Configurations
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
# Define installation folder and the module path (this one required by conan)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR} ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR} ${CMAKE_PREFIX_PATH})

# ##############################################################################
# Define CMake Module Imports
# ##############################################################################
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(InstallRequiredSystemLibraries)
include(GenerateExportHeader)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# configurations
include(standard_options)
include(compiler_options)
include(dependencies)

# tools
include(clang_tidy)
include(clang_format)
include(cpack)
include(cppcheck)

# ##############################################################################
# Define Targets
# ##############################################################################
if(BUILD_EXECUTABLE)
  add_subdirectory(appdemo)
endif()
add_subdirectory(libfoo)
add_subdirectory(libbar)

# generate docs
if(BUILD_EXECUTABLE)
  set(DOC_DIRS ${PROJECT_SOURCE_DIR}/appdemo/inc
               ${PROJECT_SOURCE_DIR}/appdemo/src)
else()
  set(DOC_DIRS
      ${PROJECT_SOURCE_DIR}/libfoo/inc ${PROJECT_SOURCE_DIR}/libfoo/src
      ${PROJECT_SOURCE_DIR}/libbar/inc ${PROJECT_SOURCE_DIR}/libbar/src)
endif()
include(doxygen)

# ##############################################################################
# Define Install Targets
# ##############################################################################
if(BUILD_EXECUTABLE)
  install(
    TARGETS appdemo
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include)
else()
  install(
    TARGETS libfoo libbar
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include)
endif()

install(FILES ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION .)
