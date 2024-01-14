#include "libbar.h"

#include <gsl/gsl>

int bar::get_fibonacci_at_index(int index) {
    Ensures(index > 0);
    if (index == 1 || index == 2) {
        return 1;
    }
    return bar::get_fibonacci_at_index(index - 1) + bar::get_fibonacci_at_index(index - 2);
}
