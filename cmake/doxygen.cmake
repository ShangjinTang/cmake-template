# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# doxygen documetation generate

find_package(Doxygen COMPONENTS dot)
if(Doxygen_FOUND)
  message(STATUS "Found package: doxygen with component dot")
  set(DOXYGEN_CALLER_GRAPH YES)
  set(DOXYGEN_CALL_GRAPH YES)
  set(DOXYGEN_EXTRACT_ALL YES)
  set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)

  if(DEFINED DOC_DIRS AND NOT "${DOC_DIRS}" STREQUAL "")
    foreach(doc_dir ${DOC_DIRS})
      if(NOT IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${doc_dir})
        message(
          SEND_ERROR
            "Directory ${CMAKE_CURRENT_SOURCE_DIR}/${doc_dir} does not exist.")
      endif()
    endforeach()
    doxygen_add_docs(doxygen-docs ALL ${CMAKE_CURRENT_SOURCE_DIR}/${DOC_DIRS})
    message("doxygen with component dot finished setting up.")
  endif()

else()
  message(WARNING "doxygen with component dot requested but not found.
    Please install 'doxygen' and 'graphviz' first.")
endif()
