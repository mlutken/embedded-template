#include "cesl_vector_s.h"
#include <string.h>
#include <stdint.h>


// -----------------------------
// PRIVATE: Helper functions ---
// -----------------------------

/** Get pointer (inside fifo_buffer) to the index requested */
void* cesl_vector_s_get_ptr_to_index (cesl_vector_s_t* self, size_t index)
{
    return self->buffer_ + (index * self->elem_max_size_);
}

/** Move elements */
void cesl_vector_s_move_elements (cesl_vector_s_t* self, size_t index_from, size_t index_to)
{
    if (index_from == index_to) return;
    const size_t size = cesl_vector_s_size(self);
    if (size == 0) return;
    size_t positions = size - index_from;

    void* ptr_from  = cesl_vector_s_get_ptr_to_index (self, index_from);
    void* ptr_to    = cesl_vector_s_get_ptr_to_index (self, index_to);
    memmove(ptr_to, ptr_from, positions * self->elem_max_size_);
}

void cesl_vector_s_insert_at(cesl_vector_s_t* self, size_t index, const void* elm_ptr, size_t elem_size)
{
    char* dst_ptr = cesl_vector_s_get_ptr_to_index(self, index);
    memcpy (dst_ptr, elm_ptr, elem_size);
    self->elems_count_ = self->elems_count_ + 1u;
}


// ---------------------
// PUBLIC: functions ---
// ---------------------

int cesl_vector_s_create(cesl_vector_s_t* self, size_t elem_max_size, size_t elems_max_count, void* fifo_buffer)
{
    self->elem_max_size_ = elem_max_size;
    self->elems_max_count_ = elems_max_count;
    self->elems_count_ = 0;
    self->buffer_ = fifo_buffer;
    return 1;
}

void cesl_vector_s_clear(cesl_vector_s_t* self)
{
    self->elems_count_ = 0;
}

int cesl_vector_s_empty (cesl_vector_s_t* self)
{
    return self->elems_count_ == 0u;
}

char*  cesl_vector_s_front (cesl_vector_s_t* self)
{
    return cesl_vector_s_get_ptr_to_index(self, 0u);
}

char* cesl_vector_s_back(cesl_vector_s_t *self)
{
    return cesl_vector_s_get_ptr_to_index(self, self->elems_count_ - 1u);
}

char* cesl_vector_s_at(cesl_vector_s_t *self, size_t index)
{
    if (index < self->elems_count_) {
        return cesl_vector_s_get_ptr_to_index(self, index);
    }
    return NULL;
}

char* cesl_vector_s_get(cesl_vector_s_t *self, size_t index)
{
    return cesl_vector_s_get_ptr_to_index(self, index);
}

int cesl_vector_s_full (cesl_vector_s_t* self)
{
    return self->elems_count_ == self->elems_max_count_;
}

size_t cesl_vector_s_size(cesl_vector_s_t* self)
{
    return self->elems_count_;
}

void cesl_vector_s_erase_at (cesl_vector_s_t* self, size_t index)
{
    const size_t size = cesl_vector_s_size(self);
    if (size == 0 || index >= size) return;

    const size_t last = size - 1;
    if (index == last) {
        cesl_vector_s_pop_back(self);
        return;
    }
    cesl_vector_s_move_elements(self, index + 1, index);
    self->elems_count_ = self->elems_count_ - 1u;
}

int cesl_vector_s_insert(cesl_vector_s_t* self, size_t index, const void* elm_ptr)
{
    if (self->elems_count_ < self->elems_max_count_) {
        cesl_vector_s_move_elements(self, index, index + 1u);
        cesl_vector_s_insert_at(self, index, elm_ptr, self->elem_max_size_);
        return 1;
    }
    return 0;
}

int cesl_vector_s_insert_size(cesl_vector_s_t* self, size_t index, const void* elm_ptr, size_t elem_size)
{
    if (self->elems_count_ < self->elems_max_count_) {
        elem_size = elem_size == 0 ? self->elem_max_size_ : elem_size;
        cesl_vector_s_move_elements(self, index, index + 1u);
        cesl_vector_s_insert_at(self, index, elm_ptr, elem_size);
        return 1;
    }
    return 0;
}

int cesl_vector_s_push_back (cesl_vector_s_t* self, const void* elm_ptr)
{
    if (self->elems_count_ < self->elems_max_count_) {
        cesl_vector_s_insert_at(self, self->elems_count_, elm_ptr, self->elem_max_size_);
        return 1;
    }
    return 0;
}

int cesl_vector_s_push_back_size (cesl_vector_s_t* self, const void* elm_ptr, size_t elem_size)
{
    if (self->elems_count_ < self->elems_max_count_) {
        elem_size = elem_size == 0 ? self->elem_max_size_ : elem_size;
        cesl_vector_s_insert_at(self, self->elems_count_, elm_ptr, elem_size);
        return 1;
    }
    return 0;
}

void cesl_vector_s_pop_back (cesl_vector_s_t* self)
{
    self->elems_count_ = self->elems_count_ - 1u;
}

int cesl_vector_s_append (cesl_vector_s_t* self, cesl_vector_s_t* other)
{
    const size_t other_size = cesl_vector_s_size(other);
    for (size_t i = 0; i < other_size; ++i) {
        const void* src_elem = cesl_vector_s_get(other, i);
        if (!cesl_vector_s_push_back(self, src_elem)) {
            return 0;
        }
    }
    return 1;
}
