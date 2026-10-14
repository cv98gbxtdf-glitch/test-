-- Levelled logger. Prefixes every line with "[WereTools]" (or whatever name
-- the caller passes) and routes through `print` / `warn` so the executor's
-- own log pane picks them up.

local M = {}
M.__index = M

local LEVELS = { debug = 10, info = 20, warn = 30, error = 40 }

function M.new(name, minLevel)
  local self = setmetatable({}, M)
  self.name = name or "[WereTools]"
  self.minLevel = LEVELS[minLevel] or LEVELS.info
  return self
end

function M:_emit(sink, level, msg)
  if LEVELS[level] < self.minLevel then
    return
  end
  sink(string.format("%s %s: %s", self.name, level:upper(), tostring(msg)))
end

function M:debug(msg)
  self:_emit(print, "debug", msg)
end

function M:info(msg)
  self:_emit(print, "info", msg)
end

function M:warn(msg)
  self:_emit(warn, "warn", msg)
end

function M:error(msg)
  self:_emit(warn, "error", msg)
end

return M
