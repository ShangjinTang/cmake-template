# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#

set(MY_CUSTOM_MAJOR_VERSION 1)
set(MY_CUSTOM_MINOR_VERSION 0)
set(MY_CUSTOM_PATCH_VERSION 0)
set(MY_CUSTOM_VERSION
    ${MY_CUSTOM_MAJOR_VERSION}.${MY_CUSTOM_MINOR_VERSION}.${MY_CUSTOM_PATCH_VERSION}
)

# set $TARGET_NAME as current directory name
get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)

if(TARGET_NAME MATCHES "^lib")
  set(IS_CURRENT_BUILD_LIB ON)
elseif(TARGET_NAME MATCHES "^app")
  set(IS_CURRENT_BUILD_LIB OFF)
endif()

# linked libraries
#
list(APPEND PRIVATE_LINKED_LIBRARIES ${COMMON_LINKED_LIBRARIES})

if(NOT IS_CURRENT_BUILD_LIB)
  list(APPEND PRIVATE_LINKED_LIBRARIES ${COMMON_LINKED_TEST_LIBRARIES})
endif()

if(BUILD_TESTING)
  set(TEST_LINKED_LIBRARIES ${COMMON_LINKED_TEST_LIBRARIES})
endif()

# ##############################################################################
# Define Target Information
# ##############################################################################
list(APPEND PUBLIC_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/inc)
list(APPEND PRIVATE_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src)
if(NOT IS_CURRENT_BUILD_LIB)
  foreach(lib_name ${PROJECT_LIB_NAMES})
    list(APPEND PRIVATE_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/${lib_name}/inc})
    list(APPEND PRIVATE_LINKED_LIBRARIES ${lib_name})
  endforeach()
endif()
file(GLOB SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
file(GLOB TEST_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp)

# list(APPEND PUBLIC_LINKED_LIBRARIES ...)

# ##############################################################################
# Support IDE Visualization
# ##############################################################################
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCE_FILES})

# ##############################################################################
# Define Target according to options
# ##############################################################################
if(IS_CURRENT_BUILD_LIB)
  if(BUILD_SHARED_LIBS)
    add_library(${TARGET_NAME} SHARED ${SOURCE_FILES})
  else()
    add_library(${TARGET_NAME} STATIC ${SOURCE_FILES})
  endif()
  # generate an export header to expose symbols when using the library
  generate_export_header(${TARGET_NAME} EXPORT_FILE_NAME
                         ${CMAKE_BINARY_DIR}/exports/${TARGET_NAME}_export.h)
else()
  add_executable(${TARGET_NAME} ${SOURCE_FILES})
endif()

# ##############################################################################
# Define Target Properties
# ##############################################################################

# if executable name starts with 'app', remove prefix 'app' as output name
if(IS_CURRENT_BUILD_LIB)
  # if lib name starts with 'lib', remove it to avoid duplicate prefix 'lib'
  get_filename_component(LIB_NAME ${TARGET_NAME} NAME)
  string(REGEX REPLACE "^lib" "" LIB_NAME ${LIB_NAME})

  file(GLOB PUBLIC_HEADER_FILES ${CMAKE_CURRENT_SOURCE_DIR}/inc/*.h
       ${CMAKE_CURRENT_SOURCE_DIR}/inc/*.hpp
       ${CMAKE_BINARY_DIR}/exports/${TARGET_NAME}_export.h)

  set_target_properties(
    ${TARGET_NAME}
    PROPERTIES DEBUG_POSTFIX "-d"
               MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_TYPE}"
               VERSION ${CMAKE_PROJECT_VERSION}
               SOVERSION ${MY_CUSTOM_MAJOR_VERSION}
               PUBLIC_HEADER "${PUBLIC_HEADER_FILES}"
               OUTPUT_NAME ${LIB_NAME})
else()
  get_filename_component(EXECUTABLE_NAME ${TARGET_NAME} NAME)
  string(REGEX REPLACE "^app" "" EXECUTABLE_NAME ${EXECUTABLE_NAME})

  # add target properties such as debug postfix, MSVC Runtime and binary version
  set_target_properties(
    ${TARGET_NAME}
    PROPERTIES DEBUG_POSTFIX "-d"
               MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_TYPE}"
               VERSION ${CMAKE_PROJECT_VERSION}
               VERSION ${MY_CUSTOM_VERSION}
               OUTPUT_NAME ${EXECUTABLE_NAME})
endif()
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
  PUBLIC ${PUBLIC_INCLUDE_DIRS} $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/exports>
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
    target_link_libraries(${TEST_CASE} PRIVATE ${TEST_LINKED_LIBRARIES})
    if(IS_CURRENT_BUILD_LIB)
      target_link_libraries(${TEST_CASE} PRIVATE ${TARGET_NAME})
    endif()
    target_compile_options(${TEST_CASE} PRIVATE ${compiler_options})
    target_compile_definitions(${TEST_CASE} PRIVATE ${compiler_definitions})
    target_link_options(${TEST_CASE} PRIVATE ${linker_flags})

    target_include_directories(
      ${TEST_CASE}
      PUBLIC $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/exports>
      PRIVATE ${PUBLIC_INCLUDE_DIRS} ${PRIVATE_INCLUDE_DIRS})

    add_test(NAME ${TEST_CASE} COMMAND ${TEST_CASE})
  endforeach(TEST_CASE ${TEST_CASES})
endif()
