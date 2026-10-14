-- Bootstrap.
--
-- Builds the service container (`ctx`), loads every module factory with that
-- ctx, and launches the UI. Transitional mirrors to `_G` and `BACKENDS` live
-- here as a bridge so modules that haven't been migrated yet keep working.

local Ctx = require("ctx")
local ctx = Ctx.build()

-- Transitional mirrors. Modules migrated to `ctx.config.backends`,
-- `ctx.modules`, `ctx.auth`, `ctx.notify` no longer need these; the mirrors
-- are here while PR D/E/F migrate the rest.
BACKEND = ctx.config.primaryBackend
BACKEND_FALLBACK = ctx.config.fallbackBackend
BACKENDS = ctx.config.backends
_G.WereToolsModules = ctx.modules
_G.auth = ctx.auth:legacyTable()
_G.WereToolsSessionToken = ctx.auth:sessionToken()
_G.Notifier = ctx.notify:legacyNotifier()
_G.Compkiller = ctx.notify:legacyCompkiller()

-- (Legacy getgenv keys like `getgenv().Debug` and `getgenv().BUILD_OPTION`
-- are seeded in `core/public.lua` as part of `Public.ensure()`.)

local BoostStub = {
  RunBoostFlow = function()
    ctx.log:warn("[BoostModule] not provided")
  end,
}

-- Load order: ArtModule / LanguageModule / ChemistryModule / BasketballFarm
-- first (they set the getgenv globals schoolController used to read), then
-- the rest in historical add() order, then schoolController last.
local LOAD_ORDER = {
  { "ArtModule", "school/ArtModule" },
  { "LanguageModule", "school/LanguageModule" },
  { "ChemistryModule", "school/ChemistryModule" },
  { "BasketballFarm", "events/BasketballFarm" },
  { "taxi", "jobs/taxi" },
  { "hairdresser", "jobs/hairdresser" },
  { "pizza", "jobs/pizza" },
  { "burger", "jobs/burger" },
  { "teacher", "jobs/teacher" },
  { "janitor", "jobs/janitor" },
  { "fisher", "jobs/fisher" },
  { "cashier", "jobs/cashier" },
  { "icecream", "jobs/icecream" },
  { "mechanic", "jobs/mechanic" },
  { "miner", "jobs/miner" },
  { "stocker", "jobs/stocker" },
  { "lumber", "jobs/lumber" },
  { "bakery", "jobs/bakery" },
  { "SkillModule", "skills/SkillModule" },
  { "harvest", "skills/harvest" },
  { "PreviewBuild", "build/PreviewBuild" },
  { "wrapgift", "skills/wrapgift" },
  { "graphic", "world/graphic" },
  { "Camera", "world/Camera" },
  { "FrostyFriends", "events/FrostyFriends" },
  { "SnowBall", "events/SnowBall" },
  { "ArcticArt", "events/ArcticArt" },
  { "WinterEvent", "events/WinterEvent" },
  { "EggDrop", "events/EggDrop" },
  { "Snowplow", "events/Snowplow" },
  { "BuildModule", "build/BuildModule" },
  { "schoolController", "school/schoolController" },
}

local loaded, failed = 0, {}

for _, entry in ipairs(LOAD_ORDER) do
  local key, modulePath = entry[1], entry[2]
  local okRequire, factory = pcall(require, modulePath)
  if not okRequire or type(factory) ~= "function" then
    table.insert(failed, key .. " [require: " .. tostring(factory) .. "]")
  else
    local okRun, mod = pcall(factory, ctx)
    if okRun and mod ~= nil and mod ~= true then
      ctx.modules[key] = mod
      pcall(function()
        getgenv()[key] = mod
      end)
      loaded = loaded + 1
    else
      local reason = okRun and "returned nothing" or tostring(mod)
      table.insert(failed, key .. " [run: " .. reason .. "]")
    end
  end
end

ctx.modules.BoostModule = BoostStub

ctx.log:info(string.format("%d modules loaded", loaded))
if #failed > 0 then
  ctx.log:warn("failed: " .. table.concat(failed, ", "))
end

-- UI is a factory like every other module; it kicks off its own task.spawn
-- internally, so this returns promptly.
local uiFactory = require("ui/init")
if type(uiFactory) == "function" then
  pcall(uiFactory, ctx)
end
