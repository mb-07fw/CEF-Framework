#ifndef _MSC_VER
	#error "This project is currently only buildable on Windows."
#endif

#define CF_EXPORT __declspec(dllexport)
#define CF_IMPORT __declspec(dllimport)

#ifdef CF_BUILD
	#define CF_API CF_EXPORT
#else
	#define CF_API CF_IMPORT
#endif