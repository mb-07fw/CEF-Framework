# CEF-Framework

A framework designed to wrap the Chromium Embedded Framework.

## Getting Started

### Installing:

To install, you **must** clone the project with it's submodules:

```bash
git clone --recursive-submodules <repository-url>
```
Or if the repository is already cloned:
```bash
git submodule update --init --recursive
```

### Building:

Assuming Premake5 is installed and added to PATH, You can generate a project file
by going to the root directory of the repository where *premake5.lua* is present,
and running:

```bash
premake5 <your-generator-here> (i.e., vs2022, etc)
```

From here you can build the project using your IDE of choice.

Alternatively, if you wish to use *CMake*, you can instead generate a project file
by going to the root directory of the repository where *CMakeLists.txt* is present,
and run:

```bash
cmake -S . -B build/CMake -G "<your-generator-here> (i.e., Visual Studio 17 2022)"
```

or instead in build/CMake directory:
```bash
cmake ../../ -G "<your-generator-here> (i.e., Visual Studio 17 2022)"
```

From there, you can build using your IDE, or by going into build/CMake (where CMake was
targeted) and running:

```bash
cmake --build . --config <configuration>
```