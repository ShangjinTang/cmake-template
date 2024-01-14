#include "libfoo.h"

#include <iostream>

using foo::Hello;

int32_t Hello::saySomething(const std::string &something) const noexcept {
    if (something.empty()) {
        std::cerr << "No value passed\n";
        return 1;
    }

    std::cout << something << '\n';
    return 0;
}
