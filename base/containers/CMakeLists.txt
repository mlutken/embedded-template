set (library_name containers)

add_library(${library_name} STATIC "")

target_sources(${library_name}
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/cvector_s.h
    PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/cvector_s.c
)

# Get parent directory
get_filename_component(PARENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# Set target properties and compile options, dependencies etc.
target_link_libraries(${library_name} "system;version")
target_include_directories(${library_name} INTERFACE ${PARENT_DIR})
target_compile_options(${library_name} PRIVATE ${STANDARD_C_COMPILE_FLAGS})
## set_target_properties(${library_name} PROPERTIES LINKER_LANGUAGE C)  # USE 'CXX' if compiling C++ files otherwise 'C'; TODO: Do we need to specify LINKER_LANGUAGE ?

add_subdirectories_standard()
