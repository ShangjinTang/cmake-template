if(NOT ENABLE_SPHINX)
  return()
endif()

if(DEFINED DOC_DIRS AND NOT "${DOC_DIRS}" STREQUAL "")
  foreach(doc_dir ${DOC_DIRS})
    if(NOT IS_DIRECTORY ${doc_dir})
      message(SEND_ERROR "Directory ${doc_dir} does not exist.")
    endif()
  endforeach()
endif()

find_package(Doxygen)

if(NOT DOXYGEN_FOUND)
  message(SEND_ERROR "doxygen with component dot requested but not found.")
  return()
endif()

message(STATUS "Found package: doxygen")

# just output XML since this is what Breathe consumes
set(DOXYGEN_CALLER_GRAPH NO)
set(DOXYGEN_CALL_GRAPH NO)
set(DOXYGEN_EXTRACT_ALL YES)
set(DOXYGEN_GENERATE_HTML NO)
set(DOXYGEN_GENERATE_XML YES)

# don't generate documentation from implementation details
# set(DOXYGEN_EXCLUDE_PATTERNS "*/detail/*")

# print paths relative to include directory
set(DOXYGEN_STRIP_FROM_PATH ${DOC_DIRS})

doxygen_add_docs(sphinx-doxygen-doc ${DOC_DIRS}
                 COMMENT "Generating documentation with Doxygen")

find_package(Sphinx REQUIRED)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/conf.py.in
               ${CMAKE_CURRENT_BINARY_DIR}/conf.py @ONLY)
add_custom_target(
  sphinx-doc ALL
  COMMAND ${SPHINX_EXECUTABLE} -b html -c ${CMAKE_CURRENT_BINARY_DIR}
          ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Generating API documentation with Sphinx"
  VERBATIM)

add_dependencies(sphinx-doc sphinx-doxygen-doc)
