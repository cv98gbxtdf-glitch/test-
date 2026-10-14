-- ----------------------------------------------------
-- Dеоbfuѕсаtеԁ Ѕuссesѕfullу Ву LеаκD
-- https://discord.gg/AwGHNh7Z7T
-- ----------------------------------------------------

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
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

local function helperFunction1(parameter1, parameter2)
  local findFirstChild

  repeat
    findFirstChild = parameter1:FindFirstChild(parameter2)
    task.wait(0.2)
  until findFirstChild

  return findFirstChild
end

local localValue9 =
  helperFunction1(helperFunction1(localPlayer:WaitForChild("PlayerScripts"), "Modules"), "_UI")

local function helperFunction2()
  local getChildren = workspace.Environment.Foliage.Trees["Spruce Tree"]:GetChildren()
  local huge = math.huge
  local localValue10

  for index, value in ipairs(getChildren) do
    local body = value:FindFirstChild("Body")

    if body then
      local magnitude = (humanoidRootPart.Position - body.Position).Magnitude

      if magnitude < huge then
        huge = magnitude
        localValue10 = value
      end
    end
  end

  return localValue10
end

local function helperFunction3(parameter3)
  if not parameter3 then
    return
  else
    local body2 = parameter3:FindFirstChild("Body")

    if not body2 then
      warn("[AutoFarmTree] Body not found in tree:", parameter3.Name)
      return
    end

    humanoid:MoveTo(body2.Position + (humanoidRootPart.Position - body2.Position).Unit * 3)
    humanoid.MoveToFinished:Wait()

    return
  end
end

local hotbarUI = require(localValue9:WaitForChild("HUDHandler")).HotbarUI
local localValue11 = false
local localValue12 = {}
local connect

local function helperFunction4()
  if connect then
    return
  end

  connect = runService.Stepped:Connect(function()
    if character and localValue11 then
      for index2, value2 in ipairs(character:GetDescendants()) do
        if value2:IsA("BasePart") then
          value2.CanCollide = false
        end
      end
    end
  end)
end

local function helperFunction5(parameter4, parameter5)
  local localValue13 = parameter5 or 7
  local equipData = hotbarUI.EquipData

  if not (equipData and type(equipData.Function) == "function") then
    warn("[AutoFarmTree] Invalid EquipData!")
    return
  else
    local count = 0

    while count < localValue13 and localValue11 and parameter4.Parent do
      pcall(function()
        equipData.Function(parameter4)
      end)
      count = count + 1
      task.wait(0.5)
    end

    return
  end
end

local localValue14 = {}

local function helperFunction6()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

local helperFunction7

local function helperFunction8()
  if #localValue14 == 0 then
    localValue14 = helperFunction7(helperFunction2(), 4)
    print("[AutoFarmTree] Fixed tree list:", #localValue14, "trees")
  end

  while localValue11 do
    for index3, value3 in ipairs(localValue14) do
      if not localValue11 then
        return
      end

      print("[AutoFarmTree] Moving to:", value3.Name)
      helperFunction3(value3)
      print("[AutoFarmTree] Chopping ...")
      helperFunction5(value3, 7)
    end
  end
end

function helperFunction7(parameter6, parameter7)
  local localValue15 = parameter7 or 4

  if not parameter6 then
    return {}
  else
    local body3 = parameter6:FindFirstChild("Body")

    if not body3 then
      return {}
    else
      local spruceTree = workspace.Environment.Foliage.Trees["Spruce Tree"]
      local localValue16 = {}

      for index4, value4 in ipairs((spruceTree:GetChildren())) do
        if value4 ~= parameter6 then
          local body4 = value4:FindFirstChild("Body")

          if body4 then
            table.insert(localValue16, {
              Model = value4,
              Distance = (body3.Position - body4.Position).Magnitude,
            })
          end
        end
      end

      table.sort(localValue16, function(parameter8, parameter9)
        return parameter8.Distance < parameter9.Distance
      end)
      local localValue17 = { parameter6 }

      for i = 1, math.min(localValue15, #localValue16) do
        table.insert(localValue17, localValue16[i].Model)
      end

      return localValue17
    end
  end
end

function GoToWork(parameter10, name)
  local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter10 then
    return
  end

  if (humanoidRootPart2.Position - parameter10).Magnitude >= 250 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

function localValue12.startAutoFarm()
  if localValue11 then
    return
  end

  GoToWork(Vector3.new(3112.8400878906, 140.09596252441, -1833.5218505859), "LumberWoodcutter")
  localValue11 = true
  helperFunction4()
  task.spawn(helperFunction8)
  print("[Start] AutoFarmTree")
end

function localValue12.stopAutoFarm()
  localValue11 = false
  helperFunction6()
  print("[Stop] AutoFarmTree")
end

return localValue12
