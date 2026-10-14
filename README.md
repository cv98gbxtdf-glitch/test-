# WereTools (kushanv2)

Bloxburg automation script. Historically shipped as a single ~15 000-line
file; this repo is being restructured into a multi-file source tree that
bundles to one deliverable.

## Layout

```
src/           Lua source modules (one responsibility per file)
build/         Lune-based build tooling
dist/kushanv2  Generated single-file deliverable (the loadstring target)
```

**Do not edit `dist/kushanv2` by hand.** It is generated. Edit sources
under `src/` and regenerate.

## Development

### One-time setup

Install [Rokit](https://github.com/rojo-rbx/rokit), then from the repo
root:

```sh
rokit install
```

That pins `lune`, `selene`, and `stylua` to the versions in
[`rokit.toml`](./rokit.toml).

### Everyday loop

```sh
lune run build/bundle   # regenerate dist/kushanv2
stylua src/ build/      # format
selene src/             # lint
```

CI runs the same checks on every push and fails the build if `dist/`
is out of date with respect to `src/`.

### Smoke-test the bundle

```sh
cp dist/kushanv2 /tmp/kushanv2.lua
lune run /tmp/kushanv2.lua
```

(The copy is because Lune refuses extensionless script files.)

## Shipping

End users load the script by `loadstring(game:HttpGet(RAW_URL))()`.
`RAW_URL` points at `dist/kushanv2`:

```
https://raw.githubusercontent.com/cv98gbxtdf-glitch/test-/<branch>/dist/kushanv2
```

> **Note:** before PR B, the shipped URL was the root `kushanv2`. That path
> is gone; update any existing loadstring snippets to point at `dist/kushanv2`.

## Architecture

See [`ARCHITECTURE.md`](./ARCHITECTURE.md) for the design, module
contract, and roll-out plan.
