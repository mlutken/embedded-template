#include <containers/cvector_s.h>
#include <stdio.h>
#include <string.h>
#include <version/git_info.h>
#include <version/version_info.h>

#define my_fifo_elem_max_size 1024
#define my_fifo_elems_max_count 32

static char my_vector_buffer_g[my_fifo_elems_max_count][my_fifo_elem_max_size];
static cvector_s_t my_vector_g;

static int test_vector_s_push_back_size(const char* str)
{
    return cvector_s_push_back_size(&my_vector_g, str, strlen(str));
}

static int test_vector_s_insert_size(size_t index, const char* str)
{
    return cvector_s_insert_size(&my_vector_g, index, str, strlen(str));
}

static void test_print_vector_s(cvector_s_t* self)
{
    for (size_t i = 0; i < cvector_s_size(self); ++i) {
        printf("my_vec[%zu]: '%s'\n", i, cvector_s_get(self, i));
    }
}

int main()
{
    printf("*** cvector_s playground ***\n");
    const int res = cvector_s_create(&my_vector_g, my_fifo_elem_max_size, my_fifo_elems_max_count, (char*)my_vector_buffer_g);
    printf("cvector_s_create()         : '%d'\n", res);
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));

    printf("cvector_s_push('first')    : '%d'\n", test_vector_s_push_back_size("first"));
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d', back: '%s'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g), cvector_s_back(&my_vector_g));
    printf("cvector_s_push('second')   : '%d'\n", test_vector_s_push_back_size("second"));
    printf("cvector_s_push('third')    : '%d'\n", test_vector_s_push_back_size("third"));
    printf("cvector_s_push('fourth')   : '%d'\n", test_vector_s_push_back_size("fourth"));
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));

    printf("cvector_s_front()          : '%s'\n", cvector_s_front(&my_vector_g));
    cvector_s_pop_back(&my_vector_g);
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));

    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_front()          : '%s'\n", cvector_s_front(&my_vector_g));
    printf("cvector_s_push('fourth')   : '%d'\n", test_vector_s_push_back_size("fourth"));
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));

    cvector_s_pop_back(&my_vector_g);
    cvector_s_pop_back(&my_vector_g);
    cvector_s_pop_back(&my_vector_g);
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_front()          : '%s'\n", cvector_s_front(&my_vector_g));
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));
    cvector_s_pop_back(&my_vector_g);
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));

    printf("*** cvector_s: Test erase ***\n");
    printf("cvector_s_push('first')    : '%d'\n", test_vector_s_push_back_size("first"));
    printf("cvector_s_push('second')   : '%d'\n", test_vector_s_push_back_size("second"));
    printf("cvector_s_push('third')    : '%d'\n", test_vector_s_push_back_size("third"));
    printf("cvector_s_push('fourth')   : '%d'\n", test_vector_s_push_back_size("fourth"));
    printf("cvector_s_empty()          : '%d'  cvector_s_full(): '%d'\n", cvector_s_empty(&my_vector_g), cvector_s_full(&my_vector_g));
    printf("cvector_s_size()           : '%zu', back: '%s'\n\n", cvector_s_size(&my_vector_g), cvector_s_back(&my_vector_g));


    test_print_vector_s(&my_vector_g);
    printf("*** cvector_s: Try erasing pos 1 ***\n");
    cvector_s_erase_at(&my_vector_g, 1);
    test_print_vector_s(&my_vector_g);

    printf("*** cvector_s: Try erasing pos 0 ***\n");
    cvector_s_erase_at(&my_vector_g, 0);
    test_print_vector_s(&my_vector_g);

    printf("*** cvector_s: Try inserting 'insert 0' at pos 0 ***\n");
    test_vector_s_insert_size(0, "insert 0");
    test_print_vector_s(&my_vector_g);
    printf("*** cvector_s: Try inserting 'insert 1' at pos 1 ***\n");
    test_vector_s_insert_size(1, "insert 1");
    test_print_vector_s(&my_vector_g);
    printf("*** cvector_s: Try inserting 'insert 2' at pos 2 ***\n");
    test_vector_s_insert_size(2, "insert 2");
    test_print_vector_s(&my_vector_g);
    printf("*** cvector_s: Try inserting 'insert 4' at pos 4 ***\n");
    test_vector_s_insert_size(4, "insert 4");
    test_print_vector_s(&my_vector_g);

    printf("*** cvector_s: Try inserting 'insert 6' at pos 6 ***\n");
    test_vector_s_insert_size(6, "insert 6");
    test_print_vector_s(&my_vector_g);

    printf("*** cvector_s: Try erasing pos 3 ***\n");
    cvector_s_erase_at(&my_vector_g, 3);
    test_print_vector_s(&my_vector_g);

    printf("*** cvector_s: Try erasing pos 0 ***\n");
    cvector_s_erase_at(&my_vector_g, 0);
    test_print_vector_s(&my_vector_g);
    return 0;
}
