newaction {
    trigger     = "clean",
    description = "Clean the build and intermediate files",
    execute     = function ()
        os.rmdir("bin")
        os.rmdir("build")
        os.rmdir(".vs")
        os.rmdir("vendor/spdlog/build")

        os.remove("*.sln")
        os.remove("*.vcxproj")
        os.remove("*.vcxproj.filters")
        os.remove("*.vcxproj.user")
        print("Clean complete.")
    end
}

workspace "CEFFramework"
    configurations { "Debug", "Release", "Dist" }
    startproject "CEFFrameworkExample"
    architecture "x64"

    project "CEFFrameworkExample"
        kind "ConsoleApp"
        staticruntime "Off"
        language "C++"
        cppdialect "C++20"

        targetname "CEFFrameworkExample"
        targetdir "build/%{cfg.buildcfg}/out/CEFFrameworkExample"
        objdir "build/%{cfg.buildcfg}/int/CEFFrameworkExample"

        includedirs { "CEFFramework/include" }
        files { "CEFFrameworkExample/include/**.hpp",
                "CEFFrameworkExample/src/**.hpp", 
                "CEFFrameworkExample/src/**.cpp" 
            }
        
        dependson { "CEFFramework" }
        links { "CEFFramework" }

    project "CEFFramework"
        kind "SharedLib"
        staticruntime "Off"
        language "C++"
        cppdialect "C++20"

        targetname "CEFFramework"  -- <-- This is the output name (no config suffix)
        targetdir "build/%{cfg.buildcfg}/out/CEFFramework"
        objdir "build/%{cfg.buildcfg}/int/CEFFramework"

        includedirs { "CEFFramework/include" }
        files { "CEFFramework/include/**.hpp",
                "CEFFramework/src/**.hpp", 
                "CEFFramework/src/**.cpp" 
            }

        -- Common to all configurations
        filter { "system:windows" }
            defines { "CEF_FRAMEWORK_BUILD" }

        filter "configurations:Debug"
            defines { "CEF_FRAMEWORK_DEBUG", "CEF_FRAMEWORK_BUILD" }
            libdirs { "vendor/spdlog/build/Debug" }
            links {"spdlogd"}
            symbols "On"

        filter "configurations:Release"
            defines { "CEF_FRAMEWORK_NDEBUG", "CEF_FRAMEWORK_BUILD" }
            libdirs { "vendor/spdlog/build/Release" }
            links {"spdlog"}
            optimize "On"

        filter "configurations:Dist"
            defines { "CEF_FRAMEWORK_NDEBUG", "CEF_FRAMEWORK_DIST", "CEF_FRAMEWORK_BUILD" }
            libdirs { "vendor/spdlog/build/Release" }
            links {"spdlog"}
            optimize "On"

        filter {}

        dependson { "spdlog"}

    project "spdlog"
        kind "StaticLib"
        staticruntime "Off"
        language "C++"
        cppdialect "C++20"

        -- Tell Premake to run CMake for spdlog before building the project
        filter "system:windows"
            prebuildcommands {
                "cd vendor\\spdlog",
                "rmdir /s /q build",
                "mkdir build",
                "cd build",
                "cmake ..",
                "cmake --build ."
            }

        filter "system:linux or system:macosx"
            prebuildcommands {
                "cd vendor/spdlog && rm -rf build && mkdir -p build && cd build && cmake .. && cmake --build ."
            }

        filter {}

        links { "spdlog" }

        -- Include headers
        includedirs { "vendor/spdlog/include" }

        -- Optionally, exclude files since spdlog is built separately
        files { } -- no source files here, built by CMake

        -- Where to put IDE artifacts
        objdir "vendor/spdlog/ide-obj/%{cfg.buildcfg}"