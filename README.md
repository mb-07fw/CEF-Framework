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