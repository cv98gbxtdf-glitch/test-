-- Dеоbfuѕcаtеd Ԝіtһ LеаκD
-- https://discord.gg/AwGHNh7Z7T

local workspaceService = game:GetService("Workspace")
local pathfindingService = game:GetService("PathfindingService")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local localValue1 = {}
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local function helperFunction1(parameter1, parameter2)
  if not parameter1 then
    return
  else
    local localValue2 = parameter1 + (parameter2 or Vector3.new(0, 2, -4))
    local magnitude = (humanoidRootPart.Position - localValue2).Magnitude
    local localValue3 = math.clamp(magnitude / 23, 0.3, 4)
    local cframe = humanoidRootPart.CFrame
    local cframe2 = CFrame.new(localValue2, localValue2 + cframe.LookVector)
    local canCollide = humanoidRootPart.CanCollide
    humanoidRootPart.CanCollide = false

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(localValue3, Enum.EasingStyle.Linear),
      { CFrame = cframe2 }
    )

    create:Play()
    create.Completed:Wait()

    humanoidRootPart.CanCollide = canCollide
    return
  end
end

local function helperFunction2(parameter3)
  if not parameter3 then
    return nil
  elseif parameter3:IsA("Model") then
    return parameter3.PrimaryPart or parameter3:FindFirstChildWhichIsA("BasePart")
  else
    if parameter3:IsA("BasePart") then
      return parameter3
    end

    return
  end
end

local localValue4 = false

local function helperFunction3(parameter4, parameter5)
  local localValue5 = helperFunction2(parameter4)

  if not localValue5 then
    return false
  else
    local localValue6, localValue7 = pcall(function()
      setthreadidentity(2)

      require(localPlayer.PlayerScripts.Modules.InteractionHandler):ShowMenu(
        parameter4,
        localValue5.Position,
        localValue5
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
          local localValue8 = tick()
          tick()

          repeat
            for index, value in ipairs(center:GetChildren()) do
              if not localValue4 then
                return false
              end

              if value:IsA("TextButton") and value.Visible and value.Text == parameter5 then
                firesignal(value.Activated)
                firesignal(value.MouseButton1Click)
                return true
              else
                local textLabel = value:FindFirstChild("TextLabel")

                if textLabel and textLabel.Text == parameter5 then
                  firesignal(value.Activated)
                  firesignal(value.MouseButton1Click)
                  return true
                end
              end
            end

            task.wait(0.1)
          until tick() - localValue8 > 5

          return false
        end
      end
    end)

    if not localValue6 then
      warn("[quickInteract ERROR]:", localValue7)
    end

    return localValue7
  end
end

local function helperFunction4()
  local blockOrigins = workspaceService._game.WinterActivityArea.BlockOrigins
  local localValue9 = {}

  for index2, value2 in ipairs(blockOrigins:GetChildren()) do
    local iceBlock = value2:FindFirstChild("IceBlock")

    if iceBlock then
      local localValue10 = helperFunction2(iceBlock)

      if localValue10 then
        table.insert(localValue9, {
          obj = iceBlock,
          dist = (humanoidRootPart.Position - localValue10.Position).Magnitude,
        })
      end
    end
  end

  table.sort(localValue9, function(parameter6, parameter7)
    return parameter6.dist < parameter7.dist
  end)
  local localValue11 = {}

  for i = 1, 3 do
    if localValue9[i] then
      table.insert(localValue11, localValue9[i].obj)
    end
  end

  return localValue11
end

local function helperFunction5(parameter8, parameter9)
  local localValue12 = parameter9 or 5
  local count = 0

  while count < 20 do
    count = count + 1
    local localValue13 = parameter8 - humanoidRootPart.Position

    if localValue13.Magnitude < 1 then
      return true
    else
      local localValue14 = parameter8 - localValue13.Unit * localValue12

      local path = pathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
        AgentCanClimb = false,
        WaypointSpacing = 2,
      })

      if
        not pcall(function()
          path:ComputeAsync(humanoidRootPart.Position, localValue14)
        end) or path.Status ~= Enum.PathStatus.Success
      then
        warn(("[goTo] Path failed on attempt %d: %s"):format(count, tostring(path.Status)))
        task.wait(0.3)
      else
        local localValue15 = true

        for index3, value3 in ipairs(path:GetWaypoints()) do
          if not localValue4 then
            return false
          end

          if value3.Action == Enum.PathWaypointAction.Jump then
            humanoid.Jump = true
            task.wait(0.15)
          end

          humanoid:MoveTo(value3.Position)

          if not humanoid.MoveToFinished:Wait() then
            if helperFunction1 then
              helperFunction1(value3.Position)
              task.wait(0.1)
            else
              localValue15 = false
              break
            end
          end
        end

        if localValue15 then
          return true
        end

        warn(("[goTo] Retry due to stuck humanoid, attempt %d"):format(count))
        task.wait(0.2)
      end
    end
  end

  warn("[goTo] Failed after maximum retries")
  return false
end

local localValue16

function localValue1.startArcticArt()
  if localValue4 then
    return
  end

  localValue4 = true

  task.spawn(function()
    while localValue4 do
      for index4, value4 in ipairs(localValue16 or helperFunction4()) do
        if not localValue4 then
          break
        else
          local localValue17 = helperFunction2(value4)

          if localValue17 then
            helperFunction5(localValue17.Position, 5)

            for j = 1, 4 do
              if not localValue4 then
                break
              end

              helperFunction3(value4, "Sculpt")
              task.wait(0.5)
            end
          end

          task.wait(2)
        end
      end
    end
  end)
end

function localValue1.stopArcticArt()
  localValue4 = false
  localValue16 = nil
end

return localValue1
