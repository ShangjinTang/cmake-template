#pragma once

/**
 * @file
 * @brief libhello
 */

#include <string>

namespace foo {
class Hello {
public:
    /**
     * @brief say something
     * @param something  the content you want to say
     */
    [[nodiscard]] int32_t saySomething(const std::string &something) const noexcept;
};
}  // namespace foo
