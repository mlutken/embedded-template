set (library_name version)

add_library(${library_name} STATIC "")

configure_file (${CMAKE_CURRENT_LIST_DIR}/version_info.c.in ${CMAKE_CURRENT_BINARY_DIR}/version_info.c )
configure_file (${CMAKE_CURRENT_LIST_DIR}/git_info.c.in ${CMAKE_CURRENT_BINARY_DIR}/git_info.c )

target_sources(${library_name}
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/git_info.h
    ${CMAKE_CURRENT_LIST_DIR}/version_info.h
    PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/git_info.c
    ${CMAKE_CURRENT_BINARY_DIR}/version_info.c
)

# Get parent directory
get_filename_component(PARENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# Set target properties and compile options, dependencies etc.
target_include_directories(${library_name} PUBLIC ${PARENT_DIR})
target_compile_options(${library_name} PRIVATE ${STANDARD_C_COMPILE_FLAGS})

add_subdirectories_standard()
