# MIT License Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#

# Required Dependencies
if(USE_CONAN)
  find_package(fmt REQUIRED)
  find_package(spdlog REQUIRED)
else(USE_CONAN)
  add_git_submodule(external/fmt)
  add_git_submodule(external/spdlog)
endif()

# Required for Testing
if(BUILD_TESTING)
  if(USE_CONAN)
    find_package(doctest REQUIRED)
    find_package(GTest REQUIRED)
  else(USE_CONAN)
    add_git_submodule(external/doctest)
    add_git_submodule(external/googltest)
  endif()
endif()
