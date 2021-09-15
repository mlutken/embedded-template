#include "cvector_s.h"
#include <string.h>
#include <stdint.h>


// -----------------------------
// PRIVATE: Helper functions ---
// -----------------------------

/** Get pointer (inside fifo_buffer) to the index requested */
void* cvector_s_get_ptr_to_index (cvector_s_t* self, size_t index)
{
    return self->buffer_ + (index * self->elem_max_size_);
}

/** Move elements */
void cvector_s_move_elements (cvector_s_t* self, size_t index_from, size_t index_to)
{
    if (index_from == index_to) { return; }
    const size_t size = cvector_s_size(self);
    if (size == 0) { return; }
    size_t positions = size - index_from;

    void* ptr_from  = cvector_s_get_ptr_to_index (self, index_from);
    void* ptr_to    = cvector_s_get_ptr_to_index (self, index_to);
    memmove(ptr_to, ptr_from, positions * self->elem_max_size_);
}

void cvector_s_insert_at(cvector_s_t* self, size_t index, const void* elm_ptr, size_t elem_size)
{
    char* dst_ptr = cvector_s_get_ptr_to_index(self, index);
    memcpy (dst_ptr, elm_ptr, elem_size);
    self->elems_count_ = self->elems_count_ + 1u;
}


// ---------------------
// PUBLIC: functions ---
// ---------------------

int cvector_s_create(cvector_s_t* self, size_t elem_max_size, size_t elems_max_count, void* fifo_buffer)
{
    self->elem_max_size_ = elem_max_size;
    self->elems_max_count_ = elems_max_count;
    self->elems_count_ = 0;
    self->buffer_ = fifo_buffer;
    return 1;
}

void cvector_s_clear(cvector_s_t* self)
{
    self->elems_count_ = 0;
}

int cvector_s_empty (cvector_s_t* self)
{
    return self->elems_count_ == 0u;
}

char*  cvector_s_front (cvector_s_t* self)
{
    return cvector_s_get_ptr_to_index(self, 0u);
}

char* cvector_s_back(cvector_s_t *self)
{
    return cvector_s_get_ptr_to_index(self, self->elems_count_ - 1u);
}

char* cvector_s_at(cvector_s_t *self, size_t index)
{
    if (index < self->elems_count_) {
        return cvector_s_get_ptr_to_index(self, index);
    }
    return NULL;
}

char* cvector_s_get(cvector_s_t *self, size_t index)
{
    return cvector_s_get_ptr_to_index(self, index);
}

int cvector_s_full (cvector_s_t* self)
{
    return self->elems_count_ == self->elems_max_count_;
}

size_t cvector_s_size(cvector_s_t* self)
{
    return self->elems_count_;
}

void cvector_s_erase_at (cvector_s_t* self, size_t index)
{
    const size_t size = cvector_s_size(self);
    if (size == 0 || index >= size) return;

    const size_t last = size - 1;
    if (index == last) {
        cvector_s_pop_back(self);
        return;
    }
    cvector_s_move_elements(self, index + 1, index);
    self->elems_count_ = self->elems_count_ - 1u;
}

int cvector_s_insert(cvector_s_t* self, size_t index, const void* elm_ptr)
{
    if (self->elems_count_ < self->elems_max_count_) {
        cvector_s_move_elements(self, index, index + 1u);
        cvector_s_insert_at(self, index, elm_ptr, self->elem_max_size_);
        return 1;
    }
    return 0;
}

int cvector_s_insert_size(cvector_s_t* self, size_t index, const void* elm_ptr, size_t elem_size)
{
    if (self->elems_count_ < self->elems_max_count_) {
        elem_size = elem_size == 0 ? self->elem_max_size_ : elem_size;
        cvector_s_move_elements(self, index, index + 1u);
        cvector_s_insert_at(self, index, elm_ptr, elem_size);
        return 1;
    }
    return 0;
}

int cvector_s_push_back (cvector_s_t* self, const void* elm_ptr)
{
    if (self->elems_count_ < self->elems_max_count_) {
        cvector_s_insert_at(self, self->elems_count_, elm_ptr, self->elem_max_size_);
        return 1;
    }
    return 0;
}

int cvector_s_push_back_size (cvector_s_t* self, const void* elm_ptr, size_t elem_size)
{
    if (self->elems_count_ < self->elems_max_count_) {
        elem_size = elem_size == 0 ? self->elem_max_size_ : elem_size;
        cvector_s_insert_at(self, self->elems_count_, elm_ptr, elem_size);
        return 1;
    }
    return 0;
}

void cvector_s_pop_back (cvector_s_t* self)
{
    self->elems_count_ = self->elems_count_ - 1u;
}

int cvector_s_append (cvector_s_t* self, cvector_s_t* other)
{
    const size_t other_size = cvector_s_size(other);
    for (size_t i = 0; i < other_size; ++i) {
        const void* src_elem = cvector_s_get(other, i);
        if (!cvector_s_push_back(self, src_elem)) {
            return 0;
        }
    }
    return 1;
}
