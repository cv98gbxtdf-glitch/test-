# Architecture

## Goal

Replace the ~15 000-line single-file script with a multi-file source
tree that bundles to one deliverable. Nothing bolted-on: every piece of
the historical ad-hoc design (string-wrapped module loader, `_G`-based
registry, scattered `request`/`http_request` shims, inline obfuscator
sentinels) is replaced by a first-class equivalent.

## Non-goals

- **Rojo/Wally.** This is an executor script, not a Roblox game. The
  deliverable is a single file loaded via `loadstring(HttpGet(url))()`.
  Rojo file-system sync and Wally package resolution don't fit.
- **Behaviour change in PR A.** The pipeline lands first; module
  extraction and feature work follow.

## Module contract

Every file under `src/` returns a module table from its top-level
chunk:

```lua
-- src/jobs/taxi.lua
local Taxi = {}

function Taxi.new(ctx)
    local self = setmetatable({}, { __index = Taxi })
    self.ctx = ctx
    self.running = false
    return self
end

function Taxi:startAutoFarm() --[[ … ]] end
function Taxi:stopAutoFarm()  --[[ … ]] end

return Taxi
```

A module gets `require` as a parameter (injected by the amalgamation
shim) and never reaches for `_G` or `getgenv()` for internal
communication. Dependencies arrive via `require("other/module")` or via
the shared service container `ctx`, which is constructed by the
bootstrap and passed to each module's constructor.

`getgenv()` survives *only* on the end-user boundary — specifically,
`getgenv().WereTools = {...}` as a documented, versioned surface that
third-party scripts have historically poked at. Scattered writes like
`getgenv().AutoClaimPayCheck = …` are consolidated into that one table.

## Bundler

[`build/bundle.lua`](./build/bundle.lua) is a Lune script. It walks
`src/` and emits `dist/kushanv2` as a single file where each source
module becomes a factory function in a `_MODULES` table, keyed by its
path relative to `src/` without the `.lua` extension
(`src/jobs/taxi.lua` → `"jobs/taxi"`). A `_require` shim provides
caching and cycle detection, and the entry module `src/init.lua` is
executed at the bottom.

This is the standard "amalgamation" pattern (busted, luastatic,
amalg.lua). It gives us:

- real syntax errors at *bundle* time instead of silent `loadstring`
  failures at runtime
- deterministic module order
- a module cache
- cycle detection with a readable error message
- a `require` scope that doesn't collide with Roblox's instance-based
  `require()`

## Shared services (introduced in PR C)

A `ctx` table built by the bootstrap and threaded through every module
constructor:

| Field        | Backing module          | Role                                       |
|--------------|-------------------------|--------------------------------------------|
| `ctx.log`    | `src/core/logger.lua`   | levelled logger (debug/info/warn/error)    |
| `ctx.http`   | `src/core/http.lua`     | unified `request/http_request/syn.request` |
| `ctx.config` | `src/core/config.lua`   | reads `config/default.lua` or `prod.lua`   |
| `ctx.backend`| `src/core/backend.lua`  | failover across `BACKENDS[]`               |
| `ctx.auth`   | `src/core/auth.lua`     | key / session / HWID                       |
| `ctx.remotes`| `src/core/remotes.lua`  | DataService remote discovery               |
| `ctx.ui`     | `src/ui/init.lua`       | Obsidian window + addons                   |

## Toolchain

Pinned in [`rokit.toml`](./rokit.toml):

- **[Lune](https://github.com/lune-org/lune)** — standalone Luau
  runtime. Runs the bundler and any dev scripts.
- **[Selene](https://github.com/Kampfkarren/selene)** — linter.
- **[StyLua](https://github.com/JohnnyMorganz/StyLua)** — formatter.

CI runs StyLua check, Selene lint, re-bundles, smoke-runs the output,
and verifies `dist/` is in sync with `src/`.

## Roll-out

Each PR is independent, each lands green, each can be rolled back
cleanly.

| PR  | Scope                                                                 | Status  |
|-----|-----------------------------------------------------------------------|---------|
| A   | Pipeline: Rokit, Lune bundler, Selene, StyLua, CI, docs. No behaviour | **in**  |
| B   | Extract the 32 inline modules + bootstrap + UI into `src/`            | pending |
| C   | Core services (`ctx`), config layer, drop `_G`/`getgenv` internals    | pending |
| D   | `BuildModule`/`PreviewBuild` split + rename + correctness fixes       | pending |
| E   | UI componentisation: one file per tab, declarative builders           | pending |
| F   | Tests (Lune), type stubs (`.d.luau`), public API doc                  | pending |

## What goes away

- `add("key", [====[ ... ]====])` string-wrapped loader.
- `_G.WereToolsModules` module registry.
- `localValue1`–`localValue200` and `helperFunction1`–`helperFunction40`
  deobfuscator artefacts (renamed per module as PRs touch them).
- `LPH_OBFUSCATED` / `LPH_NO_VIRTUALIZE` Luraph sentinels.
- Hard-coded `BACKEND = "http://localhost:3000"` dev stub (moves to
  `config/default.lua`).
- Scattered `request or http_request or syn.request` shims (unified in
  `ctx.http`).
