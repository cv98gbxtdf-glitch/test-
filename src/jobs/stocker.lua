--[[
    Deоbfuѕсаtеԁ Ԝіth LеаκD
    https://discord.gg/AwGHNh7Z7T
]]

local replicatedStorage = game:GetService("ReplicatedStorage")
local pathfindingService = game:GetService("PathfindingService")
local players = game:GetService("Players")
local localValue1 = {}
local localValue2 = false

if not replicatedStorage:FindFirstChild("Remotes") then
  local remotes = Instance.new("Folder")
  remotes.Name = "Remotes"
  remotes.Parent = replicatedStorage
end

local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local localValue3 = { data_manager = replicatedStorage.Modules:WaitForChild("DataService", 10) }
local localValue4 = {}

task.spawn(function()
  if localValue3.data_manager then
    pcall(function()
      local localValue5 = getconnections(localValue3.data_manager.DescendantAdded)[1].Function
      local localValue6 = getupvalue(localValue5, 1)
      local localValue7, localValue8 = getupvalue(getupvalue(localValue5, 2), 1)

      for key, value in next, localValue7, localValue8 do
        local sub = value:sub(1, 2) == "F_" and value:sub(3) or value
        localValue4[sub] = localValue6[key]
      end

      print("Loaded Remotes")
    end)
  end
end)

local function helperFunction1(parameter1)
  if parameter1:IsA("BasePart") then
    return parameter1.Position
  elseif parameter1:IsA("Model") then
    if parameter1.PrimaryPart then
      return parameter1.PrimaryPart.Position
    end

    for index, value2 in ipairs(parameter1:GetChildren()) do
      if value2:IsA("BasePart") then
        return value2.Position
      end
    end

    return nil
  else
    return nil
  end
end

local function helperFunction2(parameter2, parameter3)
  local huge = math.huge

  if not parameter2 then
    return nil
  end

  local localValue9

  for index2, value3 in ipairs(parameter2:GetChildren()) do
    if value3:IsA("MeshPart") then
      local magnitude = (value3.Position - parameter3).Magnitude

      if magnitude < huge then
        localValue9 = value3
        huge = magnitude
      end
    end
  end

  return localValue9
end

local function helperFunction3(parameter4, parameter5)
  local vector = parameter5
  local localValue10, path

  if not parameter4 then
    return
  else
    if not vector or typeof(vector) ~= "Vector3" then
      vector = Vector3.new(0, 0, 0)
    end

    localValue10 = parameter4 + vector

    path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = true,
    })

    local localValue11, localValue12 = pcall(function()
      path:ComputeAsync(humanoidRootPart.Position, localValue10)
    end)

    if localValue11 and path.Status == Enum.PathStatus.Success then
      for index3, value4 in ipairs((path:GetWaypoints())) do
        if not localValue2 then
          break
        end

        if value4.Action == Enum.PathWaypointAction.Jump then
          humanoid.Jump = true
        end

        humanoid:MoveTo(value4.Position)

        if not humanoid.MoveToFinished:Wait() then
          humanoidRootPart.CFrame = CFrame.new(value4.Position + Vector3.new(0, 3, 0))
        end

        if (humanoidRootPart.Position - localValue10).Magnitude < 4 then
          break
        end
      end
    else
      humanoid:MoveTo(localValue10)
      humanoid.MoveToFinished:Wait()
    end

    return
  end
end

function GoToWork(parameter6, name)
  local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter6 then
    return
  end

  if (humanoidRootPart2.Position - parameter6).Magnitude >= 200 then
    localValue4.ToWork:InvokeServer({ Name = name })
  end
end

local function helperFunction4()
  while localValue2 do
    local localValue13, localValue14 = pcall(function()
      local waitForChild = workspace.Environment.Locations:WaitForChild("City", 5)

      if not waitForChild then
        return
      else
        local shelves = waitForChild.Supermarket.Interior.Shelves
        local localValue15 = nil

        for index4, value5 in ipairs(shelves:GetChildren()) do
          local isEmpty = value5:FindFirstChild("IsEmpty")

          if isEmpty and isEmpty:IsA("BoolValue") and isEmpty.Value == true then
            localValue15 = value5
            break
          end
        end

        if localValue15 then
          local vector2 = Vector3.new(545.75, 23.14, -779.9)
          local vector3 = Vector3.new(538.59, 23.14, -783.7)
          local vector4 = Vector3.new(516.48, 23.14, -748.8)
          helperFunction3(vector2)
          local localValue16 =
            helperFunction2(waitForChild.Supermarket.Geometry.Crates, humanoidRootPart.Position)

          if localValue16 then
            if localValue4.TakeFoodCrate then
              localValue4.TakeFoodCrate:FireServer({ Object = localValue16 })
            else
              local findFirstChild = replicatedStorage:FindFirstChild("TakeFoodCrate", true)

              if findFirstChild then
                findFirstChild:FireServer({ Object = localValue16 })
              end
            end

            task.wait(0.5)

            helperFunction3(vector3)
            helperFunction3(vector4)

            local localValue17 = helperFunction1(localValue15)

            if localValue17 then
              helperFunction3(localValue17 + (vector4 - localValue17).Unit * 4)
              humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, localValue17)
              task.wait(0.3)

              if localValue4.RestockShelf then
                if localValue4.RestockShelf:FireServer({ Shelf = localValue15 }) then
                  helperFunction3(vector4)
                end
              end
            else
              warn("❌ Cant find this stupid shelf: " .. localValue15.Name)
            end
          end
        else
          task.wait(1)
        end

        return
      end
    end)

    if not localValue13 then
      warn("Stock Loop Error: " .. tostring(localValue14))
    end

    task.wait(0.5)
  end
end

function localValue1.startAutoFarm()
  if localValue2 then
    return
  end

  GoToWork(Vector3.new(569.06536865234, 23.137680053711, -783.57623291016), "SupermarketStocker")

  localValue2 = true
  task.spawn(helperFunction4)
  print("[Start] AutoStockShelf ")
end

function localValue1.stopAutoFarm()
  localValue2 = false
  print("[Stop] AutoStockShelf")
end

return localValue1
