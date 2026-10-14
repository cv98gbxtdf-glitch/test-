-- Ѕоurсе Соdе Dеоbfuѕсatеԁ Ву LеаκD
-- https://discord.gg/AwGHNh7Z7T

local workspaceService = game:GetService("Workspace")
local pathfindingService = game:GetService("PathfindingService")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualInputManager = game:GetService("VirtualInputManager")
local localValue1 = {}
local dataService = replicatedStorage.Modules.DataService
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local localValue2 = getconnections(dataService.DescendantAdded)[1].Function
getupvalue(localValue2, 1)
local localValue3 = next
local localValue4, localValue5 = getupvalue(getupvalue(localValue2, 2), 1)

for localValue6, localValue7 in localValue3, localValue4, localValue5 do
  localValue23 = localValue7:sub(1, 2) == "F_" and localValue7:sub(3)
end

local function helperFunction1(parameter1, parameter2)
  local findFirstChild

  repeat
    findFirstChild = parameter1:FindFirstChild(parameter2)
    task.wait(0.2)
  until findFirstChild

  return findFirstChild
end

require(
  helperFunction1(helperFunction1(localPlayer:WaitForChild("PlayerScripts"), "Modules"), "_UI"):WaitForChild(
    "HUDHandler"
  )
)

local function helperFunction2()
  local npcOrigins = workspaceService._game.WinterActivityArea.NPCOrigins

  if not npcOrigins then
    return nil
  else
    local localValue8 = nil
    local huge = math.huge

    for index, value in ipairs(npcOrigins:GetChildren()) do
      if value:IsA("BasePart") then
        local magnitude = (humanoidRootPart.Position - value.Position).Magnitude

        if magnitude < huge then
          localValue8 = value
          huge = magnitude
        end
      end
    end

    return localValue8
  end
end

local helperFunction3

local function helperFunction4()
  local snowballPileOrigins = workspaceService._game.WinterActivityArea.SnowballPileOrigins

  if not snowballPileOrigins then
    return nil
  else
    local localValue9 = nil
    local huge2 = math.huge

    for index2, value2 in ipairs(snowballPileOrigins:GetChildren()) do
      local snowballPile = value2:FindFirstChild("SnowballPile")

      if snowballPile then
        local localValue10 = helperFunction3(snowballPile)

        if localValue10 then
          local magnitude2 = (humanoidRootPart.Position - localValue10.Position).Magnitude

          if magnitude2 < huge2 then
            localValue9 = snowballPile
            huge2 = magnitude2
          end
        end
      end
    end

    return localValue9
  end
end

local function helperFunction5(parameter3, parameter4)
  local localValue11 = helperFunction3(parameter3)

  if not localValue11 then
    return false
  else
    local localValue12, localValue13 = pcall(function()
      setthreadidentity(2)

      require(localPlayer.PlayerScripts.Modules.InteractionHandler):ShowMenu(
        parameter3,
        localValue11.Position,
        localValue11
      )

      setthreadidentity(7)
      local interactUI = localPlayer.PlayerGui:FindFirstChild("_interactUI")

      if not interactUI then
        return false
      else
        local center = interactUI:FindFirstChild("Center")

        if not center then
          return false
        else
          local localValue14 = tick()
          tick()

          repeat
            for index3, value3 in ipairs(center:GetChildren()) do
              if value3:IsA("TextButton") and value3.Visible then
                if value3.Text == parameter4 then
                  firesignal(value3.Activated)
                  firesignal(value3.MouseButton1Click)
                  return true
                end
              end

              local textLabel = value3:FindFirstChild("TextLabel")

              if textLabel and textLabel.Text == parameter4 then
                firesignal(value3.Activated)
                firesignal(value3.MouseButton1Click)
                return true
              end
            end

            task.wait(0.1)
          until tick() - localValue14 > 5

          return false
        end
      end
    end)

    if not localValue12 then
      warn("[quickInteract] ERROR:", localValue13)
    end

    return localValue13
  end
end

function helperFunction3_1(parameter5)
  if not parameter5 then
    return nil
  elseif parameter5:IsA("Model") then
    return parameter5.PrimaryPart or parameter5:FindFirstChildWhichIsA("BasePart")
  else
    if parameter5:IsA("BasePart") then
      return parameter5
    end

    return
  end
end

local function helperFunction6(parameter6)
  local position = humanoidRootPart.Position
  local vector = Vector3.new(parameter6.X, position.Y, parameter6.Z)
  humanoidRootPart.CFrame = CFrame.lookAt(position, vector)
end

local function helperFunction7(parameter7)
  local path = pathfindingService:CreatePath({ AgentCanJump = false })
  path:ComputeAsync(humanoidRootPart.Position, parameter7)

  for index4, value4 in ipairs((path:GetWaypoints())) do
    humanoid:MoveTo(value4.Position)
    humanoid.MoveToFinished:Wait()
  end
end

local localValue15 = false

function localValue1.startSnowBall()
  if localValue15 then
    return
  end

  localValue15 = true

  task.spawn(function()
    while localValue15 do
      local localValue16 = helperFunction4()

      if not localValue16 then
        task.wait(1)
      else
        helperFunction7(helperFunction3_1(localValue16).Position)
        helperFunction5(localValue16, "Take")
        task.wait(0.4)
        local localValue17 = helperFunction2()

        if localValue17 then
          helperFunction6(localValue17.Position)
          task.wait(0.2)
        end

        task.wait(0.5)
      end
    end
  end)
end

function localValue1.stopSnowBall()
  localValue15 = false
end

return localValue1
