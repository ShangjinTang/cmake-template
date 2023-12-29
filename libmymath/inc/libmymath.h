#pragma once

/**
 * @file
 * @brief The main entry points of our demo
 */

#include "libmymath_export.h"

namespace libmymath {

/**
 * @brief Performs add
 * @param lhs   left side
 * @param rhs   right side
 */
int LIBMYMATH_EXPORT add(int lhs, int rhs);

/**
 * @brief Performs substract
 * @param lhs   left side
 * @param rhs   right side
 */
int LIBMYMATH_EXPORT sub(int lhs, int rhs);

/**
 * @brief Get the `i`th from Fibonacci sequence (1, 1, 2, 3, 5, 8 ,...)
 * @param index
 */
int LIBMYMATH_EXPORT get_fibonacci_at_index(int index);

}  // namespace libmymath
