# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# Main CMake Project file

# ##############################################################################
# Define Project-Wide Settings
# ##############################################################################
cmake_minimum_required(VERSION 3.15)

# Define the Project Name and Description
project(
  project-hello
  LANGUAGES CXX
  DESCRIPTION "")

set(AUTHUR "shangjin.tang@gmail.com")
set(PROJECT_NAME "AppHello")

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
message(
  STATUS
    "Started CMake for ${CMAKE_PROJECT_NAME} v${CMAKE_PROJECT_VERSION}...\n")

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
  add_subdirectory(apphello)
endif()
add_subdirectory(libhello)
add_subdirectory(libmymath)

# generate docs
set(DOC_DIRS
    ${PROJECT_SOURCE_DIR}/libhello/inc ${PROJECT_SOURCE_DIR}/libhello/src
    ${PROJECT_SOURCE_DIR}/libmymath/inc ${PROJECT_SOURCE_DIR}/libmymath/src)
include(doxygen)
add_subdirectory(doc)
# ##############################################################################
# Define Install Targets
# ##############################################################################
if(BUILD_EXECUTABLE)
  install(
    TARGETS apphello
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include)
endif()

install(
  TARGETS libhello libmymath
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  PUBLIC_HEADER DESTINATION include)

install(FILES ${CMAKE_SOURCE_DIR}/libhello/inc/libhello.h
              ${CMAKE_BINARY_DIR}/exports/libhello_export.h
        DESTINATION include/libhello)

install(FILES ${CMAKE_SOURCE_DIR}/LICENSE DESTINATION .)
