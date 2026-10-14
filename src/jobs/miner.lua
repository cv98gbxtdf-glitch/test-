-- ----------------------------------------------------
-- Оrіgіnаl Cоԁе Dеоbfuѕсаtеԁ Ву LеaκD
-- https://discord.gg/AwGHNh7Z7T
-- ----------------------------------------------------

local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
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
  local localValue9, localValue10 = pcall(function()
    return parameter1:WaitForChild(parameter2, 5)
  end)
  return localValue9 and localValue10 or nil
end

local localValue11 = helperFunction1(localPlayer:WaitForChild("PlayerScripts"), "Modules")
local localValue12 = localValue11 and require(helperFunction1(localValue11, "InteractionHandler"))
  or nil
local localValue13 = {}
local localValue14 = false

local function helperFunction2(parameter3, parameter4)
  local localValue15, localValue16 = pcall(function()
    local primaryPart = parameter3.PrimaryPart or parameter3:FindFirstChildWhichIsA("BasePart")

    if not primaryPart then
      return false
    else
      setthreadidentity(2)
      localValue12:ShowMenu(parameter3, primaryPart.Position, primaryPart)
      setthreadidentity(7)
      local interactUI = localPlayer.PlayerGui:FindFirstChild("_interactUI")

      if not interactUI then
        return false
      end

      for key, value in pairs(interactUI:GetChildren()) do
        local button = value:FindFirstChild("Button")

        if button and button:FindFirstChild("TextLabel") then
          if button.TextLabel.Text == parameter4 then
            firesignal(button.Activated)
            task.wait(0.2)
            return true
          end
        end
      end

      return false
    end
  end)

  return localValue15 and localValue16
end

local localValue17 = {}
local localValue18 = 0
local helperFunction3

local function helperFunction4(parameter5)
  if os.clock() - localValue18 > 5 then
    localValue17 = helperFunction3(parameter5, {})
    localValue18 = os.clock()
  end

  return localValue17
end

local connect

local function helperFunction5()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

function helperFunction3(parameter6, parameter7)
  local localValue19 = parameter7 or {}

  for index, value2 in ipairs(parameter6:GetChildren()) do
    if value2:IsA("Model") and value2:FindFirstChild("B") then
      local localValue20 = false

      for index2, value3 in ipairs(value2.B:GetChildren()) do
        if value3:IsA("Decal") and value3.Texture == "rbxassetid://2605891245" then
          localValue20 = true
          break
        end
      end

      if not localValue20 then
        table.insert(
          localValue19,
          { Model = value2, Part = value2.B, Position = value2.B.Position }
        )
      end
    elseif value2:IsA("Folder") or value2:IsA("Model") then
      helperFunction3(value2, localValue19)
    end
  end

  return localValue19
end

local function helperFunction6()
  if connect then
    return
  end

  connect = runService.Stepped:Connect(function()
    if character and localValue14 then
      for index3, value4 in ipairs(character:GetDescendants()) do
        if value4:IsA("BasePart") and value4.CanCollide then
          value4.CanCollide = false
        end
      end
    end
  end)
end

local helperFunction7

local function helperFunction8()
  while localValue14 do
    local localValue21 = workspace:FindFirstChild("_game")
    local folder = localValue21 and localValue21:FindFirstChild("Folder")

    if folder then
      local localValue22 = helperFunction4(folder)

      table.sort(localValue22, function(parameter8, parameter9)
        return (parameter8.Position - humanoidRootPart.Position).Magnitude
          < (parameter9.Position - humanoidRootPart.Position).Magnitude
      end)

      for index4, value5 in ipairs(localValue22) do
        if not localValue14 then
          return
        end

        helperFunction7(value5)
      end
    else
      task.wait(1)
    end
  end
end

function helperFunction7(parameter10)
  if not parameter10 or not parameter10.Part then
    return
  else
    local y = parameter10.Part.Size.Y
    local position = parameter10.Position
    local vector = Vector3.new(0, y / 2 + 3, 0)
    humanoidRootPart.CanCollide = false

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
      { CFrame = CFrame.new(position + vector) }
    )

    create:Play()
    create.Completed:Wait()

    helperFunction2(parameter10.Model, "Mine")
    task.wait(5.5)
    return
  end
end

function GoToWork(parameter11, name)
  local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter11 then
    return
  end

  if (humanoidRootPart2.Position - parameter11).Magnitude >= 100 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

function localValue13.startAutoFarm()
  if localValue14 then
    return
  end

  GoToWork(Vector3.new(2130.0612792969, 133.34585571289, -2453.1655273438), "CaveMiner")
  localValue14 = true
  helperFunction6()
  task.spawn(helperFunction8)
  print("[Start] AutoFarmOre")
end

function localValue13.stopAutoFarm()
  localValue14 = false
  helperFunction5()
  print("[Stop] AutoFarmOre")
end

return localValue13
