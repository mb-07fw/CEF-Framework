# CEF-Framework

A simple framework designed to wrap the Chromium Embedded Framework.

## Getting Started

### Prerequisites:
- CMake (Version 3.31 or higher, or Premake5 instead)
- A C++ compiler that supports C++20.
- Must currently run on Windows, as other operating systems are not yet supported.

### Installing:

To install, you **must** clone this project with its submodules:

```bash
git clone --recursive-submodules <this-repository-url>
```
Or if the repository is already cloned:
```bash
git submodule update --init --recursive
```

### Building:

Assuming Premake5 is installed and added to PATH, you can generate a project file
by going to the root directory of the repository where *premake5.lua* is present,
and running:

```bash
premake5 <your-generator-here> (i.e., vs2022, etc)
```

From here you can build the project using your IDE of choice.

Alternatively, if you wish to use *CMake*, you can instead generate a project file
by going to the root directory of the repository where *CMakeLists.txt* is present,
and running:

```bash
cmake -S . -B build -G <your-generator-here> (i.e., "Visual Studio 17 2022")
```

or instead within the build directory:
```bash
cmake ../../ -G <your-generator-here> (i.e., "Visual Studio 17 2022")
```

From there, you can build using your IDE, or by going into the build directory and running:

```bash
cmake --build . --config <configuration>
```

For easier CMake integration with Visual Studio 17 2022, I recommend right clicking on the project's root directory
and clicking *Open with Visual Studio*. This avoids the jank of the generated .sln file not being in the root of the
project.