set(CMAKE_SYSTEM_NAME HostLinuxClang)
set(CMAKE_SYSTEM_VERSION 1)
set(PLATFORM_TYPE hostpc)

if(CMAKE_HOST_WIN32)
    set(PLATFORM hostwindowsclang)
    set(CLANG_SUFFIX ".exe")
else()
    set(PLATFORM hostlinuxclang)
    set(CLANG_SUFFIX "")
endif()


# Help CMake find the platform file
#### Already done in main CMakeLists.txt set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../modules ${CMAKE_MODULE_PATH})

# Give a hand to first-time Windows users
if(CMAKE_HOST_WIN32)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(FATAL_ERROR "Visual Studio project generator doesn't support cross-compiling to ClangStatic. Please use -G Ninja or other generators instead.")
    endif()
endif()


set(HOSTLINUXCLANG_PREFIX "/usr/bin")

set(HOSTLINUXCLANG_TOOLCHAIN_PATH "${HOSTLINUXCLANG_PREFIX}/system")

message ("HOSTLINUXCLANG_PREFIX: '${HOSTLINUXCLANG_PREFIX}'" )


set(HOSTLINUXCLANG_TOOLCHAIN_PATH "${HOSTLINUXCLANG_PREFIX}/system")

set(CMAKE_C_COMPILER "${HOSTLINUXCLANG_PREFIX}/clang${CLANG_SUFFIX}")
set(CMAKE_CXX_COMPILER "${HOSTLINUXCLANG_PREFIX}/clang++${CLANG_SUFFIX}")
# The `CACHE PATH "bla"` *has to be* present as otherwise CMake < 3.13.0 would
# for some reason forget the path to `ar`, calling it as `"" qc bla`, failing
# with `/bin/sh: : command not found`. This is probably related to CMP0077 in
# some way but I didn't bother investigating further. It apparently doesn't
# need to be set for the CMAKE_<LANG>_COMPILER_{AR,RANLIB} but playing it safe
# and doing it everywhere.

# set(CMAKE_AR "${HOSTLINUXCLANG_PREFIX}/emar${CLANG_SUFFIX}" CACHE PATH "Path to ClangStatic ar")
# set(CMAKE_RANLIB "${HOSTLINUXCLANG_PREFIX}/emranlib${CLANG_SUFFIX}" CACHE PATH "Path to ClangStatic ranlib")

set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH}
    "${HOSTLINUXCLANG_TOOLCHAIN_PATH}"
    "${HOSTLINUXCLANG_PREFIX}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

