#pragma once

#include "libbar_export.h"

/**
 * @file
 * @brief The main entry points of our demo
 */

namespace bar {

/**
 * @brief Get the `i`th from Fibonacci sequence (1, 1, 2, 3, 5, 8 ,...)
 * @param index
 */
int LIBBAR_EXPORT get_fibonacci_at_index(int index);

}  // namespace bar
