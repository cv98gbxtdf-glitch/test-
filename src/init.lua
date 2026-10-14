-- Entry point. The bundler executes this module last.
--
-- PR A: smoke-test entry that just proves the pipeline is alive.
-- PR B: this is replaced by the real bootstrap (auth stub, module registry,
-- UI wiring).

local hello = require("hello")

hello.greet()
