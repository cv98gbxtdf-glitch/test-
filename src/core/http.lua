-- Unified HTTP request shim. Modules used to inline the three-way dance
-- `request or http_request or syn and syn.request` at every call site; this
-- centralises it and lets us log or mock around it later.

local M = {}
M.__index = M

local function pickExecutorRequest()
  if type(_G.request) == "function" then
    return _G.request
  end
  if type(_G.http_request) == "function" then
    return _G.http_request
  end
  if type(_G.syn) == "table" and type(_G.syn.request) == "function" then
    return _G.syn.request
  end
  return nil
end

function M.new(ctx)
  local self = setmetatable({}, M)
  self.ctx = ctx
  self._request = pickExecutorRequest()
  return self
end

-- Returns the executor request function, or nil if none is available.
-- Callers that need to send bodies / custom methods must have this.
function M:executorRequest()
  return self._request
end

-- GET helper that works even without an executor request function (falls
-- back to `game:HttpGet`). Returns `(ok, bodyOrErr, statusCode?)`.
function M:get(url)
  if self._request then
    local ok, resp = pcall(self._request, { Url = url, Method = "GET" })
    if ok and resp and resp.Body ~= nil then
      return true, resp.Body, resp.StatusCode
    end
    return false, resp
  end
  local ok, body = pcall(game.HttpGet, game, url)
  if ok then
    return true, body, 200
  end
  return false, body
end

-- POST with a JSON body. Returns `(ok, bodyOrErr, statusCode?)`.
-- No executor request function => fails cleanly (no HttpGet fallback for POST).
function M:postJson(url, body, extraHeaders)
  if not self._request then
    return false, "no executor request function available"
  end
  local headers = { ["Content-Type"] = "application/json" }
  if extraHeaders then
    for k, v in pairs(extraHeaders) do
      headers[k] = v
    end
  end
  local ok, resp = pcall(self._request, {
    Url = url,
    Method = "POST",
    Headers = headers,
    Body = body,
  })
  if ok and resp and resp.Body ~= nil then
    return true, resp.Body, resp.StatusCode
  end
  return false, resp
end

return M
