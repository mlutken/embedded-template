set (CMAKE_SYSTEM_NAME      Linux           )
set (CMAKE_SYSTEM_VERSION   5               )
set (CMAKE_CROSSCOMPILING   FALSE           )

set (PLATFORM               staticanalysis  ) 
set (PLATFORM_COMPILER      clangtidy       )
set (PLATFORM_TYPE          analysis        )

# Give a hand to first-time Windows users
if(CMAKE_HOST_WIN32)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(FATAL_ERROR "Visual Studio project generator doesn't support compiling to Clang. Please use -G Ninja or other generators instead.")
    endif()
endif()


set(CLANG_PREFIX "/usr/bin")
set(CLANG_TIDY_PREFIX "/usr/bin")

message ("*** FIXMENM CLANG TIDY: '${CLANG_PREFIX}'" )


# NOTE: Seems that for most cases we do not need the llvm-ar/llvm-ranlib, but can
#       simply use the normal system ar/ranlib.
set(CMAKE_C_COMPILER    "${CLANG_PREFIX}/clang${CLANG_SUFFIX}")
set(CMAKE_CXX_COMPILER  "${CLANG_PREFIX}/clang++${CLANG_SUFFIX}")
set(CMAKE_AR            "${CLANG_PREFIX}/llvm-ar${CLANG_SUFFIX}" CACHE PATH "Path to Clang ar")
set(CMAKE_RANLIB        "${CLANG_PREFIX}/llvm-ranlib${CLANG_SUFFIX}" CACHE PATH "Path to Clang ranlib")


# https://clang.llvm.org/extra/clang-tidy/index.html
# https://hg.mozilla.org/mozilla-central/file/tip/tools/clang-tidy/config.yaml
# clang-tidy-12 -list-checks
# run-clang-tidy-12.py -checks *,clang-analyzer-* /home/ml/code/embedded-template/base/containers/cvector_s.c
# run-clang-tidy-12.py -p /home/ml/code/_build/embedded-template/hostlinux.gcc -checks *,clang-analyzer-* base/containers/cvector_s.c
# run-clang-tidy-12.py -p /home/ml/code/_build/embedded-template/hostlinux.gcc -checks *,clang-analyzer-* base/containers/cvector_s.c 
