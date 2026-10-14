-- Bootstrap.
--
-- 1. Pull in globals the modules depend on (BACKENDS, auth stub, Notifier).
-- 2. Load every module in a stable order; register in _G.WereToolsModules
--    for anything that still looks it up by key (the UI block does).
-- 3. Launch the UI.
--
-- The amalgamation shim (`require` injected by build/bundle.lua) handles
-- caching and cycle detection; a module that fails `require` is logged but
-- doesn't abort the bootstrap, matching the historical loader.

require("config")
require("core/auth")

local BoostStub = {
  RunBoostFlow = function()
    warn("[BoostModule] not provided")
  end,
}

local mods = _G.WereToolsModules or {}
_G.WereToolsModules = mods

-- Order: ArtModule / LanguageModule / ChemistryModule / BasketballFarm first
-- (they set the matching getgenv globals that schoolController reads), then
-- the rest in the original add() order, then schoolController last.
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
  local ok, mod = pcall(require, modulePath)
  if ok and mod ~= nil and mod ~= true then
    mods[key] = mod
    pcall(function()
      getgenv()[key] = mod
    end)
    loaded = loaded + 1
  else
    local reason = ok and "returned nothing" or tostring(mod)
    table.insert(failed, key .. " [require: " .. reason .. "]")
  end
end

mods.BoostModule = BoostStub

print(string.format("[WereTools] %d modules loaded", loaded))
if #failed > 0 then
  warn("[WereTools] failed: " .. table.concat(failed, ", "))
end

require("ui/init")
