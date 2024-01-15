#pragma once

/**
 * @file
 * @brief libhello
 */

#include <string>

#include "libfoo_export.h"

namespace foo {
class LIBFOO_EXPORT Hello {
public:
    /**
     * @brief say something
     * @param something  the content you want to say
     */
    [[nodiscard]] int32_t saySomething(const std::string &something) const noexcept;
};
}  // namespace foo
