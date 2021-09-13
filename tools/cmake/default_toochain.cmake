# Set a default toochain for hostpc builds, where we don't
# use an explicit toolchain file.
# See also this about CMAKE_CROSSCOMPILING: https://gitlab.kitware.com/cmake/cmake/-/issues/21744

if ( NOT DEFINED TOOLCHAIN)
    if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set (TOOLCHAIN gcc)
    elseif (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set (TOOLCHAIN msvc)
    endif()
endif() # TOOLCHAIN

