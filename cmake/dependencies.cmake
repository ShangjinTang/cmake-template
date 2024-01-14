# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# External Dependencies

if(USE_CONAN)

  find_package(fmt REQUIRED)
  find_package(spdlog REQUIRED)
  find_package(Microsoft.GSL REQUIRED)
  if(BUILD_TESTING)
    find_package(doctest REQUIRED)
    find_package(GTest REQUIRED)
  endif()

else(USE_CONAN)

  function(add_git_submodule dir)
    find_package(Git REQUIRED)
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
  if(BUILD_TESTING)
    add_git_submodule(external/doctest)
    add_git_submodule(external/googletest)
  endif()

endif()
