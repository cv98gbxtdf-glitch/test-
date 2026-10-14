-- Build-time configuration. One source of truth for backend URLs, feature
-- flags, and anything else modules used to read as bare globals.
--
-- Returns a factory. The bootstrap calls `require("core/config").load()` once
-- and attaches the result as `ctx.config`.

local M = {}

function M.load()
  return {
    backends = {
      "http://localhost:3000",
      "https://weretools.xyz",
    },
    primaryBackend = "http://localhost:3000",
    fallbackBackend = "https://weretools.xyz",
    debug = false,
  }
end

return M
