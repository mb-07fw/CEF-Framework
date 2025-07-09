-- TODO: Figure out how to put .vcxproj files in their respective directories.

newaction {
    trigger     = "clean",
    description = "Clean the build and intermediate files",
    execute     = function ()
        os.rmdir("out/build")
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

    filter { "toolset:msc*" } -- Matches MSVC compilers
        buildoptions { "/W4", "/sdl", "/permissive-", "/utf-8" }

    filter { "toolset:gcc" }
        buildoptions { "-Wall" } -- Idk if this is equivalent but whatever.

    -- TODO: Implement other stuff later...

    filter {}

    local build_dir = "out/build/%{cfg.buildcfg}/"

    project "CEFFrameworkExample"
        kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"

        local output_dir = build_dir .. "out/CEFFrameworkExample"
        local obj_dir = build_dir .. "int/CEFFrameworkExample"

        targetname "CEFFrameworkExample"

        targetdir (output_dir)
        objdir (obj_dir)

        includedirs { "CEFFramework/include", "vendor/spdlog/include" }

        files { "CEFFrameworkExample/include/**.hpp",
                "CEFFrameworkExample/src/**.hpp", 
                "CEFFrameworkExample/src/**.cpp" 
            }
        
        dependson { "CEFFramework" }
        links { "CEFFramework" }

         -- Copy the DLL after building the target
        postbuildcommands {
            "echo Copying CEFFramework.dll into CEFFrameworkExample output directory.",
            "{COPY} " .. build_dir .. "out/CEFFramework/CEFFramework.dll %{cfg.targetdir}"
        }

    project "CEFFramework"
        kind "SharedLib"
        language "C++"
        cppdialect "C++20"

        targetname "CEFFramework"  -- <-- This is the output name (no config suffix)

        targetdir (build_dir .. "out/CEFFramework")
        objdir (build_dir .. "int/CEFFramework")

        includedirs { "CEFFramework/include", "vendor/spdlog/include" }

        files { "CEFFramework/include/**.hpp",
                "CEFFramework/src/**.hpp", 
                "CEFFramework/src/**.cpp"
            }

        -- Common to all configurations
        filter { "system:windows" }
            defines { "CF_BUILD" }

        filter "configurations:Debug"
            defines { "CF_DEBUG", "CF_BUILD" }
            libdirs { "vendor/spdlog/build/Debug" }
            links {"spdlogd"}
            symbols "On"

        filter "configurations:Release"
            defines { "CF_NDEBUG", "CF_BUILD" }
            libdirs { "vendor/spdlog/build/Release" }
            links {"spdlog"}
            optimize "On"

        filter "configurations:Dist"
            defines { "CF_NDEBUG", "CF_DIST", "CF_BUILD" }
            libdirs { "vendor/spdlog/build/Release" }
            links {"spdlog"}

            optimize "On"

        filter {}

        dependson { "spdlog"}

    project "spdlog"
        kind "StaticLib"
        language "C++"
        cppdialect "C++20"

        -- Tell Premake to run CMake for spdlog before building the project
        prebuildcommands {
            "echo Invoking spdlog's CMake build system.",
            'cd vendor\\spdlog && cmake -S . -B build -G "Visual Studio 17 2022" && cmake --build build'
        }

        links { "spdlog" }

        -- Include headers
        includedirs { "vendor/spdlog/include" }

        files {} -- no source files here, built by CMake

        -- Where to put IDE artifacts...
        targetdir "vendor/spdlog/build/%{cfg.buildcfg}/ide-out"
        objdir "vendor/spdlog/build/%{cfg.buildcfg}/ide-int/"