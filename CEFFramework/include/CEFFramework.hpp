#include "CEFExport.hpp"

#include <spdlog/spdlog.h>
#include <spdlog/logger.h>
#include <spdlog/sinks/stdout_color_sinks.h>

#include <memory>

#pragma warning(push)

/* spdlog::logger needs to have a dll-interface to be used
 *   outside of CEFFramework boundaries, but this behavior
 *   is currently not desired anyway.
 */
#pragma warning(disable : 4251)

namespace CEFFramework
{

    class CF_API CEFFramework
    {
    public:
        CEFFramework() noexcept;
        ~CEFFramework() noexcept;
    private:
        std::shared_ptr<spdlog::logger> mP_LoggerOut;
        std::shared_ptr<spdlog::logger> mP_LoggerError;
    };
}

#pragma warning(pop)