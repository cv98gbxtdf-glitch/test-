-- The one documented, versioned surface third-party scripts and the end
-- user's own config may poke at. Everything that used to be a scattered
-- `getgenv().AutoClaimPayCheck`, `getgenv().BUILD_OPTION`, `getgenv().Debug`
-- etc. consolidates onto this single table.
--
-- Live state. Internal code should read/write `ctx.pub.X`; it is the exact
-- same table as `getgenv().WereTools`.
--
-- Legacy top-level keys (`getgenv().Debug`, `getgenv().AutoClaimPayCheck`,
-- `getgenv().BUILD_OPTION`) are seeded at startup from this table and
-- mutate in sync for table values (BUILD_OPTION is a shared table reference)
-- but not for scalars (write `getgenv().WereTools.Debug = true`, not
-- `getgenv().Debug = true`, if you want internal readers to see the change).

local M = {}

local VERSION = "0.3.0-pr-c"

function M.ensure()
  local existing = getgenv().WereTools
  if type(existing) == "table" then
    existing.version = VERSION
    return existing
  end

  -- Seed from any legacy keys the end user set before loading the script
  -- (`getgenv().Debug = true`, `getgenv().BUILD_OPTION = {...}`, …).
  local legacyBuildOption = type(getgenv().BUILD_OPTION) == "table" and getgenv().BUILD_OPTION
    or nil
  local pub = {
    version = VERSION,
    Debug = getgenv().Debug == true,
    AutoClaimPayCheck = getgenv().AutoClaimPayCheck == true,
    WrapgiftAmount = tonumber(getgenv().WrapgiftAmount) or 100000,
    BUILD_OPTION = legacyBuildOption or {
      CanCollide = true,
      ShowStructuralItems = true,
    },
    WereTools_BuildFilter = type(getgenv().WereTools_BuildFilter) == "table"
        and getgenv().WereTools_BuildFilter
      or nil,
    WereTools_UpdateBuild = type(getgenv().WereTools_UpdateBuild) == "function"
        and getgenv().WereTools_UpdateBuild
      or nil,
  }
  -- Default fields in BUILD_OPTION if the user supplied a partial table.
  if pub.BUILD_OPTION.CanCollide == nil then
    pub.BUILD_OPTION.CanCollide = true
  end
  if pub.BUILD_OPTION.ShowStructuralItems == nil then
    pub.BUILD_OPTION.ShowStructuralItems = true
  end

  getgenv().WereTools = pub
  -- Mirror BUILD_OPTION *by reference* so writes to either path mutate the
  -- same table. Scalar mirrors are one-way (startup-only).
  getgenv().BUILD_OPTION = pub.BUILD_OPTION
  getgenv().Debug = pub.Debug
  getgenv().AutoClaimPayCheck = pub.AutoClaimPayCheck
  return pub
end

return M
