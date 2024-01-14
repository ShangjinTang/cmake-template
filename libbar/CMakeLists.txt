# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# libbar target instructions
set(TARGET_NAME libbar)

# ##############################################################################
# Define Target Information
# ##############################################################################
list(APPEND PUBLIC_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/inc)
list(APPEND PRIVATE_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src)
file(GLOB PUBLIC_HEADER_FILES ${CMAKE_CURRENT_SOURCE_DIR}/inc/*.h
     ${CMAKE_CURRENT_SOURCE_DIR}/inc/*.hpp)
file(GLOB PRIVATE_HEADER_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.h
     ${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp)
file(GLOB SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
file(GLOB TEST_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp)

list(APPEND PRIVATE_LINKED_LIBRARIES Microsoft.GSL::GSL)

# list(APPEND PUBLIC_LINKED_LIBRARIES ...)

if(BUILD_TESTING)
  set(TEST_LINKED_LIBRARY gtest gtest_main)
endif()

# ##############################################################################
# Support IDE Visualization
# ##############################################################################
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCE_FILES})

# ##############################################################################
# Define Target according to options
# ##############################################################################
if(BUILD_SHARED_LIBS)
  add_library(${TARGET_NAME} SHARED ${SOURCE_FILES})
else()
  add_library(${TARGET_NAME} STATIC ${SOURCE_FILES})
endif()

# ##############################################################################
# Define Target Properties
# ##############################################################################

# if lib name starts with 'lib', remove it to avoid duplicate prefix 'lib'
get_filename_component(LIB_NAME ${TARGET_NAME} NAME_WE)
string(REGEX REPLACE "^lib" "" LIB_NAME ${LIB_NAME})

# add target properties such as debug postfix, MSVC Runtime and library version
set_target_properties(
  ${TARGET_NAME}
  PROPERTIES DEBUG_POSTFIX "-d"
             MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_TYPE}"
             VERSION ${CMAKE_PROJECT_VERSION}
             SOVERSION ${CMAKE_PROJECT_VERSION}
             PUBLIC_HEADER ${PUBLIC_HEADER_FILES}
             OUTPUT_NAME ${LIB_NAME})

# set target compile options as defined in the cmake/compiler_options.cmake
# Module
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})

# add compiler definition
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions})

# set target link options as defined in the cmake/compiler_options.cmake Module
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})

# link to target libraries
target_link_libraries(
  ${TARGET_NAME}
  PRIVATE ${PRIVATE_LINKED_LIBRARIES}
  PUBLIC ${PUBLIC_LINKED_LIBRARIES})

# include all the necessary directories
target_include_directories(
  ${TARGET_NAME}
  PUBLIC ${PUBLIC_INCLUDE_DIRS}
  PRIVATE ${PRIVATE_INCLUDE_DIRS})

if(BUILD_TESTING)
  foreach(TEST_SOURCE_FILE ${TEST_SOURCE_FILES})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/test/" "" STRIPPED_PATH
                   ${TEST_SOURCE_FILE})
    string(REPLACE ".cpp" "" STRIPPED_PATH ${STRIPPED_PATH})
    list(APPEND TEST_CASES ${STRIPPED_PATH})
  endforeach()

  foreach(TEST_CASE ${TEST_CASES})
    add_executable(${TEST_CASE} ${CMAKE_CURRENT_SOURCE_DIR}/test/${TEST_CASE})
    target_link_libraries(${TEST_CASE} PRIVATE ${TARGET_NAME}
                                               ${TEST_LINKED_LIBRARY})
    target_compile_options(${TEST_CASE} PRIVATE ${compiler_options})
    target_compile_definitions(${TEST_CASE} PRIVATE ${compiler_definitions})
    target_link_options(${TEST_CASE} PRIVATE ${linker_flags})

    target_include_directories(${TEST_CASE} PRIVATE ${PUBLIC_INCLUDE_DIRS}
                                                    ${PRIVATE_INCLUDE_DIRS})

    add_test(NAME ${TEST_CASE} COMMAND ${TEST_CASE})
  endforeach(TEST_CASE ${TEST_CASES})
endif()
