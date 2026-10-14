--!strict
-- Shared Luau type exports for the WereTools codebase.
--
-- These are purely for the editor (Luau LSP in VS Code picks them up
-- automatically because they're `.luau` under `src/`). The amalgamation
-- bundler erases them at build time; `.lua` modules that want LSP help
-- can require them with `local T = require("types")` at the top.

export type HttpResponse = {
  StatusCode: number,
  Body: string?,
  Headers: { [string]: string }?,
}

export type HttpRequest = (
  opts: {
    Url: string,
    Method: string?,
    Headers: { [string]: string }?,
    Body: string?,
  }
) -> HttpResponse

export type Logger = {
  debug: (self: Logger, msg: string) -> (),
  info: (self: Logger, msg: string) -> (),
  warn: (self: Logger, msg: string) -> (),
  error: (self: Logger, msg: string) -> (),
}

export type Http = {
  executorRequest: (self: Http) -> HttpRequest?,
  get: (self: Http, url: string) -> (boolean, string | any, number?),
  postJson: (
    self: Http,
    url: string,
    body: string,
    extraHeaders: { [string]: string }?
  ) -> (boolean, string | any, number?),
}

export type Backend = {
  tryEach: (
    self: Backend,
    pathFn: (base: string) -> string,
    isAcceptable: ((body: string) -> boolean)?
  ) -> (boolean, string | any, string?),
}

export type Auth = {
  sessionToken: (self: Auth) -> string,
  setSessionToken: (self: Auth, token: string) -> (),
  token: (self: Auth) -> string,
  type: (self: Auth) -> string,
  sysId: (self: Auth) -> string,
  ioRead: (self: Auth) -> string,
  ioWrite: (self: Auth) -> (),
  ioDelete: (self: Auth) -> (),
  secCheck2: (self: Auth, ...any) -> boolean,
  secCheck3: (self: Auth, ...any) -> (boolean, string, { any }),
  exec: (self: Auth, ok: ((any) -> ())?) -> boolean,
  req1: (
    self: Auth,
    _: any,
    _: any,
    _: any,
    cb: (ok: boolean, response: { [string]: any }) -> ()
  ) -> (),
  legacyTable: (self: Auth) -> { [string]: any },
}

export type Notify = {
  setBackend: (self: Notify, backend: { new: (opts: any) -> () }) -> (),
  new_: (self: Notify, opts: any) -> (),
  legacyCompkiller: (self: Notify) -> { newNotify: () -> { new: (any) -> () } },
  legacyNotifier: (self: Notify) -> { new: (any) -> () },
}

export type Config = {
  backends: { string },
  primaryBackend: string,
  fallbackBackend: string,
  debug: boolean,
}

export type BuildOption = {
  CanCollide: boolean,
  ShowStructuralItems: boolean,
}

export type BuildFilter = {
  Walls: boolean,
  Floors: boolean,
  Roofs: boolean,
  Basements: boolean,
  Paths: boolean,
  Counters: boolean,
  Fences: boolean,
  Pools: boolean,
  Objects: boolean,
}

export type Public = {
  version: string,
  Debug: boolean,
  AutoClaimPayCheck: boolean,
  WrapgiftAmount: number,
  BUILD_OPTION: BuildOption,
  WereTools_BuildFilter: BuildFilter?,
  WereTools_UpdateBuild: ((category: string, enabled: boolean) -> ())?,
}

export type Ctx = {
  config: Config,
  log: Logger,
  http: Http,
  backend: Backend,
  auth: Auth,
  notify: Notify,
  pub: Public,
  modules: { [string]: any },
}

-- UI env (what each tab factory receives).
export type UIEnv = {
  ctx: Ctx,
  Library: any,
  SaveManager: any,
  ThemeManager: any,
  window: any,
  tabs: { [string]: any },
  modules: { [string]: any },
  players: any,
  httpService: any,
  replicatedStorage: any,
  runService: any,
  coreGui: any,
  virtualUser: any,
  teleportService: any,
  localPlayer: any,
  isPremium: boolean,
  keyType: string,
  keyRef: string,
  cfg: { [string]: any },
  remotes: { [string]: any },
  skillTweaks: { [string]: boolean },
  flags: {
    running: boolean,
    uiQuiet: boolean,
    webhookEnabled: boolean,
  },
  dropdowns: {
    players: any,
    build: any,
    stats: any,
  },
  state: {
    activeAutoFarm: any,
  },
  auth: { [string]: any },
  helpers: {
    notify: (title: string, desc: string, time: number?) -> (),
    premiumRequired: () -> (),
    requirePremium: () -> boolean,
    confirmDialog: (title: string, desc: string, onConfirm: (() -> ())?) -> (),
    jobModules: () -> { [string]: any },
    parseShiftTime: (text: string?) -> number,
    findDeep: (root: any, path: { string }) -> any?,
    disableIdled: (player: any) -> (),
    startAntiAfk: () -> (),
    stopAntiAfk: () -> (),
    listPlayers: () -> { string },
    pollMood: () -> (string | number, number, number, number, number),
    listPlotPlayers: () -> { string },
  },
}

return nil
