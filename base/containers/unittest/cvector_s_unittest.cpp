#include <stdio.h>
#include <iostream>
#include <string>
#include <gtest/gtest.h>
#include <containers/cvector_s.h>

const int my_vector_elem_max_size = 1024;
const int my_vector_elems_max_count = 4;

static char my_vector_buffer_g[my_vector_elems_max_count][my_vector_elem_max_size];
static cvector_s_t my_vector_g;


TEST(cvector_s_unittest, create)
{
    const auto res = cvector_s_create(&my_vector_g, my_vector_elem_max_size, my_vector_elems_max_count, (char*)my_vector_buffer_g);
    EXPECT_EQ(1, res);
    EXPECT_EQ(0, cvector_s_size(&my_vector_g));
    EXPECT_EQ(0, cvector_s_full(&my_vector_g));
    EXPECT_EQ(1, cvector_s_empty(&my_vector_g));
}

