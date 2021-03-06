/**@file
 * align_macros. Macros for aligning memory
 */
#ifndef SYSTEM_ALIGN_MACROS_H
#define SYSTEM_ALIGN_MACROS_H

#if defined(_MSC_VER)
#define CESL_ALIGNED(x) __declspec(align(x))
#else
#if defined(__GNUC__)
#define CESL_ALIGNED(x) __attribute__ ((aligned(x)))
#endif
#endif

#define CESL_ALIGNED_TYPE(t,x) typedef t CESL_ALIGNED(x)

#endif // SYSTEM_ALIGN_MACROS_H
