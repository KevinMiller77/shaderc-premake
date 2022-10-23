project "shaderc_util"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
    staticruntime("On")

    location("build/%{prj.name}")
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    prebuildcommands {
        "python %{prj.location}/../../shaderc/utils/git-sync-deps",
        "{MKDIR} %{prj.location}/../../shaderc/build",
        "cmake -B %{prj.location}/../../shaderc/build -S %{prj.location}/../../shaderc"
    }

    dependson {
        "GenericCodeGen",
        "OGLCompiler",
        "OSDependent",
        "MachineIndependent",
        "SPIRV",
        "SPVRemapper",
        "glslang",
        "glslang-default-resource-limits",
        "SPIRV-Tools",
        "SPIRV-Tools-opt",
    }

	files
	{
        "shaderc/libshaderc_util/include/libshaderc_util/counting_includer.h",
        "shaderc/libshaderc_util/include/libshaderc_util/file_finder.h",
        "shaderc/libshaderc_util/include/libshaderc_util/format.h",
        "shaderc/libshaderc_util/include/libshaderc_util/io_shaderc.h",
        "shaderc/libshaderc_util/include/libshaderc_util/mutex.h",
        "shaderc/libshaderc_util/include/libshaderc_util/message.h",
        "shaderc/libshaderc_util/include/libshaderc_util/resources.h",
        "shaderc/libshaderc_util/include/libshaderc_util/spirv_tools_wrapper.h",
        "shaderc/libshaderc_util/include/libshaderc_util/string_piece.h",
        "shaderc/libshaderc_util/include/libshaderc_util/universal_unistd.h",
        "shaderc/libshaderc_util/include/libshaderc_util/version_profile.h",
        "shaderc/libshaderc_util/src/args.cc",
        "shaderc/libshaderc_util/src/compiler.cc",
        "shaderc/libshaderc_util/src/file_finder.cc",
        "shaderc/libshaderc_util/src/io_shaderc.cc",
        "shaderc/libshaderc_util/src/message.cc",
        "shaderc/libshaderc_util/src/resources.cc",
        "shaderc/libshaderc_util/src/shader_stage.cc",
        "shaderc/libshaderc_util/src/spirv_tools_wrapper.cc",
        "shaderc/libshaderc_util/src/version_profile.cc",
	}

    includedirs {
        "shaderc/libshaderc/include",
        "shaderc/libshaderc_util/include",

        "shaderc/build/include",

        "glslang",
        "spirv-headers/include",

        "SPIRV-Tools/include",
        "SPIRV-Headers/include"
    }

    defines {
        "ENABLE_HLSL"
    }

    filter "system:windows"
        defines {
            'WIN32',
            '_WINDOWS',
        }

	filter "system:linux"
		pic "On"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"