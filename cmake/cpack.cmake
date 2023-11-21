# MIT License 
# Copyright (c) 2023 Shangjin Tang <shangjin.tang@gmail.com>
#
# Packaging instructions

set(CPACK_PACKAGE_VENDOR "Shangjin Tang <shangjin.tang@gmail.com>")
set(CPACK_PACKAGE_VERSION_MAJOR "${CMAKE_PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${CMAKE_PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${CMAKE_PROJECT_VERSION_PATCH}")
set(CPACK_GENERATOR "ZIP;TGZ")
set(CPACK_STRIP_FILES "TRUE")

include(CPack)
