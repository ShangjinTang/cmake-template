#include <iostream>
#include <string>

#include "fmt/core.h"
#include "spdlog/spdlog.h"

#define ENABLE_CUSTOM_LIBS
#define ENABLE_MSGSL_EXAMPLES
#define ENABLE_CXXOPTS
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

#ifdef ENABLE_CXXOPTS
#include "cxxopts.hpp"
#endif

#ifdef ENABLE_MSGSL_EXAMPLES
#include "gsl/pointers"
size_t getStringLength(gsl::not_null<std::string *> strPtr) {
    return strPtr->length();
}
#endif

int main([[maybe_unused]] int argc, [[maybe_unused]] char *argv[]) {
#ifdef ENABLE_CXXOPTS
    cxxopts::Options options("demo", "A demo program of cmake-template");
    /* clang-format off */
    options.add_options()
        ("powered_by", "Powered-By Information", cxxopts::value<std::string>()->default_value("cxxopts"))
        ("h, help", "Print usage")
    ;
    /* clang-format on */
    auto result = options.parse(argc, argv);
    if (static_cast<bool>(result.count("help"))) {
        std::cout << options.help() << std::endl;
        exit(0);
    }
    std::string powered_by = result["powered_by"].as<std::string>();
    std::cout << "Support parse flags, powered by: " << powered_by << std::endl;
#endif
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

#ifdef ENABLE_DOCTEST
    doctest::Context context;
    int doctest_res = context.run();
    context.applyCommandLine(argc, argv);
    if (context.shouldExit()) {
        return doctest_res;
    }
#endif

#ifdef ENABLE_GTEST
    ::testing::InitGoogleTest(&argc, argv);
    int gtest_res = RUN_ALL_TESTS();
    if (static_cast<bool>(gtest_res)) {
        return gtest_res;
    }
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
