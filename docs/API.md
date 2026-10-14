# Public API

The single documented surface third-party scripts and the end user's own
startup config may read or write is `getgenv().WereTools`. It is the exact
same table as `ctx.pub` inside the script; internal modules read and write
through `ctx.pub.X`, external callers through `getgenv().WereTools.X`.

Reads and writes are live state. There is **no** separate "set/get"
indirection — assigning `getgenv().WereTools.Debug = true` is immediately
visible to any internal module that reads `ctx.pub.Debug` next time it
looks.

## Shape

```lua
getgenv().WereTools = {
    version = "0.3.0-pr-c",

    -- Feature flags
    Debug = false,                 -- true writes debug saves locally instead of uploading
    AutoClaimPayCheck = false,     -- live-toggle for the paycheck auto-claim loop
    WrapgiftAmount = 100000,       -- money per gift to send via Wrap Gift

    -- Build config (same table reference as getgenv().BUILD_OPTION so writes
    -- to either path are observed on both)
    BUILD_OPTION = {
        CanCollide = true,
        ShowStructuralItems = true,
    },

    -- Set by BuildModule once it has initialised; third-party code may call
    -- `getgenv().WereTools.WereTools_UpdateBuild("Walls", true)` to toggle a
    -- category filter the same way the Multi Build Config dropdown does.
    WereTools_UpdateBuild = function(category: string, enabled: boolean) end,

    -- Set by BuildModule to the current category-enablement table. Treat as
    -- read-only — use WereTools_UpdateBuild to mutate.
    WereTools_BuildFilter = {
        Walls = true, Floors = true, Roofs = true, Basements = true,
        Paths = true, Counters = true, Fences = true, Pools = true,
        Objects = true,
    },
}
```

## Preloading flags before the script runs

You can set keys on `getgenv().WereTools` or on the legacy top-level
`getgenv()` keys before the script executes. `core/public.lua` seeds the
canonical table from both.

```lua
-- Example startup wrapper
getgenv().WereTools = { Debug = true, AutoClaimPayCheck = true }
loadstring(game:HttpGet("https://raw.githubusercontent.com/.../dist/kushanv2"))()
```

The following legacy top-level `getgenv()` keys are still read at startup
for backward compatibility but should be migrated to the `WereTools.X`
form:

| Legacy key                   | Canonical replacement                 |
|------------------------------|---------------------------------------|
| `getgenv().Debug`            | `getgenv().WereTools.Debug`           |
| `getgenv().AutoClaimPayCheck`| `getgenv().WereTools.AutoClaimPayCheck` |
| `getgenv().WrapgiftAmount`   | `getgenv().WereTools.WrapgiftAmount`  |
| `getgenv().BUILD_OPTION`     | `getgenv().WereTools.BUILD_OPTION` (same table reference) |
| `getgenv().WereTools_BuildFilter` | `getgenv().WereTools.WereTools_BuildFilter` |
| `getgenv().WereTools_UpdateBuild` | `getgenv().WereTools.WereTools_UpdateBuild` |

Scalar legacy keys are set once at startup. Mutating them after
`WereTools` is seeded will NOT propagate — write to the canonical path.
Table-valued legacy keys (`BUILD_OPTION`) share a reference with the
canonical table so writes to either are observed on both.

## Session control

`getgenv().WereTools_StopLoops` is a function the script publishes once
the UI is live. Calling it flips the internal `running` flag to `false`
and lets every background `while` loop (webhook sender, auth refresh,
dropdown refresh, break timer, mood watcher, auto-farm skills, …) exit on
its next tick. Call it before re-running the script to avoid leaking
tasks.

```lua
if getgenv().WereTools_StopLoops then
    getgenv().WereTools_StopLoops()
end
task.wait(0.5)
loadstring(game:HttpGet(...))()
```

## Session-written files

The script reads and writes a handful of files in the executor's workspace
root. End users can delete these to reset state.

| File                            | Written by      | Role                                              |
|---------------------------------|-----------------|---------------------------------------------------|
| `WereToolsWebhook.txt`          | Settings tab    | Saved Discord webhook URL + ping ID              |
| `WereTools_AutoHop.json`        | Misc tab        | Saved AutoHop target + delay                     |
| `WereTools_UnplacedItems.json`  | BuildModule     | Post-mortem of items that didn't place            |
| `build_data.json`               | BuildModule     | Mid-build snapshot for Continue Build             |
| `build_progress.json`           | BuildModule     | Mid-build progress for Continue Build             |

## Where this lives in source

- Public table shape and legacy mirrors: `src/core/public.lua`
- Session running flag plumbing: `src/ui/init.lua` → `src/ui/loops.lua`
- BuildModule reads/writes: `src/build/BuildModule.lua`
