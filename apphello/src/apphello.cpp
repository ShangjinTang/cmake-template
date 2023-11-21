#include "libhello.h"

using hello::libhello;

int main() {
    libhello hello{};
    int32_t error_code = hello.saySomething("Hello Modern C++ Development");
    if (error_code > 0) {
        return error_code;
    }
    return 0;
}
