/**@file
 * Extern C macro.
 */
#ifndef SYSTEM_EXTERN_C_H
#define SYSTEM_EXTERN_C_H

#ifndef extern_C
#   ifdef __cplusplus
#       define extern_C extern "C"
#   else
#       define extern_C extern
#   endif
#endif

#endif // SYSTEM_EXTERN_C_H
