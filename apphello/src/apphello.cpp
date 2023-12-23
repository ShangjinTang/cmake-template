#include <iostream>

#include "libhello.h"
#include "libmymath.h"

using hello::libhello;

int main() {
    libhello hello{};
    int32_t error_code = hello.saySomething("Hello Modern C++ Development");
    if (error_code > 0) {
        return error_code;
    }

    // Fibonacci sequence: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
    std::cout << "fibonacci sequence at index 10 is: " << libmymath::get_fibonacci_at_index(10) << std::endl;
    return 0;
}
