#include "gtest/gtest.h"
#include "libbar.h"

// Demonstrate some basic assertions.
TEST(MyMathTest, Add) {
    EXPECT_EQ(mymath::add(3, 4), 7);
    EXPECT_EQ(mymath::add(38, 66), 104);
}

TEST(MyMathTest, Sub) {
    EXPECT_EQ(mymath::sub(5, 2), 3);
    EXPECT_EQ(mymath::sub(100, 7), 93);
}
