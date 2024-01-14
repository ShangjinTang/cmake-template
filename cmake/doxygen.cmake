# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# doxygen documetation generate

if(NOT ENABLE_DOXYGEN)
  return()
endif()

if(DEFINED DOC_DIRS AND NOT "${DOC_DIRS}" STREQUAL "")
  foreach(doc_dir ${DOC_DIRS})
    if(NOT IS_DIRECTORY ${doc_dir})
      message(SEND_ERROR "Directory ${doc_dir} does not exist.")
    endif()
  endforeach()
endif()

find_package(Doxygen COMPONENTS dot)
if(DOXYGEN_FOUND)
  message(STATUS "Found package: doxygen & graphviz-dot")
  set(DOXYGEN_CALLER_GRAPH YES)
  set(DOXYGEN_CALL_GRAPH YES)
  set(DOXYGEN_EXTRACT_ALL YES)
  set(DOXYGEN_GENERATE_HTML YES)
  set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
  doxygen_add_docs(
    doxygen-doc ALL ${DOC_DIRS}
    COMMENT "Generating documentation with doxygen & graphviz-dot")
else()
  message(WARNING "doxygen & graphviz-dot requested but not found.
    Please install 'doxygen' and 'graphviz' first.")
endif()
