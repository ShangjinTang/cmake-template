#include "libhello.h"

#include <iostream>

using hello::libhello;

int32_t libhello::saySomething(const std::string &something) const noexcept {
    if (something.empty()) {
        std::cerr << "No value passed\n";
        return 1;
    }

    std::cout << something << '\n';
    return 0;
}
