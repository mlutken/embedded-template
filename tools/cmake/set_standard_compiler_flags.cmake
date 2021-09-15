# File to detect compiler and from this set standard and common compile flags.
# STANDARD_C/CXX_COMPILE_FLAGS: Are intended to be used in most cases
# COMMON_C/CXXCOMPILE_FLAGS   : Minimun needed flags. Used for example for 3rdparty libraties that
#                               can't compile without warnings using the standard compile flags

# See list of compile IDs here: https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html#variable:CMAKE_%3CLANG%3E_COMPILER_ID


if ( (${CMAKE_C_COMPILER_ID} MATCHES "GNU") OR (${CMAKE_C_COMPILER_ID} MATCHES "Clang") )

    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("**********************")
    message ("***************** ${SYSTEM_SPECIFIC_FLAGS} *****")
    message ("**********************")
    set (SYSTEM_SPECIFIC_FLAGS "")
    if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set (SYSTEM_SPECIFIC_FLAGS ";-fPIC")
    endif()
    message ("***************** ${SYSTEM_SPECIFIC_FLAGS} *****")
    message ("***************** ${SYSTEM_SPECIFIC_FLAGS} *****")
    message ("***************** ${SYSTEM_SPECIFIC_FLAGS} *****")


    set (COMMON_C_COMPILE_FLAGS "${SYSTEM_SPECIFIC_FLAGS}")
    set (COMMON_CXX_COMPILE_FLAGS "${SYSTEM_SPECIFIC_FLAGS}")
    set (STANDARD_C_COMPILE_FLAGS "-Wall;-Wextra;-Wsign-conversion;-Werror${SYSTEM_SPECIFIC_FLAGS}")
    set (STANDARD_CXX_COMPILE_FLAGS "-Wall;-Wextra;-Wsign-conversion;-Wno-zero-as-null-pointer-constant;-Werror${SYSTEM_SPECIFIC_FLAGS}")

#elseif (${CMAKE_C_COMPILER_ID} MATCHES "MSVC")
#elseif (${CMAKE_C_COMPILER_ID} MATCHES "ARMCC")
#elseif (${CMAKE_C_COMPILER_ID} MATCHES "ARMClang")
#elseif (${CMAKE_C_COMPILER_ID} MATCHES "Synopsys???")
else()
    message ( FATAL_ERROR "You must specify STANDARD_COMPILE_FLAGS, COMMON_COMPILE_FLAGS for CMAKE_C_COMPILER_ID: '${CMAKE_C_COMPILER_ID}'")
endif ()

