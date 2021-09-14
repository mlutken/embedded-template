set (CMAKE_SYSTEM_NAME      Linux           )
set (CMAKE_SYSTEM_VERSION   5               )
set (CMAKE_CROSSCOMPILING   FALSE           )

set (PLATFORM               staticlinux     ) 
set (PLATFORM_COMPILER      clangtidy       )
set (PLATFORM_TYPE          staticanalysis  )

# Give a hand to first-time Windows users
if(CMAKE_HOST_WIN32)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(FATAL_ERROR "Visual Studio project generator doesn't support compiling to Clang. Please use -G Ninja or other generators instead.")
    endif()
endif()


set(CLANG_TIDY_PREFIX "/usr/bin")

message ("*** FIXMENM CLANG TIDY: '${CLANG_TIDY_PREFIX}'" )


# NOTE: Seems that for most cases we do not need the llvm-ar/llvm-ranlib, but can
#       simply use the normal system ar/ranlib.
set(CMAKE_C_COMPILER    "${CLANG_TIDY_PREFIX}/clang${CLANG_SUFFIX}")
set(CMAKE_CXX_COMPILER  "${CLANG_TIDY_PREFIX}/clang++${CLANG_SUFFIX}")
set(CMAKE_AR            "${CLANG_TIDY_PREFIX}/llvm-ar${CLANG_SUFFIX}" CACHE PATH "Path to Clang ar")
set(CMAKE_RANLIB        "${CLANG_TIDY_PREFIX}/llvm-ranlib${CLANG_SUFFIX}" CACHE PATH "Path to Clang ranlib")

