return function(ctx)
  local RunService = game:GetService("RunService")

  local M = {}
  local lowpolyEnabled = false
  local addedConnection

  -- Whitelist folder (không xoá texture/mesh bên trong)
  local gameFolder = workspace:FindFirstChild("_game")
  local oreFolder = gameFolder and gameFolder:FindFirstChild("Folder")

  -- ===== Helper: Kiểm tra có nằm trong whitelist không =====
  local function isWhitelisted(obj)
    return oreFolder and obj:IsDescendantOf(oreFolder)
  end

  -- ===== Helper: Simplify Object =====
  local function simplifyObject(obj)
    if not obj or not obj.Parent then
      return
    end
    if isWhitelisted(obj) then
      return
    end

    if obj:IsA("BasePart") then
      obj.Material = Enum.Material.SmoothPlastic
      if obj:IsA("MeshPart") then
        obj.TextureID = ""
      end
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
      obj.Enabled = false
    elseif obj:IsA("PostEffect") then
      obj.Enabled = false
    end
  end

  -- ===== Apply Lowpoly (once + future objects) =====
  local function applyLowpoly()
    if lowpolyEnabled then
      return
    end
    lowpolyEnabled = true

    -- Duyệt qua toàn bộ object (theo coroutine để tránh lag)
    task.spawn(function()
      local objs = workspace:GetDescendants()
      for i = 1, #objs do
        simplifyObject(objs[i])
        if i % 100 == 0 then
          task.wait() -- ngắt frame để không treo game
        end
      end
    end)

    -- Đơn giản hoá object mới spawn sau
    addedConnection = workspace.DescendantAdded:Connect(function(obj)
      if lowpolyEnabled then
        task.defer(function()
          simplifyObject(obj)
        end)
      end
    end)
  end

  -- ===== Restore Graphics =====
  local function restoreGraphics()
    lowpolyEnabled = false
    if addedConnection then
      addedConnection:Disconnect()
      addedConnection = nil
    end
    if setfpscap then
      setfpscap(360)
    end
  end

  -- ===== Public API =====
  function M.setPotatoMode(state: boolean)
    if state then
      applyLowpoly()
      if setfpscap then
        setfpscap(30)
      end
    else
      restoreGraphics()
    end
  end

  return M
end
