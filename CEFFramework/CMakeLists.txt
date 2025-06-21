# CEFFramework CMakeLists.txt

# Glob all .cpp files in src/
file(GLOB SRC_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/src/*.cpp")

# Glob all .hpp files in src/
file(GLOB HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/src/*.hpp")

# Glob all .hpp files in include/
file(GLOB PUBLIC_HEADER_FILES "${CMAKE_SOURCE_DIR}/CEFFramework/include/*.hpp")

add_library(CEFFramework SHARED ${SRC_FILES} ${HEADER_FILES} ${PUBLIC_HEADER_FILES})

source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFramework/src" PREFIX "Source Files" FILES ${SRC_FILES})
source_group(TREE "${CMAKE_SOURCE_DIR}/CEFFramework/include" PREFIX "Include Files" FILES ${PUBLIC_HEADER_FILES})

target_include_directories(CEFFramework PRIVATE "${CMAKE_SOURCE_DIR}/CEFFramework/include")

target_link_directories(CEFFramework PRIVATE
    $<$<CONFIG:Debug>:${CMAKE_SOURCE_DIR}/build/CMake/vendor/spdlog/Debug>
    $<$<CONFIG:Release>:${CMAKE_SOURCE_DIR}/build/CMake/vendor/spdlog/build/Release>
    $<$<CONFIG:Dist>:${CMAKE_SOURCE_DIR}/build/CMake/vendor/spdlog/build/Release>
)

# If debug, should be "spdlogd"
target_link_libraries(CEFFramework PRIVATE
    $<$<CONFIG:Debug>:spdlogd>
    $<$<CONFIG:Release>:spdlog>
    $<$<CONFIG:Dist>:spdlog>
)

set (WARNINGS "")

if (MSVC)
    # /W4: Enable high warning level
    # /sdl: Security checks
    # /permissive-: Strict C++ compliance
    set(COMMON_WARNINGS /W4 /sdl /permissive-)
else()
    set(COMMON_WARNINGS -Wall)
endif()

target_compile_options(CEFFramework PRIVATE ${WARNINGS})

# Always define build macro
target_compile_definitions(CEFFramework PRIVATE CEF_FRAMEWORK_BUILD)

# Configuration-specific definitions
target_compile_definitions(CEFFramework PRIVATE
    $<$<CONFIG:Debug>:CEF_FRAMEWORK_DEBUG>
    $<$<CONFIG:Release>:CEF_FRAMEWORK_NDEBUG>
    $<$<CONFIG:Dist>:CEF_FRAMEWORK_NDEBUG;CEF_FRAMEWORK_DIST>
)