return function(ctx)
  -- ----------------------------------------------------
  -- Orіginаl Соԁе Dеоbfusсаtеԁ Ву LеаκD
  -- https://discord.gg/AwGHNh7Z7T
  -- ----------------------------------------------------

  local workspaceService = game:GetService("Workspace")
  local pathfindingService = game:GetService("PathfindingService")
  local virtualInputManager = game:GetService("VirtualInputManager")
  local players = game:GetService("Players")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local dataService = replicatedStorage.Modules.DataService
  local localPlayer = players.LocalPlayer
  local currentCamera = workspaceService.CurrentCamera
  local localValue1 = getconnections(dataService.DescendantAdded)[1].Function
  getupvalue(localValue1, 1)
  local localValue2 = next
  local localValue3, localValue4 = getupvalue(getupvalue(localValue1, 2), 1)

  for localValue5, localValue6 in localValue2, localValue3, localValue4 do
    localValue21 = localValue6:sub(1, 2) == "F_" and localValue6:sub(3)
  end

  local localValue7 = {}
  local localValue8 = false

  local function helperFunction1()
    local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )
    local gameplay =
      workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor1.Part1.Gymnasium.Interior.Gameplay
    local huge = math.huge
    local position

    for key, value in pairs(gameplay:GetChildren()) do
      if value:IsA("Model") and value.Name == "Basketball Rack [Gameplay]" then
        local origin = value:FindFirstChild("Origin")

        if origin then
          local magnitude = (humanoidRootPart.Position - origin.Position).Magnitude

          if magnitude < huge then
            huge = magnitude
            position = origin.Position
          end
        end
      end
    end

    return position
  end

  local function helperFunction2()
    local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )
    local gameplay2 =
      workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor1.Part1.Gymnasium.Interior.Gameplay
    local huge2 = math.huge
    local position2

    for key2, value2 in pairs(gameplay2:GetChildren()) do
      if value2:IsA("BasePart") and value2.Name == "Basketball Hoop [Gameplay]" then
        local magnitude2 = (humanoidRootPart2.Position - value2.Position).Magnitude

        if magnitude2 < huge2 then
          huge2 = magnitude2
          position2 = value2.Position
        end
      end
    end

    return position2
  end

  local function helperFunction3(parameter1, parameter2)
    local getControls =
      require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
    getControls:Disable()

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoidRootPart3 = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local path

    if type(parameter2) == "table" then
      path = pathfindingService:CreatePath(parameter2)
    else
      path = pathfindingService:CreatePath()
    end

    pcall(function()
      path:ComputeAsync(humanoidRootPart3.Position, parameter1)
    end)

    if path.Status == Enum.PathStatus.Success then
      local localValue9 = next
      local localValue10, localValue11 = path:GetWaypoints()

      for localValue12, localValue13 in localValue9, localValue10, localValue11 do
        if not localValue8 then
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

  local function helperFunction4(parameter3)
    local humanoidRootPart4 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )
    local localValue14 = Vector3.new(parameter3.X, humanoidRootPart4.Position.Y, parameter3.Z)
      - humanoidRootPart4.Position

    if localValue14.Magnitude > 0 then
      local unit = localValue14.Unit

      humanoidRootPart4.CFrame =
        CFrame.new(humanoidRootPart4.Position, humanoidRootPart4.Position + unit)

      task.wait()

      currentCamera.CFrame = CFrame.new(
        currentCamera.CFrame.Position,
        currentCamera.CFrame.Position + humanoidRootPart4.CFrame.LookVector
      )
    end
  end

  local function helperFunction5()
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)

    local waitForChild =
      localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGUI"):WaitForChild("HitBar", 3)

    if waitForChild then
      local localValue15 = tick() + 3

      while localValue8 and not waitForChild.Visible and tick() < localValue15 do
        task.wait(0.05)
      end

      if not waitForChild.Visible then
        warn("Timeout: HitBar did not become visible!")
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
        return
      end

      local marker = waitForChild:WaitForChild("Marker")

      while localValue8 do
        if not waitForChild.Visible then
          virtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
          break
        else
          local scale = marker.Position.Y.Scale

          if scale > 0.2 and scale < 0.34 then
            virtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
            break
          end

          task.wait()
        end
      end

      return
    end

    warn("Cannot find HitBar.")
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
  end

  function localValue7.startPhysics()
    if localValue8 then
      warn("Script already running!")
      return
    end

    print("Start Physics!")
    localValue8 = true

    task.spawn(function()
      while localValue8 do
        local localValue16 = helperFunction1()

        if localValue16 then
          print("Gonig to Basketball Rack...")
          helperFunction3(localValue16)

          if not localValue8 then
            break
          end

          task.wait(0.5)
        else
          warn("Cannot find Basketball Rack.")
          task.wait(1)
        end

        if not localValue8 then
          break
        else
          local basketballRing = workspaceService:FindFirstChild("BasketballRing")

          if basketballRing then
            helperFunction3(basketballRing:GetPivot().Position)
            local localValue17 = helperFunction2()
            task.wait(0.1)

            if localValue8 then
              if localValue17 then
                helperFunction4(localValue17)
                helperFunction5()
                task.wait(1.5)
              else
                warn("Cannot find Basketball Hoop [Gameplay]")
                task.wait(1)
              end
            end
          else
            warn("Cannot find BasketballRing.")
            task.wait(1)
          end
        end
      end
    end)
  end

  function localValue7.stopPhysics()
    localValue8 = false
    print("Stop Physics.")
  end

  getgenv().BasketballFarm = localValue7
  return localValue7
end
