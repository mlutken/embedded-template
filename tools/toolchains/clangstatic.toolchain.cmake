set(CMAKE_SYSTEM_NAME ClangStatic)
set(CMAKE_SYSTEM_VERSION 1)

set(PLATFORM clangstatic) 
set(PLATFORM_TYPE staticanalysis)

# Help CMake find the platform file
#### Already done in main CMakeLists.txt set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../modules ${CMAKE_MODULE_PATH})

# Give a hand to first-time Windows users
if(CMAKE_HOST_WIN32)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(FATAL_ERROR "Visual Studio project generator doesn't support cross-compiling to ClangStatic. Please use -G Ninja or other generators instead.")
    endif()
endif()

# if(NOT CLANGSTATIC_PREFIX)
#     if(DEFINED ENV{CLANGSTATIC})
#         file(TO_CMAKE_PATH "$ENV{CLANGSTATIC}" CLANGSTATIC_PREFIX)
#         # On Homebrew the sysroot is here, however emcc is also available in
#         # /usr/local/bin. It's impossible to figure out the sysroot from there, so
#         # try this first
#     elseif(EXISTS "/opt/user/emsdk/upstream/emscripten")
#         set(CLANGSTATIC_PREFIX "/opt/user/emsdk/upstream/emscripten")
#         # Look for emcc in the path as a last resort
#     elseif(EXISTS "/usr/local/opt/emscripten/libexec/emcc")
#         set(CLANGSTATIC_PREFIX "/usr/local/opt/emscripten/libexec")
#         # Look for emcc in the path as a last resort
#     else()
#         find_file(_CLANGSTATIC_EMCC_EXECUTABLE emcc)
#         if(EXISTS ${_CLANGSTATIC_EMCC_EXECUTABLE})
#             get_filename_component(CLANGSTATIC_PREFIX ${_CLANGSTATIC_EMCC_EXECUTABLE} DIRECTORY)
#         else()
#             set(CLANGSTATIC_PREFIX "/usr/lib/emscripten")
#         endif()
#         mark_as_advanced(_CLANGSTATIC_EMCC_EXECUTABLE)
#     endif()
# endif()


set(CLANGSTATIC_PREFIX "/usr/bin")

set(CLANGSTATIC_TOOLCHAIN_PATH "${CLANGSTATIC_PREFIX}/system")

message ("CLANGSTATIC_PREFIX: '${CLANGSTATIC_PREFIX}'" )


set(CLANGSTATIC_TOOLCHAIN_PATH "${CLANGSTATIC_PREFIX}/system")

if(CMAKE_HOST_WIN32)
    set(EMCC_SUFFIX ".bat")
else()
    set(EMCC_SUFFIX "")
endif()
set(CMAKE_C_COMPILER "${CLANGSTATIC_PREFIX}/clang${EMCC_SUFFIX}")
set(CMAKE_CXX_COMPILER "${CLANGSTATIC_PREFIX}/clang++${EMCC_SUFFIX}")
# The `CACHE PATH "bla"` *has to be* present as otherwise CMake < 3.13.0 would
# for some reason forget the path to `ar`, calling it as `"" qc bla`, failing
# with `/bin/sh: : command not found`. This is probably related to CMP0077 in
# some way but I didn't bother investigating further. It apparently doesn't
# need to be set for the CMAKE_<LANG>_COMPILER_{AR,RANLIB} but playing it safe
# and doing it everywhere.

# set(CMAKE_AR "${CLANGSTATIC_PREFIX}/emar${EMCC_SUFFIX}" CACHE PATH "Path to ClangStatic ar")
# set(CMAKE_RANLIB "${CLANGSTATIC_PREFIX}/emranlib${EMCC_SUFFIX}" CACHE PATH "Path to ClangStatic ranlib")

set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH}
    "${CLANGSTATIC_TOOLCHAIN_PATH}"
    "${CLANGSTATIC_PREFIX}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Otherwise FindCorrade fails to find _CORRADE_MODULE_DIR. Why the heck is this
# not implicit is beyond me.
# set(CMAKE_SYSTEM_PREFIX_PATH ${CMAKE_FIND_ROOT_PATH})

# Compared to the classic (asm.js) compilation, -s WASM=1 is added to both
# compiler and linker. The *_INIT variables are available since CMake 3.7, so
# it won't work in earlier versions. Sorry.
cmake_minimum_required(VERSION 3.7)
# set(CMAKE_CXX_FLAGS_INIT "-s WASM=1")
# set(CMAKE_EXE_LINKER_FLAGS_INIT "-s WASM=1")
# set(CMAKE_CXX_FLAGS_RELEASE_INIT "-DNDEBUG -O3")
# set(CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT "-O3 --llvm-lto 1")

