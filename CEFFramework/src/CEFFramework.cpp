#include "CEFFramework.hpp"

namespace CEFFramework
{
    CEFFramework::CEFFramework() noexcept
    {
        mP_LoggerOut = spdlog::stdout_color_mt("CEF-Out");
        mP_LoggerError = spdlog::stderr_color_mt("CEF-Error");

        mP_LoggerOut->info("Hello Framework!");
    }

    CEFFramework::~CEFFramework() noexcept
    {
        mP_LoggerOut->info("Goodbye Framework!");
    }
}