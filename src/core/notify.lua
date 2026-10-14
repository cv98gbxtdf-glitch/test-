-- Notification service. Historically the modules consulted a chain of
-- `_G.Compkiller` / `_G.Notifier` / `getgenv().Compkiller` / `getgenv().Notifier`
-- to find something that could create a toast; this centralises the pick.
--
-- When the Obsidian UI is up, `ctx.notify` is swapped for a wrapper that
-- routes through `Library:Notify()`; until then it's a no-op.

local M = {}
M.__index = M

local function noopNotifier()
  return {
    new = function() end,
  }
end

function M.new(_ctx)
  local self = setmetatable({}, M)
  self._backend = noopNotifier()
  return self
end

-- Replace the backing notifier (used by `ui/init.lua` to route everything
-- through Library:Notify once the Obsidian window is live).
function M:setBackend(backend)
  self._backend = backend or noopNotifier()
end

function M:new_(opts)
  if self._backend and self._backend.new then
    self._backend.new(opts)
  end
end

-- Returns a table shaped like the legacy `_G.Compkiller` / `_G.Notifier`
-- globals so unmigrated modules keep working.
function M:legacyCompkiller()
  local service = self
  return {
    newNotify = function()
      return {
        new = function(opts)
          service:new_(opts)
        end,
      }
    end,
  }
end

function M:legacyNotifier()
  local service = self
  return {
    new = function(opts)
      service:new_(opts)
    end,
  }
end

return M
