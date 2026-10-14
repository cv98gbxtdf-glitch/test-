-- Build-time configuration.
--
-- Historically these lived as unprotected globals at the top of kushanv2.
-- They're still globals here (modules like BuildModule read `BACKENDS`
-- directly) — PR C moves them behind `ctx.config` and strips the globals.

BACKEND = "http://localhost:3000"
BACKEND_FALLBACK = "https://weretools.xyz"
BACKENDS = { BACKEND, BACKEND_FALLBACK }
