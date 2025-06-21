# CEFFrameworkExample CMakeLists.txt

# Glob all .cpp files in src/
file(GLOB SRC_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src/*.cpp")

# Glob all .hpp files in src/
file(GLOB HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src/*.hpp")

# Glob all .hpp files in include/
file(GLOB PUBLIC_HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include/*.hpp")

add_executable(CEFFrameworkExample ${SRC_FILES} ${HEADER_FILES} ${PUBLIC_HEADER_FILES})

set (WARNINGS "")

if (MSVC)
    # /W4: Enable high warning level
    # /sdl: Security checks
    # /permissive-: Strict C++ compliance
    set(COMMON_WARNINGS /W4 /sdl /permissive-)
else()
    set(COMMON_WARNINGS -Wall)
endif()

target_compile_options(CEFFrameworkExample PRIVATE ${WARNINGS})

source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src" PREFIX "Source Files" FILES ${SRC_FILES})
source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include" PREFIX "Include Files" FILES ${PUBLIC_HEADER_FILES})

target_include_directories(CEFFrameworkExample PRIVATE 
    "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include"
    "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src"
    "${CMAKE_SOURCE_DIR}/CEFFramework/include"
)
target_link_libraries(CEFFrameworkExample PRIVATE CEFFramework)