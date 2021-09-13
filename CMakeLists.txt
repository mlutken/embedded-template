cmake_minimum_required(VERSION 3.5)
project(embedded-template)
enable_testing()


include (${CMAKE_CURRENT_LIST_DIR}/tools/cmake/default_vars.cmake)
include (${CMAKE_CURRENT_LIST_DIR}/tools/cmake/default_versions.cmake)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/tools/cmake)

# # --- Project version ---
# set ( PROJECT_NAME_VERSION_MAJOR     0   )
# set ( PROJECT_NAME_VERSION_MINOR     1   )
# set ( PROJECT_NAME_VERSION_PATCH     0   )
# set ( PROJECT_NAME_VERSION_STRING    "${PROJECT_NAME_VERSION_MAJOR}.${PROJECT_NAME_VERSION_MINOR}.${PROJECT_NAME_VERSION_PATCH}"    )
# set ( VERSION_DIR                    ${CMAKE_CURRENT_LIST_DIR}/version)


# # --- C/C++ standard ---
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_C_STANDARD 99)
# set(CMAKE_C_STANDARD_REQUIRED ON)


## Set 3rdparty install dir

## Set some directories
#get_filename_component(PROJECT_ROOT_PARENT_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
#set (PROJECT_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR} )

if ( NOT DEFINED PLATFORM_TYPE)
    set (PLATFORM_TYPE hostpc)  # Default when not using a cross compiling toolchain
endif()
if ( NOT DEFINED PLATFORM)
    message ("DDDDDDDDDDDDDDDDDDDDDDDD")
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


set (COMMON_COMPILE_FLAGS "-fPIC")
set (STANDARD_COMPILE_FLAGS "-Wall;-Wextra;-Wsign-conversion;-Wno-zero-as-null-pointer-constant;-Werror;-fPIC")


message ("CMAKE_SYSTEM_NAME                 : '${CMAKE_SYSTEM_NAME}'")
message ("PLATFORM                          : '${PLATFORM}'")
message ("PLATFORM_TYPE                     : '${PLATFORM_TYPE}'")
message ("CMAKE_BINARY_DIR                  : '${CMAKE_BINARY_DIR}'")
message ("CMAKE_RUNTIME_OUTPUT_DIRECTORY    : '${CMAKE_RUNTIME_OUTPUT_DIRECTORY}'")
message ("CMAKE_ARCHIVE_OUTPUT_DIRECTORY    : '${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}'")

# --- Include cmake utility files ---
include (${CMAKE_CURRENT_LIST_DIR}/tools/cmake/std_utils.cmake)

# --- Add testing before setting general compiler flags ---
add_subdirectory(testing)

#
# # --- Current user's/developer's 'private' config file ---
# set ( USER_CONFIG ${CMAKE_CURRENT_SOURCE_DIR}/user.buildconfig.cmake )
# if ( EXISTS ${USER_CONFIG} )
#     INCLUDE ( ${USER_CONFIG} )
# endif()


# --- Add subdirectories ---
add_subdirectory(system)
add_subdirectory(base)

