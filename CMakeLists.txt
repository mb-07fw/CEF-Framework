# Root CMakeLists.txt

# To regenerate CMake caches (from root directory)
# cmake -S <root_directory> -B <build_directory> -G "Visual Studio 17 2022"

# Build :
# cmake --build <out_directory> --config <configuration> [optional](--target <name>)

# Clean & Rebuild:
# del /s <out_directory>
# cmake -S . -B <out_directory>
# cmake --build <out_directory>

message(STATUS "[Root - Source Directory]: ${CMAKE_SOURCE_DIR}")
message(STATUS "[Root - Binary Directory]: ${CMAKE_BINARY_DIR}")


cmake_minimum_required(VERSION 3.31)
project (CEFFramework)

# Assumes CMAKE_VERSION VERSION_GREATER 3.12
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT CEFFrameworkExample)

# Tell CMake to reflect the actual folder structure of the specified files
#   in the Visual Studio Solution Explorer.
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR}FILES ${HEADERS} ${SOURCES})

add_subdirectory("vendor/spdlog")
add_subdirectory("CEFFramework")
add_subdirectory("CEFFrameworkExample")