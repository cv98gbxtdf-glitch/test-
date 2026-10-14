-- Service container builder. Every module gets a reference to this `ctx`
-- table via its factory parameter; `ctx` is the only shared state between
-- modules. (`_G` and `getgenv()` writes elsewhere are strictly for the public
-- surface + unmigrated transitional reads.)

local Config = require("core/config")
local Logger = require("core/logger")
local Http = require("core/http")
local Backend = require("core/backend")
local Auth = require("core/auth")
local Notify = require("core/notify")
local Public = require("core/public")

local M = {}

function M.build()
  local ctx = {}
  ctx.config = Config.load()
  ctx.log = Logger.new("[WereTools]", "info")
  ctx.http = Http.new(ctx)
  ctx.backend = Backend.new(ctx)
  ctx.auth = Auth.new(ctx)
  ctx.notify = Notify.new(ctx)
  ctx.pub = Public.ensure()
  ctx.modules = {}
  return ctx
end

return M
