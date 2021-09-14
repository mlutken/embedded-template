cmake_minimum_required(VERSION 3.7)
project(embedded-template)
enable_testing()

# Add some cmake modules from PRJ_ROOT/tools/cmake directory
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/tools/cmake/")

include (default_vars)
include (default_versions)
include (default_versions)
include (set_standard_compiler_flags)
include (GetGitRevisionDescription)

# --- Project version ---
set ( PROJECT_NAME_VERSION_MAJOR     0   )
set ( PROJECT_NAME_VERSION_MINOR     1   )
set ( PROJECT_NAME_VERSION_PATCH     0   )
set ( PROJECT_NAME_VERSION_STRING    "${PROJECT_NAME_VERSION_MAJOR}.${PROJECT_NAME_VERSION_MINOR}.${PROJECT_NAME_VERSION_PATCH}"    )
set ( VERSION_DIR                    ${CMAKE_CURRENT_LIST_DIR}/version)

# Git refspec, SHA1 and local changes ("CLEAN" or "DIRTY")
# NOTE: Instructions found here: https://www.generacodice.com/en/articolo/108106/How-can-I-pass-git-SHA1-to-compiler-as-definition-using-cmake
get_git_head_revision(GIT_REFSPEC GIT_SHA1)
git_local_changes(GIT_LOCAL_CHANGES)

#  --- C/C++ standard ---
set(CMAKE_CXX_STANDARD          11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD            99)
set(CMAKE_C_STANDARD_REQUIRED   ON)


## Set 3rdparty install dir

## Set some directories
#get_filename_component(PROJECT_ROOT_PARENT_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
#set (PROJECT_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR} )

if ( NOT DEFINED PLATFORM_TYPE)
    set (PLATFORM_TYPE hostpc)  # Default when not using a cross compiling toolchain
endif()
if ( NOT DEFINED PLATFORM)
    if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set (PLATFORM hostlinux)
    elseif (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set (PLATFORM hostwindows)
    endif ()
endif()


add_definitions(
    -D${CMAKE_SYSTEM_NAME}=1
    -D${PLATFORM}=1
    -D${PLATFORM_TYPE}=1
)


message ("CMAKE_SYSTEM_NAME                 : '${CMAKE_SYSTEM_NAME}'")
message ("CMAKE_CROSSCOMPILING              : '${CMAKE_CROSSCOMPILING}'")
message ("CMAKE_SYSTEM_VERSION              : '${CMAKE_SYSTEM_VERSION}'")
message ("PLATFORM                          : '${PLATFORM}'")
message ("PLATFORM_TYPE                     : '${PLATFORM_TYPE}'")
message ("CMAKE_BINARY_DIR                  : '${CMAKE_BINARY_DIR}'")
message ("CMAKE_RUNTIME_OUTPUT_DIRECTORY    : '${CMAKE_RUNTIME_OUTPUT_DIRECTORY}'")
message ("CMAKE_ARCHIVE_OUTPUT_DIRECTORY    : '${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}'")
message ("CMAKE_C_COMPILER                  : '${CMAKE_C_COMPILER}'")
message ("CMAKE_C_COMPILER_ID               : '${CMAKE_C_COMPILER_ID}'")
message ("CMAKE_EXPORT_COMPILE_COMMANDS     : '${CMAKE_EXPORT_COMPILE_COMMANDS}'")
message ("STANDARD_C_COMPILE_FLAGS          : '${STANDARD_C_COMPILE_FLAGS}'")
message ("GIT_REFSPEC                       : '${GIT_REFSPEC}'")
message ("GIT_SHA1                          : '${GIT_SHA1}'")
message ("GIT_LOCAL_CHANGES                 : '${GIT_LOCAL_CHANGES}'")

# --- Include cmake utility files ---
include (${CMAKE_CURRENT_LIST_DIR}/tools/cmake/std_utils.cmake)

# --- Add testing ---
add_subdirectory(testing)


# --- Current user's/developer's 'private' config file ---
set ( USER_CONFIG ${CMAKE_CURRENT_LIST_DIR}/user.buildconfig.cmake )
if ( EXISTS ${USER_CONFIG} )
    include ( ${USER_CONFIG} )
endif()


# --- Add subdirectories ---
add_subdirectory(version)
add_subdirectory(system)
add_subdirectory(base)

