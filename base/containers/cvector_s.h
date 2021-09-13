#ifndef CONTAINERS_CVECTOR_S_H
#define CONTAINERS_CVECTOR_S_H

#include <system/extern_c.h>
#include <stddef.h>

/**@file
 * cvector_s: STL like vector with a max size defined at
 * creation time of the vector. Statically allocated.
*/

// -----------------
// PUBLIC: types ---
// -----------------

typedef struct {
    char*                           buffer_;
    size_t                          elem_max_size_;
    size_t                          elems_max_count_;
    size_t                          elems_count_;
} cvector_s_t;

// ---------------------
// PUBLIC: functions ---
// ---------------------

extern_C int    cvector_s_create            (cvector_s_t* self, size_t elem_max_size,
                                                 size_t elems_max_count, void* fifo_buffer);
extern_C void   cvector_s_clear             (cvector_s_t* self);
extern_C int    cvector_s_empty             (cvector_s_t* self);
extern_C char*  cvector_s_front             (cvector_s_t* self);
extern_C char*  cvector_s_back              (cvector_s_t* self);
extern_C char*  cvector_s_at                (cvector_s_t* self, size_t index);
extern_C char*  cvector_s_get               (cvector_s_t *self, size_t index);
extern_C int    cvector_s_full              (cvector_s_t* self);
extern_C size_t cvector_s_size              (cvector_s_t* self);
extern_C int    cvector_s_insert            (cvector_s_t* self, size_t index, const void* elm_ptr);
extern_C void   cvector_s_erase_at          (cvector_s_t* self, size_t index);
extern_C int    cvector_s_insert_size       (cvector_s_t* self, size_t index, const void* elm_ptr, size_t elem_size);
//extern_C int    cvector_s_insert_range      (cvector_s_t* self, size_t index, void char* elm_ptr, size_t count);
extern_C int    cvector_s_push_back         (cvector_s_t* self, const void* elm_ptr);
extern_C int    cvector_s_push_back_size    (cvector_s_t* self, const void* elm_ptr, size_t elem_size);
extern_C void   cvector_s_pop_back          (cvector_s_t* self);
extern_C int    cvector_s_append            (cvector_s_t* self, cvector_s_t* other);

#endif //CONTAINERS_CVECTOR_S_H
