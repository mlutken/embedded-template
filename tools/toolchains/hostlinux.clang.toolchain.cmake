set (CMAKE_SYSTEM_NAME      Linux   )
set (CMAKE_SYSTEM_VERSION   5       )
set (CMAKE_CROSSCOMPILING   FALSE   )

set (PLATFORM               hostlinux   )
set (PLATFORM_COMPILER      clang       )
set (PLATFORM_TYPE          hostpc      )

# Give a hand to first-time Windows users
if(CMAKE_HOST_WIN32)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(FATAL_ERROR "Visual Studio project generator doesn't support compiling to Clang. Please use -G Ninja or other generators instead.")
    endif()
endif()


set(HOSTLINUX_CLANG_PREFIX "/usr/bin")

message ("*** FIXMENM HOSTLINUX_CLANG_PREFIX: '${HOSTLINUX_CLANG_PREFIX}'" )


# NOTE: Seems that for most cases we do not need the llvm-ar/llvm-ranlib, but can
#       simply use the normal system ar/ranlib.
set(CMAKE_C_COMPILER    "${HOSTLINUX_CLANG_PREFIX}/clang${CLANG_SUFFIX}")
set(CMAKE_CXX_COMPILER  "${HOSTLINUX_CLANG_PREFIX}/clang++${CLANG_SUFFIX}")
set(CMAKE_AR            "${HOSTLINUX_CLANG_PREFIX}/llvm-ar${CLANG_SUFFIX}" CACHE PATH "Path to Clang ar")
set(CMAKE_RANLIB        "${HOSTLINUX_CLANG_PREFIX}/llvm-ranlib${CLANG_SUFFIX}" CACHE PATH "Path to Clang ranlib")

#set(HOSTLINUX_CLANG_TOOLCHAIN_PATH "${HOSTLINUX_CLANG_PREFIX}/system")
#set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH}
    #"${HOSTLINUX_CLANG_TOOLCHAIN_PATH}"
    #"${HOSTLINUX_CLANG_PREFIX}")
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

