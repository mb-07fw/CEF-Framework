# CEFFramework CMakeLists.txt

set (WARNINGS "")

if (MSVC)
    # /W4: Enable high warning level
    # /sdl: Security checks
    # /permissive-: Strict C++ compliance
    set(WARNINGS /W4 /sdl /permissive- /utf-8)

    # Force CMake to define these configurations in the generated solution by default.
    set(CMAKE_CONFIGURATION_TYPES "Debug;Release;Dist" CACHE STRING "" FORCE)
else()
    set(WARNINGS -Wall)
endif()

# Debugging stuff... 
message(STATUS "[Framework - spdlog Expected Directory]: ${CMAKE_SOURCE_DIR}/vendor/spdlog/include")
message(STATUS "[Framework - Warnings]: ${WARNINGS}")

# Glob all .cpp files in src/
file(GLOB SRC_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/src/*.cpp")

# Glob all .hpp files in src/
file(GLOB HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/src/*.hpp")

# Glob all .hpp files in include/
file(GLOB PUBLIC_HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/include/*.hpp")

add_library(CEFFramework SHARED ${SRC_FILES} ${HEADER_FILES} ${PUBLIC_HEADER_FILES})

source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFramework/src" PREFIX "Source Files" FILES ${SRC_FILES})
source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFramework/include" PREFIX "Include Files" FILES ${PUBLIC_HEADER_FILES})

target_include_directories(CEFFramework PUBLIC
    "${CMAKE_SOURCE_DIR}/CEFFramework/include"
    "${CMAKE_SOURCE_DIR}/vendor/spdlog/include"
)

target_link_libraries(CEFFramework PRIVATE spdlog::spdlog)

target_compile_options(CEFFramework PUBLIC ${WARNINGS})

# Always define build macro
target_compile_definitions(CEFFramework PUBLIC CF_BUILD)

# Configuration-specific definitions
target_compile_definitions(CEFFramework PUBLIC
    $<$<CONFIG:Debug>:CF_DEBUG>
    $<$<CONFIG:Release>:CF_NDEBUG>
    $<$<CONFIG:Dist>:CF_NDEBUG;CF_DIST>
)