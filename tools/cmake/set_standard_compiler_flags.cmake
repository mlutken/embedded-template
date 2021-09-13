# File to detect compiler and from this set standard and common compile flags.
# STANDARD_COMPILE_FLAGS: Are intended to be used in most cases
# COMMON_COMPILE_FLAGS  : Minimun needed flags. Used for example for 3rdparty libraties that
#                         can't compile without warnings using the standard compile flags

# See list of compile IDs here: https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html#variable:CMAKE_%3CLANG%3E_COMPILER_ID


if ( (${CMAKE_CXX_COMPILER_ID} MATCHES "GNU") OR (${CMAKE_CXX_COMPILER_ID} MATCHES "Clang") )
    set (COMMON_COMPILE_FLAGS "-fPIC")
    set (STANDARD_COMPILE_FLAGS "-Wall;-Wextra;-Wsign-conversion;-Wno-zero-as-null-pointer-constant;-Werror;-fPIC")
#elseif (${CMAKE_CXX_COMPILER_ID} MATCHES "MSVC")
#elseif (${CMAKE_CXX_COMPILER_ID} MATCHES "ARMCC")
#elseif (${CMAKE_CXX_COMPILER_ID} MATCHES "ARMClang")
#elseif (${CMAKE_CXX_COMPILER_ID} MATCHES "Synopsys???")
else()
    message ( FATAL_ERROR "You must specify STANDARD_COMPILE_FLAGS, COMMON_COMPILE_FLAGS for CMAKE_CXX_COMPILER_ID: '${CMAKE_CXX_COMPILER_ID}'")
endif ()

