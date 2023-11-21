#include <string>

#include "libhello_export.h"

namespace hello {
class LIBHELLO_EXPORT libhello {
public:
    [[nodiscard]] int32_t saySomething(const std::string &something) const noexcept;
};
}  // namespace hello
