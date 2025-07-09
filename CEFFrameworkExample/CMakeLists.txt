# CEFFrameworkExample CMakeLists.txt

# Glob all .cpp files in src/
file(GLOB SRC_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src/*.cpp")

# Glob all .hpp files in src/
file(GLOB HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src/*.hpp")

# Glob all .hpp files in include/
file(GLOB PUBLIC_HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include/*.hpp")

add_executable(CEFFrameworkExample ${SRC_FILES} ${HEADER_FILES} ${PUBLIC_HEADER_FILES})

target_compile_options(CEFFrameworkExample PRIVATE ${WARNINGS})

source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src" PREFIX "Source Files" FILES ${SRC_FILES})
source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include" PREFIX "Include Files" FILES ${PUBLIC_HEADER_FILES})

target_include_directories(CEFFrameworkExample 
    PRIVATE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/include"
    PRIVATE "${CMAKE_SOURCE_DIR}/CEFFrameworkExample/src"
)

target_link_libraries(CEFFrameworkExample PRIVATE CEFFramework)

# Post build command to copy Framework .dll into Example directory.
add_custom_command(
    TARGET CEFFrameworkExample POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_BINARY_DIR}/CEFFramework/CEFFramework.dll"
        "${CMAKE_BINARY_DIR}/CEFFrameworkExample"
)