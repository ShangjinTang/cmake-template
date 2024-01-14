#include "gtest/gtest.h"
#include "libbar.h"

TEST(LibBarTest, Sub) {
    EXPECT_EQ(bar::get_fibonacci_at_index(1), 1);
    EXPECT_EQ(bar::get_fibonacci_at_index(2), 1);
    EXPECT_EQ(bar::get_fibonacci_at_index(3), 2);
    EXPECT_EQ(bar::get_fibonacci_at_index(4), 3);
    EXPECT_EQ(bar::get_fibonacci_at_index(5), 5);
    EXPECT_EQ(bar::get_fibonacci_at_index(6), 8);
}
