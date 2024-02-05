# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# External Dependencies

find_package(fmt QUIET REQUIRED)
find_package(spdlog QUIET REQUIRED)
find_package(Microsoft.GSL QUIET REQUIRED)
find_package(absl QUIET REQUIRED)
if(BUILD_TESTING)
  find_package(doctest QUIET REQUIRED)
  find_package(GTest QUIET REQUIRED)
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
