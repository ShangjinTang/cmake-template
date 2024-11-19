# MIT License Copyright (c) 2023-2024 Shangjin Tang <shangjin.tang@gmail.com>
#
# External Dependencies

find_package(fmt CONFIG REQUIRED)
find_package(spdlog CONFIG REQUIRED)
find_package(Microsoft.GSL CONFIG REQUIRED)
find_package(CLI11 CONFIG REQUIRED)
if(BUILD_TESTING)
    find_package(GTest CONFIG REQUIRED)
    find_package(doctest CONFIG REQUIRED)
endif()

# ##############################################################################

# common libraries
list(APPEND COMMON_LINKED_LIBRARIES fmt::fmt)
list(APPEND COMMON_LINKED_LIBRARIES spdlog::spdlog)
list(APPEND COMMON_LINKED_LIBRARIES Microsoft.GSL::GSL)
list(APPEND COMMON_LINKED_LIBRARIES CLI11::CLI11)

# test libraries
if(BUILD_TESTING)
    list(APPEND COMMON_LINKED_TEST_LIBRARIES GTest::gtest GTest::gtest_main)
    list(APPEND COMMON_LINKED_TEST_LIBRARIES doctest::doctest)
endif()

# ##############################################################################
