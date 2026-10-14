-- Backend failover: iterate the configured backends and return the first
-- that responds with a non-empty body and a 2xx status.

local M = {}
M.__index = M

function M.new(ctx)
  local self = setmetatable({}, M)
  self.ctx = ctx
  return self
end

-- Try each backend in order. `pathFn(base)` returns the full URL to hit for
-- that backend. `isAcceptable(response)` can veto a response that technically
-- succeeded (e.g. HTTP 200 with success:false). Returns `(ok, body, base)` or
-- `(false, err, nil)` if every backend failed.
function M:tryEach(pathFn, isAcceptable)
  local http = self.ctx.http
  local lastErr
  for _, base in ipairs(self.ctx.config.backends) do
    local url = pathFn(base)
    local ok, body, status = http:get(url)
    if ok and body and body ~= "" and status == 200 then
      if not isAcceptable or isAcceptable(body) then
        return true, body, base
      end
    end
    lastErr = body
  end
  return false, lastErr, nil
end

return M
