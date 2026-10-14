return function(ctx)
  -- ----------------------------------------------------
  -- Luа Ѕсrірt Deоbfuѕсateԁ Ву LеaκD
  -- https://discord.gg/AwGHNh7Z7T
  -- ----------------------------------------------------

  local workspaceService = game:GetService("Workspace")
  local pathfindingService = game:GetService("PathfindingService")
  local players = game:GetService("Players")
  local localValue1 = false
  local localValue2 = {}
  local localPlayer = players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

  local function helperFunction1(parameter1)
    local bag = parameter1:FindFirstChild("Bag")

    if bag and bag:FindFirstChild("Main") then
      local localValue3 = bag.Main:GetChildren()[2]

      if localValue3 then
        return localValue3.Texture
      end

      return nil
    end

    return nil
  end

  local humanoid = character:WaitForChild("Humanoid")

  local function helperFunction2(parameter2, parameter3)
    local localValue4 = parameter3 or 4
    local localValue5 = parameter2 - humanoidRootPart.Position

    if localValue5.Magnitude < 1 then
      return true
    end

    local localValue6 = parameter2 - localValue5.Unit * localValue4

    local path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = false,
      AgentCanClimb = false,
    })

    if
      not pcall(function()
        path:ComputeAsync(humanoidRootPart.Position, localValue6)
      end) or path.Status ~= Enum.PathStatus.Success
    then
      return false
    end

    for index, value in ipairs(path:GetWaypoints()) do
      humanoid:MoveTo(value.Position)
      humanoid.MoveToFinished:Wait()
    end

    return true
  end

  local function helperFunction3(parameter4)
    local npc = parameter4:FindFirstChild("NPC")

    if npc then
      local thoughtBubble = npc:FindFirstChild("ThoughtBubble")

      if thoughtBubble then
        local frame = thoughtBubble:FindFirstChild("Frame")

        if frame then
          local imageLabel = frame:FindFirstChild("ImageLabel")

          if imageLabel then
            return imageLabel.Image
          end

          return nil
        end

        return nil
      end

      return nil
    end

    return nil
  end

  local helperFunction4

  local function helperFunction5(parameter5, parameter6)
    if not parameter5 or not parameter5:IsA("Model") then
      return false
    end

    local localValue7 = helperFunction4(parameter5)

    if not localValue7 then
      return false
    else
      local localValue8 = {
        pcall(function()
          setthreadidentity(2)

          require(localPlayer.PlayerScripts.Modules.InteractionHandler):ShowMenu(
            parameter5,
            localValue7.Position,
            localValue7
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
              local localValue9 = tick()
              tick()

              repeat
                for index2, value2 in ipairs(center:GetChildren()) do
                  if value2:IsA("TextButton") and value2.Visible and value2.Text == parameter6 then
                    firesignal(value2.Activated)
                    return true
                  else
                    local textLabel = value2:FindFirstChild("TextLabel")

                    if textLabel and textLabel.Text == parameter6 then
                      firesignal(textLabel.Parent.Activated)
                      return true
                    end
                  end
                end

                task.wait(0.1)
              until tick() - localValue9 > 5

              return false
            end
          end
        end),
      }

      return localValue8[2]
    end
  end

  function helperFunction4(parameter7)
    if not parameter7 then
      return nil
    elseif parameter7:IsA("Model") then
      return parameter7.PrimaryPart or parameter7:FindFirstChildWhichIsA("BasePart")
    else
      if parameter7:IsA("BasePart") then
        return parameter7
      end

      return
    end
  end

  local function helperFunction6()
    local localValue10 = {}

    for index3, value3 in ipairs(workspaceService._game.WinterActivityArea.NPCOrigins:GetChildren()) do
      if value3:IsA("BasePart") then
        table.insert(localValue10, {
          part = value3,
          dist = (humanoidRootPart.Position - value3.Position).Magnitude,
        })
      end
    end

    table.sort(localValue10, function(parameter8, parameter9)
      return parameter8.dist < parameter9.dist
    end)
    local localValue11 = {}

    for i = 1, 3 do
      if localValue10[i] then
        table.insert(localValue11, localValue10[i].part)
      end
    end

    return localValue11
  end

  local localValue12 = {
    ["rbxassetid://86140729452270"] = "rbxassetid://130269294115790",
    ["rbxassetid://122262114212016"] = "rbxassetid://111892000926158",
    ["rbxassetid://113530405426591"] = "rbxassetid://110076307186503",
  }

  local helperFunction7

  local function helperFunction8(parameter10)
    if not parameter10 then
      return
    else
      local npc2 = parameter10:FindFirstChild("NPC")

      if not npc2 then
        return
      else
        local localValue13 = helperFunction3(parameter10)

        if not localValue13 then
          return
        else
          local localValue14 = helperFunction7(localValue13)

          if not localValue14 then
            return
          else
            local bag2 = localValue14:FindFirstChild("Bag")

            if not bag2 then
              return
            end

            helperFunction2(localValue14.Position, 4)
            task.wait(0.2)
            helperFunction5(bag2, "Take")
            task.wait(0.4)
            helperFunction2(parameter10.Position, 4)
            task.wait(0.2)
            helperFunction5(npc2, "Give")
            return
          end
        end
      end
    end
  end

  function helperFunction7(parameter11)
    local localValue15 = localValue12[parameter11]

    if not localValue15 then
      return nil
    else
      local localValue16 = nil
      local huge = math.huge

      for index4, value4 in
        ipairs(workspaceService._game.WinterActivityArea.BagOrigins:GetChildren())
      do
        if value4:IsA("BasePart") then
          if helperFunction1(value4) == localValue15 then
            local magnitude = (humanoidRootPart.Position - value4.Position).Magnitude

            if magnitude < huge then
              localValue16 = value4
              huge = magnitude
            end
          end
        end
      end

      return localValue16
    end
  end

  function localValue2.startFrostyFriends()
    if localValue1 then
      return
    end

    localValue1 = true

    task.spawn(function()
      while localValue1 do
        for index5, value5 in ipairs((helperFunction6())) do
          if not localValue1 then
            break
          end

          helperFunction8(value5)
          task.wait(0.3)
        end

        task.wait(0.2)
      end
    end)
  end

  function localValue2.stopFrostyFriends()
    localValue1 = false
  end

  return localValue2
end
