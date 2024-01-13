#pragma once

/**
 * @file
 * @brief libhello
 */

#include <string>

namespace hello {
class libhello {
public:
    /**
     * @brief say something
     * @param something  the content you want to say
     */
    [[nodiscard]] int32_t saySomething(const std::string &something) const noexcept;
};
}  // namespace hello
