-- Тһіs Filе Ԝas Dеоbfusсаtеԁ Вy LеаkD
-- https://discord.gg/AwGHNh7Z7T

local workspaceService = game:GetService("Workspace")
local pathfindingService = game:GetService("PathfindingService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
module = {}
local dataService = replicatedStorage.Modules.DataService
local localValue1 = {}
local localValue2 = getconnections(dataService.DescendantAdded)[1].Function
local localValue3 = getupvalue(localValue2, 1)
local localValue4 = next
local localValue5, localValue6 = getupvalue(getupvalue(localValue2, 2), 1)

for localValue7, localValue8 in localValue4, localValue5, localValue6 do
  local sub = localValue8:sub(1, 2) == "F_" and localValue8:sub(3) or localValue8
  localValue1[sub] = localValue3[localValue7]
end

function pathfind(parameter1, parameter2)
  local getControls = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
  getControls:Disable()

  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
  local humanoid = character:WaitForChild("Humanoid")
  local path

  if type(parameter2) == "table" then
    path = pathfindingService:CreatePath(parameter2)
  else
    path = pathfindingService:CreatePath()
  end

  pcall(function()
    path:ComputeAsync(humanoidRootPart.Position, parameter1)
  end)

  if path.Status == Enum.PathStatus.Success then
    local localValue9 = next
    local localValue10, localValue11 = path:GetWaypoints()

    for localValue12, localValue13 in localValue9, localValue10, localValue11 do
      if not isFarming then
        break
      end

      humanoid:MoveTo(localValue13.Position)

      if localValue13.Action == Enum.PathWaypointAction.Jump then
        humanoid.Jump = true
      end

      humanoid.MoveToFinished:Wait()
    end
  end

  getControls:Enable()
end

local function helperFunction1(parameter3)
  if not parameter3 then
    return
  end

  pathfind(parameter3.Position)

  while parameter3 and parameter3:FindFirstChild("Object") do
    localValue1.CleanSchoolJanitorObject:InvokeServer({ Spawn = parameter3 })
    task.wait(2)
  end
end

local function helperFunction2()
  local character2 = localPlayer.Character

  if not character2 then
    return nil
  else
    local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return nil
    else
      local janitorSpawns = workspaceService.Environment.Locations.SchoolArea.School.JanitorSpawns
      local localValue14 = nil
      local huge = math.huge

      for index, value in ipairs(janitorSpawns:GetChildren()) do
        if value:FindFirstChild("Object") then
          local magnitude = (humanoidRootPart2.Position - value.Position).Magnitude

          if magnitude < huge then
            huge = magnitude
            localValue14 = value
          end
        end
      end

      return localValue14
    end
  end
end

function GoToWork(parameter4, name)
  local humanoidRootPart3 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter4 then
    return
  end

  if (humanoidRootPart3.Position - parameter4).Magnitude >= 300 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

function module.startAutoFarm()
  if isFarming then
    return
  end

  GoToWork(Vector3.new(981.3671875, 27.191165924072, -111.19209289551), "SchoolJanitor")
  isFarming = true

  task.spawn(function()
    while isFarming do
      local localValue15 = helperFunction2()

      if localValue15 then
        helperFunction1(localValue15)
      else
        task.wait(1)
      end

      task.wait(0.2)
    end
  end)
end

function module.stopAutoFarm()
  isFarming = false
end

return module
