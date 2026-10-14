-- Auth service.
--
-- Current implementation is a local always-licenced stub (same semantics as
-- the historical `_G.auth` table at the top of kushanv2). The interface is
-- what every module should call against; later we swap the stub for a real
-- backend-driven implementation without touching callers.

local M = {}
M.__index = M

function M.new(_ctx)
  local self = setmetatable({}, M)
  self._sessionToken = "local-session"
  return self
end

function M:sessionToken()
  return self._sessionToken
end

function M:setSessionToken(token)
  self._sessionToken = token
end

function M:token()
  return self._sessionToken
end

function M:type()
  return "Lifetime"
end

function M:sysId()
  return "local-hwid"
end

function M:ioRead()
  return "WERETOOLS-LIFETIME-LOCAL"
end

function M:ioWrite() end
function M:ioDelete() end

function M:secCheck2()
  return true
end

function M:secCheck3()
  return true, "Lifetime", {}
end

function M:exec(ok)
  if ok then
    ok("local")
  end
  return true
end

function M:req1(_, _, _, cb)
  cb(true, {
    session_token = self._sessionToken,
    key_type = "Lifetime",
    _validationProof = "local",
    expires_at = os.time() + 31536000,
  })
end

-- A table shaped like the historical `_G.auth` surface, for modules that
-- haven't been migrated to call `ctx.auth:...` directly yet. The bootstrap
-- publishes this to `_G.auth` as a transitional mirror.
function M:legacyTable()
  local service = self
  return {
    _token = function()
      return service:token()
    end,
    _type = function()
      return service:type()
    end,
    _sys_id = function()
      return service:sysId()
    end,
    _io_r = function()
      return service:ioRead()
    end,
    _io_w = function()
      return service:ioWrite()
    end,
    _io_d = function()
      return service:ioDelete()
    end,
    _sec_02 = function(...)
      return service:secCheck2(...)
    end,
    _sec_03 = function(...)
      return service:secCheck3(...)
    end,
    _exec = function(...)
      return service:exec(...)
    end,
    _req_01 = function(...)
      return service:req1(...)
    end,
  }
end

return M
