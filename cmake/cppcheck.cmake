# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# cppcheck instructions

if(NOT ENABLE_CPPCHECK)
  return()
endif()

find_program(CPPCHECK_BIN NAMES cppcheck)
if(CPPCHECK_BIN)
  message(STATUS "Found: cppcheck")
  list(
    APPEND
    CMAKE_CXX_CPPCHECK
    "${CPPCHECK_BIN}"
    "--enable=all"
    "--enable=warning,performance,portability,information"
    "--inconclusive"
    "--check-config"
    "--force"
    "--inline-suppr"
    "--suppressions-list=${CMAKE_SOURCE_DIR}/cppcheck_suppressions.txt"
    "--xml"
    "--output-file=${CMAKE_BINARY_DIR}/cppcheck.xml")
  message("cppcheck finished setting up.")
else()
  message(SEND_ERROR "cppcheck requested but executable not found.")
endif()
