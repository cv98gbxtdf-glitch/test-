--[[
    Dеоbfuѕсаteԁ Ԝіtһ LеаκD
    https://discord.gg/AwGHNh7Z7T
]]

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local pathfindingService = game:GetService("PathfindingService")

local localValue1 = getgenv()
localValue1.MikesMotorsFarm = getgenv().MikesMotorsFarm or {}

local mikesMotorsFarm = getgenv().MikesMotorsFarm

if mikesMotorsFarm.autoFarmRunning and type(mikesMotorsFarm.stopAutoFarm) == "function" then
  mikesMotorsFarm:stopAutoFarm()
  task.wait(0.5)
end

mikesMotorsFarm.autoFarmRunning = false
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local waitForChild = character:WaitForChild("Humanoid", 10)

localPlayer.CharacterAdded:Connect(function(character2)
  character = character2
  local localValue2, localValue3 = pcall(function()
    return character2:WaitForChild("Humanoid", 10)
  end)

  if localValue2 then
    waitForChild = localValue3
  end
end)

local dataService = replicatedStorage.Modules.DataService
local localValue4 = {}
local localValue5 =
  getconnections(({ data_manager = dataService }).data_manager.DescendantAdded)[1].Function
local localValue6 = getupvalue(localValue5, 1)
local localValue7 = next
local localValue8, localValue9 = getupvalue(getupvalue(localValue5, 2), 1)

for localValue10, localValue11 in localValue7, localValue8, localValue9 do
  local sub = localValue11:sub(1, 2) == "F_" and localValue11:sub(3) or localValue11
  localValue4[sub] = localValue6[localValue10]
end

local function helperFunction1(parameter1)
  local localValue12 = not waitForChild or not parameter1
  local bindableEvent, connect

  if localValue12 then
    return false
  else
    bindableEvent = Instance.new("BindableEvent")

    connect = nil

    connect = waitForChild.MoveToFinished:Connect(function(parameter2)
      if connect then
        connect:Disconnect()
      end

      bindableEvent:Fire(parameter2)
    end)

    waitForChild:MoveTo(parameter1)
    local localValue13, localValue14 = pcall(function()
      return bindableEvent.Event:Wait()
    end)
    task.wait(0.2)
    return localValue13 and localValue14
  end
end

local function helperFunction2()
  local localValue15, localValue16 = pcall(function()
    return workspace.Environment.Locations.City.MikesMotors.Interior
  end)

  return localValue15 and localValue16 or nil
end

local function helperFunction3()
  local localValue17, localValue18 = pcall(function()
    local localValue19 = helperFunction2()

    if not localValue19 then
      return {}
    end

    return {
      workstationsFolder = localValue19:FindFirstChild("MechanicWorkstations"),
      paintingEquipment = localValue19:FindFirstChild("PaintingEquipment"),
      tireRacks = localValue19:FindFirstChild("TireRacks"),
      oilCans = localValue19:FindFirstChild("OilCans"),
    }
  end)

  return localValue17 and localValue18 or {}
end

local function helperFunction4(parameter3, parameter4, parameter5) end

Vector3.new(-91, 6, 311)

local function helperFunction5(parameter6)
  pcall(function()
    local workstationsFolder = parameter6 and parameter6.workstationsFolder
      or helperFunction3().workstationsFolder

    if not workstationsFolder then
      return
    end

    for index, value in ipairs(workstationsFolder:GetChildren()) do
      local localValue20 = value

      local localValue21, localValue22 = pcall(function()
        return localValue20:FindFirstChild("Display")
          and localValue20.Display:FindFirstChild("Screen")
          and localValue20.Display.Screen:FindFirstChild("MechanicGUI")
          and localValue20.Display.Screen.MechanicGUI:FindFirstChild("Frame")
          and localValue20.Display.Screen.MechanicGUI.Frame:FindFirstChild("Done")
      end)

      if localValue21 and localValue22 then
        pcall(function()
          firesignal(localValue22.Activated)
        end)
      end
    end
  end)
end

local helperFunction6

local function helperFunction7(parameter7, parameter8)
  local localValue23, localValue24 = pcall(function()
    if not parameter7 then
      return nil
    else
      local base = parameter7:FindFirstChild("Lift") and parameter7.Lift:FindFirstChild("Base")

      if not base then
        return nil
      else
        local localValue25 = parameter8 or helperFunction6()

        if not localValue25 then
          return nil
        end

        for index2, value2 in ipairs(localValue25:GetChildren()) do
          if value2.Name == "MikesMotorsCustomer" and value2.PrimaryPart then
            if (value2.PrimaryPart.Position - base.Position).Magnitude < 6 then
              return value2
            end
          end
        end

        return nil
      end
    end
  end)

  return localValue23 and localValue24 or nil
