--[[
    Тһіѕ Ѕсriрt Ԝаѕ Dеоbfuѕсаtеԁ Ву LeakD
    https://discord.gg/AwGHNh7Z7T
]]

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local pathfindingService = game:GetService("PathfindingService")
local localPlayer = players.LocalPlayer
local mainGUI = localPlayer:WaitForChild("PlayerGui").MainGUI
local modules = localPlayer:WaitForChild("PlayerScripts").Modules
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
require(localPlayer.PlayerScripts.Modules.JobHandler.PizzaPlanetDelivery)
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

local localValue9 = {
  dataService = require(replicatedStorage.Modules.DataService),
  PizzaPlanetDelivery = require(modules.JobHandler.PizzaPlanetDelivery),
}

local localValue10 = debug.getupvalue(localValue9.dataService.FireServer, 5)
local localValue11 = false
local localValue12 = {}

function fireServer(parameter1)
  local localValue13 = table.clone(parameter1)
  local localValue14 = localValue10(localValue13.Type)

  if not localValue14 then
    return
  end

  localValue13.Type = nil
  return localValue14:FireServer(localValue13)
end

function invokeServer(parameter2)
  local localValue15 = table.clone(parameter2)
  local localValue16 = localValue10(localValue15.Type, true)

  if not localValue16 then
    return
  end

  localValue15.Type = nil
  return localValue16:InvokeServer(localValue15)
end

function GoToWork(parameter3, name)
  local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter3 then
    return
  end

  if (humanoidRootPart.Position - parameter3).Magnitude >= 100 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

local function helperFunction1(parameter4, parameter5)
  local localValue17 = not parameter4 or not localValue11
  local localValue18, teleportFloor, connect

  if localValue17 then
    return
  else
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character, parameter4.Parent }

    local raycast = workspace:Raycast(
      parameter4.Position + Vector3.new(0, 50, 0),
      Vector3.new(0, -100, 0),
      raycastParams
    )

    local localValue19 = (raycast and raycast.Position.Y or parameter4.Position.Y) - 220
    localValue18 = localValue19 - 4

    teleportFloor = Instance.new("Part")
    teleportFloor.Name = "TeleportFloor"
    teleportFloor.Size = Vector3.new(25, 2, 25)
    teleportFloor.Anchored = true
    teleportFloor.CanCollide = true
    teleportFloor.Transparency = 0.5
    teleportFloor.Parent = workspace

    parameter4.CFrame = CFrame.new(parameter4.Position.X, localValue19, parameter4.Position.Z)

    connect = nil

    connect = runService.Heartbeat:Connect(function()
      if teleportFloor and parameter4 and teleportFloor.Parent then
        teleportFloor.CFrame =
          CFrame.new(parameter4.Position.X, localValue18, parameter4.Position.Z)
      elseif connect then
        connect:Disconnect()
      end
    end)

    local vector = Vector2.new(parameter4.Position.X, parameter4.Position.Z)
    local vector2 = Vector2.new(parameter5.X, parameter5.Z)

    local create = tweenService:Create(
      parameter4,
      TweenInfo.new(
        (vector - vector2).Magnitude / 45,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut
      ),
      { CFrame = CFrame.new(parameter5.X, localValue19, parameter5.Z) }
    )

    create:Play()
    create.Completed:Wait()

    if connect then
      connect:Disconnect()
    end

    if teleportFloor then
      teleportFloor:Destroy()
    end

    if localValue11 then
      local raycast2 = workspace:Raycast(
        Vector3.new(parameter5.X, parameter5.Y + 50, parameter5.Z),
        Vector3.new(0, -100, 0),
        raycastParams
      )

      local y = raycast2 and raycast2.Position.Y or parameter5.Y
      parameter4.CFrame = CFrame.new(parameter5.X, y + 5, parameter5.Z)
      task.wait(0.2)
    end

    return
  end
end

function localValue9.PizzaPlanetDelivery.ShiftLoop()
  return task.wait(9000000000)
end

function getCustomerModel(parameter6)
  local localValue20 = tick()

  while localValue11 do
    local localValue21 = nil

    local spawnedCharacters = workspace:FindFirstChild("_game")
      and workspace._game:FindFirstChild("SpawnedCharacters")

    if spawnedCharacters then
      for index, value in ipairs(spawnedCharacters:GetChildren()) do
        if
          value.Name == "PizzaPlanetDeliveryCustomer"
          and value:GetAttribute("_customerPosition") == parameter6
        then
          localValue21 = value
          break
        end
      end
    end

    if not localValue21 then
      task.wait(0.2)
    end

    if tick() - localValue20 > 10 then
      warn("Could not find customer with ID: " .. tostring(parameter6))
      return localValue21
    elseif localValue21 ~= nil then
      return localValue21
    end
  end

  return nil
end

