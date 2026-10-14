-- Placeholder module. Exists only to prove the amalgamation bundler can emit a
-- module, that `init.lua` can require it, and that the resulting single file
-- loads cleanly in a Lua interpreter. Deleted in PR B.

local M = {}

function M.greet()
    print("[WereTools] bundler pipeline alive")
end

return M
