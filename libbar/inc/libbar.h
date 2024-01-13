#pragma once

/**
 * @file
 * @brief The main entry points of our demo
 */

namespace mymath {

/**
 * @brief Performs add
 * @param lhs   left side
 * @param rhs   right side
 */
int add(int lhs, int rhs);

/**
 * @brief Performs substract
 * @param lhs   left side
 * @param rhs   right side
 */
int sub(int lhs, int rhs);

/**
 * @brief Get the `i`th from Fibonacci sequence (1, 1, 2, 3, 5, 8 ,...)
 * @param index
 */
int get_fibonacci_at_index(int index);

}  // namespace mymath
