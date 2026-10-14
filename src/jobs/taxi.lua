return function(ctx)
  -- ----------------------------------------------------
  -- Dеоbfuѕсаtеԁ Ѕuссesѕfullу Ву LеаκD
  -- https://discord.gg/AwGHNh7Z7T
  -- ----------------------------------------------------

  local pathfindingService = game:GetService("PathfindingService")
  local runService = game:GetService("RunService")
  local workspaceService = game:GetService("Workspace")
  local tweenService = game:GetService("TweenService")
  local players = game:GetService("Players")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local localPlayer = players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
  local humanoid = character:WaitForChild("Humanoid")
  require(localPlayer.PlayerScripts.Modules.InteractionHandler)
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

  local compkiller = _G.Compkiller or getgenv and getgenv().Compkiller

  if not compkiller then
    compkiller = loadstring(
      game:HttpGet("https://raw.githubusercontent.com/wereareone/weareone/refs/heads/main/UI.luau")
    )()
  end

  local notifier = _G.Notifier or getgenv and getgenv().Notifier or compkiller.newNotify()

  local function helperFunction1(title, content, parameter1)
    notifier.new({
      Title = title,
      Content = content,
      Duration = parameter1 or 5,
      Icon = "rbxassetid://103660255446080",
    })
  end

  local function helperFunction2()
    local taxiZone = workspace:FindFirstChild("TaxiZone")
    local stop = taxiZone and taxiZone:FindFirstChild("Stop")

    if stop then
      return stop.Position
    end

    return nil
  end

  local function helperFunction3()
    local taxiStands = workspace.Environment:FindFirstChild("TaxiStands")

    if not taxiStands then
      return nil
    else
      local localValue9 = nil
      local huge = math.huge

      for index, value in ipairs(taxiStands:GetChildren()) do
        local taxiJobCar = value:FindFirstChild("TaxiJobCar")

        if taxiJobCar then
          local magnitude = (taxiJobCar.Position - humanoidRootPart.Position).Magnitude

          if magnitude < huge then
            localValue9 = taxiJobCar
            huge = magnitude
          end
        end
      end

      return localValue9
    end
  end

  local localValue10 = {}
  local localValue11 = false
  local localValue12 = nil
  local chassi = nil

  local function helperFunction4()
    local findFirstChild = workspaceService:FindFirstChild(localPlayer.Name)

    if findFirstChild then
      local vehicleTruFleetCityTaxi = findFirstChild:FindFirstChild("Vehicle_TruFleet City Taxi")

      if vehicleTruFleetCityTaxi and vehicleTruFleetCityTaxi.Parent then
        localValue12 = vehicleTruFleetCityTaxi
        chassi = localValue12:FindFirstChild("Chassi") or localValue12.PrimaryPart
      else
        localValue12 = nil
        chassi = nil
      end
    else
      localValue12 = nil
      chassi = nil
    end
  end

  local function helperFunction5(parameter2, parameter3)
    local localValue13 = not parameter2 or not localValue11
    local localValue14, part, connect

    if localValue13 then
      return
    else
      local raycastParams = RaycastParams.new()
      raycastParams.FilterType = Enum.RaycastFilterType.Exclude
      raycastParams.FilterDescendantsInstances = { character, parameter2.Parent }

      local raycast = workspace:Raycast(
        parameter2.Position + Vector3.new(0, 50, 0),
        Vector3.new(0, -100, 0),
        raycastParams
      )

      local localValue15 = (raycast and raycast.Position.Y or parameter2.Position.Y) - 220
      localValue14 = localValue15 - 4

      part = Instance.new("Part")
      part.Name = "Part"
      part.Size = Vector3.new(15, 2, 15)
      part.Anchored = true
      part.CanCollide = true
      part.Transparency = 0.5
      part.Parent = parameter2.Parent

      parameter2.CFrame = CFrame.new(parameter2.Position.X, localValue15, parameter2.Position.Z)

      connect = nil

      connect = runService.Heartbeat:Connect(function()
        if part and parameter2 and part.Parent then
          part.CFrame = CFrame.new(parameter2.Position.X, localValue14, parameter2.Position.Z)
        elseif connect then
          connect:Disconnect()
        end
      end)

      local vector = Vector2.new(parameter2.Position.X, parameter2.Position.Z)
      local vector2 = Vector2.new(parameter3.X, parameter3.Z)

      local create = tweenService:Create(
        parameter2,
        TweenInfo.new(
          (vector - vector2).Magnitude / 45,
          Enum.EasingStyle.Linear,
          Enum.EasingDirection.InOut
        ),
        { CFrame = CFrame.new(parameter3.X, localValue15, parameter3.Z) }
      )

      create:Play()
      create.Completed:Wait()

      if connect then
        connect:Disconnect()
      end

      if part then
        part:Destroy()
      end

      if localValue11 then
        local raycast2 = workspace:Raycast(
          Vector3.new(parameter3.X, parameter3.Y + 50, parameter3.Z),
          Vector3.new(0, -100, 0),
          raycastParams
        )

        local y = raycast2 and raycast2.Position.Y or parameter3.Y
        parameter2.CFrame = CFrame.new(parameter3.X, y + 5, parameter3.Z)
        task.wait(0.2)
      end

      return
    end
  end

  local function helperFunction6(parameter4)
    local path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = true,
    })

    pcall(function()
      path:ComputeAsync(humanoidRootPart.Position, parameter4)
    end)

    if path.Status ~= Enum.PathStatus.Success then
      helperFunction1("Error", "Cannot find path!", 3)
      return false
    end

    for index2, value2 in ipairs(path:GetWaypoints()) do
      if not localValue11 then
        return false
      end

      humanoid:MoveTo(value2.Position)
      humanoid.MoveToFinished:Wait()
    end

    return true
  end

  function GoToWork(parameter5, name)
    local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )

    if not parameter5 then
      return
    end

    if (humanoidRootPart2.Position - parameter5).Magnitude >= 100 then
      localValue1.ToWork:InvokeServer({ Name = name })
    end
  end

  local function helperFunction7()
    helperFunction4()

    if localValue12 and localValue12.Parent then
      return localValue12
    elseif not helperFunction6((Vector3.new(140.5026550293, 4.7408156394958, 100.74179840088))) then
      warn("Failed to path to moped spawn")
      return nil
    else
      task.wait(3)
      local localValue16 = helperFunction3()

      if not localValue16 then
        warn("VehicleRental null")
        return nil
      else
        require(players.LocalPlayer.PlayerScripts.Modules.JobHandler.TaxiJob).UseTaxi(
          "",
          localValue16,
          ""
        )
        local localValue17 = tick()

        while tick() - localValue17 < 10 do
          if not localValue11 then
            return nil
          end

          task.wait(0.2)
          helperFunction4()

          if localValue12 and localValue12.Parent then
            return localValue12
          end
        end

        warn("Timeout waiting for moped spawn")
        return nil
      end
    end
  end

  local function helperFunction8()
    localValue11 = true
    helperFunction7()

    while localValue11 do
      task.wait(0.1)
      helperFunction4()

      if not localValue12 or not localValue12.Parent or not chassi then
        helperFunction7()
      else
        local localValue18 = helperFunction2()

        if not localValue18 then
          task.wait(1)
        else
          helperFunction5(chassi, localValue18)

          if chassi then
            chassi.AssemblyLinearVelocity = Vector3.zero
          end

          task.wait(2)
        end
      end
    end
  end

  function localValue10.startAutoFarm()
    if localValue11 then
      return
    end

    GoToWork(Vector3.new(140.5026550293, 4.7408156394958, 100.74179840088), "TaxiJob")
    localValue11 = true
    helperFunction1("WereTools", "Taxi AutoFarm Started!", 5)
    task.spawn(helperFunction8)
  end

  function localValue10.stopAutoFarm()
    localValue11 = false
    helperFunction1("WereTools", "Taxi AutoFarm Stoped!", 5)

    if chassi then
      chassi.AssemblyLinearVelocity = Vector3.zero
    end
  end

  return localValue10
end
