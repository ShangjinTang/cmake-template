#include "libbar.h"

#include <gsl/gsl>

int mymath::add(int lhs, int rhs) {
    return lhs + rhs;
}

int mymath::sub(int lhs, int rhs) {
    return lhs - rhs;
}

int mymath::get_fibonacci_at_index(int index) {
    Ensures(index > 0);
    if (index == 1 || index == 2) {
        return 1;
    }
    return mymath::get_fibonacci_at_index(index - 1) + mymath::get_fibonacci_at_index(index - 2);
}
