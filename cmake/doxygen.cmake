# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# doxygen documetation generate

if(ENABLE_DOXYGEN)
  find_package(Doxygen REQUIRED dot)
  if(Doxygen_FOUND)
    message(STATUS "Found package: doxygen")
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)

    doxygen_add_docs(doxygen-docs ALL ${PROJECT_SOURCE_DIR}/libhello/inc
                     ${PROJECT_SOURCE_DIR}/libmymath/inc)

    message(
      "Package doxygen has been setup and documentation is now available.")
  else()
    message(WARNING "Package doxygen requested but not found.")
  endif()
endif()
