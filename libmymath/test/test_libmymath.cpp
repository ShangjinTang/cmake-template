#include "gtest/gtest.h"
#include "libmymath.h"

// Demonstrate some basic assertions.
TEST(MyMathTest, Add) {
    EXPECT_EQ(libmymath::add(3, 4), 7);
    EXPECT_EQ(libmymath::add(38, 66), 104);
}

TEST(MyMathTest, Sub) {
    EXPECT_EQ(libmymath::sub(5, 2), 3);
    EXPECT_EQ(libmymath::sub(100, 7), 93);
}
