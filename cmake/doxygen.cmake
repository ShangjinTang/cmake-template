# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# doxygen documetation generate

if(ENABLE_DOXYGEN)
  find_package(Doxygen COMPONENTS dot)
  if(Doxygen_FOUND)
    message(STATUS "Found package: doxygen with component dot")
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
    set(DOXYGEN_EXCLUDE_PATTERNS "*/test/*" "*/external/*")

    doxygen_add_docs(doxygen-docs ALL ${CMAKE_CURRENT_SOURCE_DIR})
    message("doxygen with component dot finished setting up.")

  else()

    message(WARNING "doxygen with component dot requested but not found.
    Please install 'doxygen' and 'graphviz' first.")

  endif()
endif()