function pathfind(parameter7, parameter8)
  local getControls = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
  getControls:Disable()

  local character2 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart2 = character2:WaitForChild("HumanoidRootPart")
  local humanoid = character2:WaitForChild("Humanoid")
  local path

  if type(parameter8) == "table" then
    path = pathfindingService:CreatePath(parameter8)
  else
    path = pathfindingService:CreatePath()
  end

  pcall(function()
    path:ComputeAsync(humanoidRootPart2.Position, parameter7)
  end)

  if path.Status == Enum.PathStatus.Success then
    local localValue22 = next
    local localValue23, localValue24 = path:GetWaypoints()

    for localValue25, localValue26 in localValue22, localValue23, localValue24 do
      if not localValue11 then
        break
      end

      humanoid:MoveTo(localValue26.Position)

      if localValue26.Action == Enum.PathWaypointAction.Jump then
        humanoid.Jump = true
      end

      humanoid.MoveToFinished:Wait()
    end
  end

  getControls:Enable()
end

local function helperFunction2()
  local movingBoxes, localValue27, localValue28, localValue29, localValue30, position, vehicleDeliveryMoped, localValue31, body, localValue32

  while localValue11 do
    task.wait()
    movingBoxes = workspace.Environment.Locations.City.PizzaPlanet.Interior.Conveyor.MovingBoxes
    pathfind(Vector3.new(-51.36, 5.81, -41.86))
    localValue27 = nil

    local tookBox = false
    while localValue11 and not tookBox do
      for index2, value2 in ipairs((movingBoxes:GetChildren())) do
        localValue29, localValue28 = invokeServer({ Type = "TakePizzaBox", Box = value2 })

        if localValue28 then
          localValue27 = localValue28
          break
        end
      end

      task.wait(0.2)

      if localValue27 or not localValue11 then
        tookBox = true
      end
    end

    if not localValue11 then
      return
    end

    if localValue27 then
      localValue30 = getCustomerModel(localValue27)

      if localValue30 then
        position = localValue30.PrimaryPart.Position
        pathfind(Vector3.new(-62.28, 5.86, -32.71))

        repeat
          invokeServer({ Type = "UsePizzaMoped" })
          vehicleDeliveryMoped = character:FindFirstChild("Vehicle_Delivery Moped")
          task.wait(0.1)
          localValue31 = vehicleDeliveryMoped or not localValue11
        until localValue31

        body = vehicleDeliveryMoped and vehicleDeliveryMoped:FindFirstChild("Body")

        if body then
          helperFunction1(body, position)
          task.wait(0.5)

          repeat
            fireServer({ Type = "DeliverPizza", Customer = localValue30 })
            task.wait(0.2)
            localValue32 = not character:FindFirstChild("Pizza Box") or not localValue11
          until localValue32

          helperFunction1(body, Vector3.new(-62.28, 6.86, -32.71))
          task.wait(2)
          fireServer({ Type = "Detach" })
        end
      end
    end
  end
end

local function helperFunction3()
  local environment = workspace:FindFirstChild("Environment")

  if environment then
    local detailObjects = environment:FindFirstChild("DetailObjects")

    if detailObjects then
      detailObjects:Destroy()
    end

    local locations = environment:FindFirstChild("Locations")
    local city = locations and locations:FindFirstChild("City")

    if city then
      local winterMarket = city:FindFirstChild("WinterMarket")
      local roadBarriers = city:FindFirstChild("RoadBarriers")
      local winterEventLeaderboards = city:FindFirstChild("WinterEventLeaderboards")

      if roadBarriers then
        roadBarriers:Destroy()
      end

      if winterMarket then
        winterMarket:Destroy()
      end

      if winterEventLeaderboards then
        winterEventLeaderboards:Destroy()
      end

      for index3, value3 in ipairs(city:GetChildren()) do
        if
          string.match(value3.Name, "^ObjectStand_")
          or string.match(value3.Name, "^WinterEvent_")
        then
          value3:Destroy()
        end
      end
    end
  else
    warn("Environment Folder Null")
  end
end

function localValue12.startAutoFarm()
  if localValue11 then
    warn("AutoFarm is already running!")
    return
  end

  GoToWork(Vector3.new(-65.008415222168, 4.6987490653992, -46.85071182251), "PizzaPlanetDelivery")

  localValue11 = true
  print("Starting Pizza AutoFarm")
  helperFunction3()
  task.spawn(helperFunction2)
end

function localValue12.stopAutoFarm()
  if not localValue11 then
    return
  end

  print("Stopping Pizza AutoFarm...")
  localValue11 = false

  if localPlayer.Character then
    local vehicleDeliveryMoped2 = localPlayer.Character:FindFirstChild("Vehicle_Delivery Moped")

    if vehicleDeliveryMoped2 and vehicleDeliveryMoped2:FindFirstChild("Body") then
      vehicleDeliveryMoped2.Body.AssemblyLinearVelocity = Vector3.zero
    end
  end
end

return localValue12
