#include <iostream>
#include <string>

#include "fmt/core.h"
#include "gsl/gsl"
#include "spdlog/spdlog.h"

#define ENABLE_CUSTOM_LIBS
#define ENABLE_MSGSL_EXAMPLES
#define ENABLE_ABSL_FLAGS
#define ENABLE_DOCTEST
#define ENABLE_GTEST

#ifdef ENABLE_CUSTOM_LIBS
#include "libbar.h"
#include "libfoo.h"
#endif

#ifdef ENABLE_DOCTEST
#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest/doctest.h"

TEST_CASE("Addition") {
    int a = 2;
    int b = 3;
    CHECK(a + b == 5);
}
#endif

#ifdef ENABLE_GTEST
#include "gtest/gtest.h"

// NOLINTNEXTLINE
TEST(Subtraction, Integers) {
    int a = 5;
    int b = 3;
    EXPECT_EQ(a - b, 2);
}
#endif

#ifdef ENABLE_ABSL_FLAGS
#include "absl/flags/flag.h"
#include "absl/flags/parse.h"

// abseil flags: ABSL_FLAG(type, name, default, help-text)
// NOLINTNEXTLINE
ABSL_FLAG(std::string, powered_by, "abseil-cpp", "Powered-By Information");
#endif

#ifdef ENABLE_MSGSL_EXAMPLES
size_t getStringLength(gsl::not_null<std::string *> strPtr) {
    return strPtr->length();
}
#endif

int main([[maybe_unused]] int argc, [[maybe_unused]] char *argv[]) {
    std::cout << "----------------------------------------------------------------------\n";

#ifdef ENABLE_CUSTOM_LIBS
    foo::Hello hello{};
    int32_t error_code = hello.saySomething("Hello Modern C++ Development");
    if (error_code > 0) {
        return error_code;
    }

    // Fibonacci sequence: 1, 1, 2, 3, 5, 8, ...
    std::cout << "fibonacci sequence at index 10 is: " << bar::get_fibonacci_at_index(10) << std::endl;
#endif

#ifdef ENABLE_ABSL_FLAGS
    absl::ParseCommandLine(argc, argv);
    std::cout << "Support parse flags, powered by: " << absl::GetFlag(FLAGS_powered_by) << std::endl;
#endif

#ifdef ENABLE_DOCTEST
    doctest::Context context;
    int doctest_res = context.run();
    context.applyCommandLine(argc, argv);
    if (context.shouldExit())
        return doctest_res;
#endif

#ifdef ENABLE_GTEST
    ::testing::InitGoogleTest(&argc, argv);
    int gtest_res = RUN_ALL_TESTS();
    if (gtest_res)
        return gtest_res;
#endif

#ifdef ENABLE_MSGSL_EXAMPLES
    std::string str = "ms-gsl";
    fmt::print("Length of string '{}' is: {}\n", str, getStringLength(&str));
#endif

    fmt::print("{}, {}!\n", "Hello", "{fmt}");
    spdlog::info("Welcome to spdlog!");

    std::cout << "----------------------------------------------------------------------\n";
    return 0;
}
