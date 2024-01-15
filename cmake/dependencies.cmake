# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# External Dependencies

if(USE_CONAN)
  find_package(fmt QUIET REQUIRED)
  find_package(spdlog QUIET REQUIRED)
  find_package(Microsoft.GSL QUIET REQUIRED)
  find_package(absl QUIET REQUIRED)
  if(BUILD_TESTING)
    find_package(doctest QUIET REQUIRED)
    find_package(GTest QUIET REQUIRED)
  endif()

else(USE_CONAN)

  function(add_git_submodule dir)
    find_package(Git QUIET REQUIRED)
    if(NOT EXISTS ${dir}/CMakeLists.txt)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive -- ${dir}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()
    if(EXISTS ${dir}/CMakeLists.txt)
      list(APPEND CMAKE_PREFIX_PATH ${dir})
      add_subdirectory(${dir})
    endif()
  endfunction(add_git_submodule)

  add_git_submodule(external/fmt)
  add_git_submodule(external/spdlog)
  add_git_submodule(external/ms-gsl)
  add_git_submodule(external/abseil-cpp)
  if(BUILD_TESTING)
    add_git_submodule(external/doctest)
    add_git_submodule(external/googletest)
  endif()

endif()

# ##############################################################################

# common libraries
list(APPEND COMMON_LINKED_LIBRARIES fmt)
list(APPEND COMMON_LINKED_LIBRARIES spdlog::spdlog)
list(APPEND COMMON_LINKED_LIBRARIES Microsoft.GSL::GSL)
list(APPEND COMMON_LINKED_LIBRARIES absl::flags absl::flags_parse)

# test libraries
list(APPEND COMMON_LINKED_TEST_LIBRARIES gtest gtest_main)
list(APPEND COMMON_LINKED_TEST_LIBRARIES doctest::doctest)

# ##############################################################################