end

function helperFunction6()
  local localValue26, localValue27 = pcall(function()
    return workspace:WaitForChild("_game", 5):FindFirstChild("SpawnedCharacters")
  end)

  return localValue26 and localValue27 or nil
end

local function helperFunction8(parameter9)
  local localValue28, localValue29 = pcall(function()
    local workstationsFolder2 = parameter9 and parameter9.workstationsFolder
      or helperFunction3().workstationsFolder
    local localValue30 = not workstationsFolder2 or not character or not character.PrimaryPart
    local localValue31

    if localValue30 then
      return nil
    else
      local huge = math.huge
      localValue31 = nil
      local localValue32 = huge
      local position = character.PrimaryPart.Position

      for index3, value3 in ipairs(workstationsFolder2:GetChildren()) do
        local inUse = value3:FindFirstChild("InUse")

        if inUse and not inUse.Value then
          local lift = value3:FindFirstChild("Lift")

          local base2 = lift
          base2 = lift and value3.Lift:FindFirstChild("Base")

          if base2 then
            local magnitude = (base2.Position - position).Magnitude

            if magnitude < localValue32 then
              localValue32 = magnitude
              localValue31 = value3
            end
          end
        end
      end

      if localValue31 then
        pcall(function()
          helperFunction1(localValue31.Lift.Base.Position)
        end)
        helperFunction5(parameter9)
        return localValue31
      end

      return nil
    end
  end)

  return localValue28 and localValue29 or nil
end

local function helperFunction9(parameter10)
  local workstationsFolder3 = parameter10 and parameter10.workstationsFolder
    or helperFunction3().workstationsFolder

  if not workstationsFolder3 then
    return nil, nil
  else
    local name = localPlayer.Name
    local localValue33 = helperFunction6()
    local localValue34 = nil
    local localValue35 = nil

    for index4, value4 in ipairs((workstationsFolder3:GetChildren())) do
      local inUse2 = value4:FindFirstChild("InUse")
      local owner = value4:FindFirstChild("Owner")
      local value5 = inUse2
      local localValue36 = helperFunction7(value4, localValue33)

      if inUse2 then
        value5 = inUse2.Value and owner and owner.Value == name
      end

      if value5 then
        if localValue36 and localValue36:FindFirstChild("Order") then
          return value4, localValue36
        end

        localValue34 = value4
      else
        if localValue36 and (not owner or owner.Value == nil or owner.Value == "") then
          return value4, localValue36
        end

        if not inUse2 or not inUse2.Value then
          localValue35 = localValue35 or value4
        end
      end
    end

    return localValue34 or localValue35, nil
  end
end

function GoToWork(parameter11, name2)
  local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter11 then
    return
  end

  if (humanoidRootPart.Position - parameter11).Magnitude >= 40 then
    localValue4.ToWork:InvokeServer({ Name = name2 })
  end
end

function mikesMotorsFarm.startAutoFarm(parameter12)
  if parameter12.autoFarmRunning then
    return
  end

  GoToWork(Vector3.new(288.15368652344, 4.337251663208, -291.28720092773), "MikesMechanic")
  parameter12.autoFarmRunning = true
  print("[MikesMotors] AutoFarm started")

  task.spawn(function()
    while parameter12.autoFarmRunning do
      if
        not pcall(function()
          local localValue37 = helperFunction3()
          local localValue38

          if not localValue37.workstationsFolder then
            task.wait(0.5)
            return
          else
            local localValue39
            localValue38, localValue39 = helperFunction9(localValue37)

            if localValue38 then
              if localValue39 then
                helperFunction4(localValue39, localValue38, localValue37)
                task.wait(3)
                helperFunction5(localValue37)
                task.wait(2)
                helperFunction5(localValue37)
              else
                pcall(function()
                  helperFunction1(localValue38.Lift.Base.Position)
                end)
                task.wait(1)
              end
            else
              helperFunction8(localValue37)
            end

            return
          end
        end)
      then
        task.wait(0.6)
      end

      task.wait(1.5)
    end

    print("[MikesMotors] AutoFarm stopped.")
  end)
end

function mikesMotorsFarm:stopAutoFarm()
  self.autoFarmRunning = false
end

return mikesMotorsFarm
