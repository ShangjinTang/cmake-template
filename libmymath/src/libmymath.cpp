#include "libmymath.h"

#include <gsl/gsl>

int libmymath::add(int lhs, int rhs) {
    return lhs + rhs;
}

int libmymath::sub(int lhs, int rhs) {
    return lhs - rhs;
}

int libmymath::get_fibonacci_at_index(int index) {
    Ensures(index > 0);
    if (index == 1 || index == 2) {
        return 1;
    }
    return libmymath::get_fibonacci_at_index(index - 1) + libmymath::get_fibonacci_at_index(index - 2);
}
