# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# Clang-Format instructions

find_program(CLANG_FORMAT_BIN NAMES clang-format)

if(CLANG_FORMAT_BIN)
  message(STATUS "Found: clang-format")
  file(GLOB_RECURSE CPP_SOURCE_FILES *.c *.cpp)
  file(GLOB_RECURSE CPP_HEADER_FILES *.h *.hpp)

  add_custom_target(
    format-sources
    COMMENT "Running clang-format for sources ..."
    COMMAND clang-format --style=file -i ${CPP_SOURCE_FILES}
    COMMAND_EXPAND_LISTS VERBATIM)

  add_custom_target(
    format-headers
    COMMENT "Running clang-format for headers ..."
    COMMAND clang-format --style=file -i ${CPP_HEADER_FILES}
    COMMAND_EXPAND_LISTS VERBATIM)

  add_custom_target(
    clang-format
    COMMENT "Running clang-format ..."
    DEPENDS format-sources format-headers)

  add_custom_target(
    format
    COMMENT "Running format (alias for clang-format) ..."
    DEPENDS clang-format)
endif()
