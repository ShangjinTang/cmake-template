# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# clang-tidy instructions

if(NOT ENABLE_CLANG_TIDY)
  return()
endif()

find_program(CLANG_TIDY_BIN NAMES clang-tidy)
if(CLANG_TIDY_BIN)
  message(STATUS "Found: clang-tidy")
  list(APPEND CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_BIN}"
       "-extra-arg=-Wno-unknown-warning-option")
  message("clang-tidy finished setting up.")
else()
  message(SEND_ERROR "clang-tidy requested but executable not found.")
endif()
