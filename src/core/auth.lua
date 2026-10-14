-- Auth / notifier stubs.
--
-- Mirrors the top-of-file bootstrap that kushanv2 shipped with: a local
-- "always-licenced" auth table and no-op Notifier / Compkiller mocks.
-- PR C replaces this with a real `ctx.auth` service and moves the mocks
-- behind a feature flag.

_G.WereToolsSessionToken = "local-session"
_G.Notifier = { new = function() end }
_G.Compkiller = {
  newNotify = function()
    return { new = function() end }
  end,
}

_G.auth = {
  _token = function()
    return "local-session"
  end,
  _type = function()
    return "Lifetime"
  end,
  _sys_id = function()
    return "local-hwid"
  end,
  _io_r = function()
    return "WERETOOLS-LIFETIME-LOCAL"
  end,
  _io_w = function() end,
  _io_d = function() end,
  _sec_02 = function()
    return true
  end,
  _sec_03 = function()
    return true, "Lifetime", {}
  end,
  _exec = function(ok)
    if ok then
      ok("local")
    end
    return true
  end,
  _req_01 = function(_, _, _, cb)
    cb(true, {
      session_token = "local-session",
      key_type = "Lifetime",
      _validationProof = "local",
      expires_at = os.time() + 31536000,
    })
  end,
}
