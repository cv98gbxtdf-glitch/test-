-- [ LeakD ] Fіlе Deоbfuѕсаtеԁ Uѕіng LеаκD
-- [ Source ] https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local pathfindingService = game:GetService("PathfindingService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
  "HumanoidRootPart"
)
local dataService = replicatedStorage.Modules.DataService
local localValue1 = {}
local localValue2 =
  getconnections(({ data_manager = dataService }).data_manager.DescendantAdded)[1].Function
local localValue3 = getupvalue(localValue2, 1)
local localValue4 = next
local localValue5, localValue6 = getupvalue(getupvalue(localValue2, 2), 1)

for localValue7, localValue8 in localValue4, localValue5, localValue6 do
  local sub = localValue8:sub(1, 2) == "F_" and localValue8:sub(3) or localValue8
  localValue1[sub] = localValue3[localValue7]
end

local function helperFunction1(parameter1)
  if parameter1:IsA("Model") then
    return parameter1.PrimaryPart or parameter1:FindFirstChildWhichIsA("BasePart")
  end

  if parameter1:IsA("BasePart") then
    return parameter1
  end
end

local function helperFunction2()
  for index, value in
    ipairs(
      workspace.Environment.Locations.City.PizzaPlanet.Interior.BakerWorkstations:GetChildren()
    )
  do
    local inUse = value:FindFirstChild("InUse")

    if inUse and inUse.Value == localPlayer then
      return value
    end
  end

  return nil
end

local function helperFunction3(parameter2)
  local character = localPlayer.Character
  local humanoidRootPart2, path

  if not character then
    return
  else
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

    local getControls =
      require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
    getControls:Disable()

    path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentCanJump = true,
      WaypointSpacing = 4,
    })

    local localValue9, localValue10 = pcall(function()
      path:ComputeAsync(humanoidRootPart2.Position, parameter2)
    end)

    if localValue9 and path.Status == Enum.PathStatus.Success then
      for index2, value2 in ipairs((path:GetWaypoints())) do
        humanoid:MoveTo(value2.Position)

        if value2.Action == Enum.PathWaypointAction.Jump then
          humanoid.Jump = true
        end

        if not humanoid.MoveToFinished:Wait(5) then
          humanoid.Jump = true
          break
        end
      end
    else
      print("[Pathfind] Error: Cannot find path, going straight!")
      humanoid:MoveTo(parameter2)
      humanoid.MoveToFinished:Wait(2)
    end

    getControls:Enable()
    return
  end
end

local function helperFunction4()
  local localValue11 = helperFunction2()

  if localValue11 then
    return localValue11
  end

  for index3, value3 in
    ipairs(
      workspace.Environment.Locations.City.PizzaPlanet.Interior.BakerWorkstations:GetChildren()
    )
  do
    local inUse2 = value3:FindFirstChild("InUse")

    if inUse2 and not inUse2.Value then
      helperFunction3(helperFunction1(value3).Position)
      localValue1.UseWorkstation:FireServer({ Type = "UseWorkstation", Workstation = value3 })
      task.wait(0.5)
      return value3
    end
  end

  return nil
end

local helperFunction5

local function helperFunction6()
  local localValue12 = helperFunction5()

  if localValue12 then
    local localValue13 = helperFunction1(localValue12)
    helperFunction3((localValue13.CFrame * CFrame.new(0, 0, 3)).Position)

    if (humanoidRootPart.Position - localValue13.Position).Magnitude < 7 then
      task.wait(0.2)
      localValue1.TakeIngredientCrate:FireServer({ Object = localValue12 })
      task.wait(0.5)
    end
  end
end

function helperFunction5()
  local getChildren =
    workspace.Environment.Locations.City.PizzaPlanet.Interior.IngredientCrates:GetChildren()
  local huge = math.huge
  local localValue14

  for index4, value4 in ipairs(getChildren) do
    local localValue15 = helperFunction1(value4)

    if localValue15 then
      local magnitude = (humanoidRootPart.Position - localValue15.Position).Magnitude

      if magnitude < huge then
        localValue14 = value4
        huge = magnitude
      end
    end
  end

  return localValue14
end

local function helperFunction7(parameter3)
  local order = parameter3:FindFirstChild("Order")
  local ingredientsLeft = order and order:FindFirstChild("IngredientsLeft")

  if ingredientsLeft and ingredientsLeft.Value < 1 then
    helperFunction6()
    local localValue16 = helperFunction1(parameter3)
    local cframe = CFrame.new(0, 0, 3)
    print("Returning...")
    helperFunction3((localValue16.CFrame * cframe).Position)

    if (humanoidRootPart.Position - localValue16.Position).Magnitude < 7 then
      task.wait(0.3)
      localValue1.RestockIngredients:FireServer({
        Type = "RestockIngredients",
        Workstation = parameter3,
      })
      task.wait(0.3)
      return true
    end

    return false
  end

  return false
end

local localValue17 = false

local function helperFunction8()
  local localValue18

  while localValue17 do
    local localValue19 = helperFunction2() or helperFunction4()

    if localValue19 then
      if helperFunction7(localValue19) then
        task.wait(1)
      end

      local localValue20 = helperFunction1(localValue19)

      if (humanoidRootPart.Position - localValue20.Position).Magnitude > 5 then
        helperFunction3(localValue20.Position)
      end

      local order2 = localValue19:FindFirstChild("Order")

      if order2 and order2.Value ~= "" then
        local localValue21 = tostring(order2.Value)

        if localValue21 == "Cheese" then
          localValue18 = false
        else
          localValue18 = localValue21 == "Vegetables" and "Vegetable" or localValue21
        end

        localValue1.JobCompleted:FireServer({
          Workstation = localValue19,
          Order = { true, true, true, localValue18 },
        })
      end

      count = 1
    end

    task.wait(5)
  end
end

function GoToWork(parameter4, name)
  local humanoidRootPart3 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter4 then
    return
  end

  if (humanoidRootPart3.Position - parameter4).Magnitude >= 50 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

local localValue22 = {}

function localValue22.startAutoFarm()
  if localValue17 then
    return
  end

  GoToWork(Vector3.new(-35.434257507324, 4.6987471580505, -68.925834655762), "PizzaPlanetBaker")
  localValue17 = true
  task.spawn(helperFunction8)
  print("[AutoPizzaBaker] AutoFarm Started")
end

function localValue22.stopAutoFarm()
  localValue17 = false
  print("[AutoPizzaBaker] AutoFarm Stopped")
end

return localValue22
