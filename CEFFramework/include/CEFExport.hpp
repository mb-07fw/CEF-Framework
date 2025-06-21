#ifndef _MSC_VER
	#error "This project is currently only buildable on Windows."
#endif

#define CEF_FRAMEWORK_EXPORT __declspec(dllexport)
#define CEF_FRAMEWORK_IMPORT __declspec(dllimport)

#ifdef CEF_FRAMEWORK_BUILD
	#define CEF_FRAMEWORK_API CEF_FRAMEWORK_EXPORT
#else
	#define CEF_FRAMEWORK_API CEF_FRAMEWORK_IMPORT
#endif