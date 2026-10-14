return function(ctx)
  -- Тһіѕ Fіlе Ԝаѕ Dеоbfuscаteԁ Вy LеаκD
  -- https://discord.gg/AwGHNh7Z7T

  local workspaceService = game:GetService("Workspace")
  local pathfindingService = game:GetService("PathfindingService")
  local runService = game:GetService("RunService")
  local players = game:GetService("Players")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local localPlayer = players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
  local humanoid = character:WaitForChild("Humanoid")
  require(localPlayer.PlayerScripts.Modules.InteractionHandler)
  local activeController =
    require(localPlayer.PlayerScripts.PlayerModule.ControlModule).activeController
  local localValue1 =
    getconnections(replicatedStorage.Modules.DataService.DescendantAdded)[1].Function
  getupvalue(localValue1, 1)
  local localValue2 = next
  local localValue3, localValue4 = getupvalue(getupvalue(localValue1, 2), 1)

  for localValue5, localValue6 in localValue2, localValue3, localValue4 do
    localValue24 = localValue6:sub(1, 2) == "F_" and localValue6:sub(3)
  end

  local localValue7

  local function helperFunction1()
    if localValue7 then
      return
    end

    task.spawn(function()
      local function helperFunction2(parameter1, parameter2)
        for index, value in ipairs(parameter1:GetChildren()) do
          if value:IsA(parameter2) then
            return value
          end
        end

        return nil
      end

      local function helperFunction3(parameter3, label)
        if helperFunction2(parameter3, "PathfindingModifier") then
          return
        else
          local pathfindingModifier = Instance.new("PathfindingModifier")
          pathfindingModifier.Name = "pathfinding_modifier"
          pathfindingModifier.PassThrough = false
          pathfindingModifier.Label = label
          pathfindingModifier.Parent = parameter3

          return
        end
      end

      local function helperFunction4(parameter4, fn)
        if not (parameter4 and parameter4:IsA("Instance")) then
          return
        end

        for index2, value2 in ipairs((parameter4:GetDescendants())) do
          if value2:IsA("BasePart") then
            fn(value2)
          end

          if index2 % 50 == 0 then
            task.wait()
          end
        end
      end

      local fences = workspace.Environment.Props:FindFirstChild("Fences")
      local parking = workspace.Environment.RoadsNetwork.Network:FindFirstChild("Parking")

      for index3, value3 in ipairs({
        { fences, "PierFences" },
        { parking, "Road" },
        { workspace.Environment.RoadsNetwork.Network:FindFirstChild("Roads"), "Road" },
        { workspace.Environment.Locations.Beach:FindFirstChild("CityBeach"), "PierFences" },
        { workspace.Environment.RoadsNetwork:FindFirstChild("Sidewalk"), "Pavement" },
        {
          workspace.Environment:FindFirstChild("Foliage"),
          "PierFences",
          function(parameter5)
            parameter5.CanCollide = false
          end,
        },
        {
          workspace.Environment:FindFirstChild("World Lights"),
          "PierFences",
          function(parameter6)
            parameter6.CanCollide = false
          end,
        },
        {
          workspaceService.Environment:FindFirstChild("DetailObjects"),
          "PierFences",
          function(parameter7)
            parameter7.CanCollide = false
          end,
        },
        {
          workspace.Environment:FindFirstChild("RentalVehicles"),
          "PierFences",
          function(parameter8)
            parameter8.CanCollide = false
          end,
        },
      }) do
        local localValue8 = value3

        helperFunction4(localValue8[1], function(parameter9)
          helperFunction3(parameter9, localValue8[2])

          if localValue8[3] then
            localValue8[3](parameter9)
          end
        end)
      end

      local ring = workspace.Environment.Locations.City.PizzaPlanet.Exterior:FindFirstChild("Ring")

      if ring then
        helperFunction3(ring, "IgnoreArea")
      end

      for index4, value4 in ipairs({
        {
          Name = "BlockArea2",
          Size = Vector3.new(3.49, 26.29, 55.75),
          CFrame = CFrame.new(-194.5, 14.47, -360.61),
        },
        {
          Name = "BlockArea1",
          Size = Vector3.new(3.49, 26.29, 60.39),
          CFrame = CFrame.new(-194.5, 14.47, -450.49),
        },
      }) do
        local part = Instance.new("Part")
        part.Name = value4.Name
        part.Size = value4.Size
        part.CFrame = value4.CFrame
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.Parent = workspace

        helperFunction3(part, "IgnoreArea")
      end

      localValue7 = true
    end)
  end

  local localValue9 = {}
  localValue9.speed = 0.1

  local localValue10 = false

  local function helperFunction5()
    local snowPlowRentals = workspace._game:FindFirstChild("Snow Plow Rentals")

    if not snowPlowRentals then
      warn("Snow Plow Rentals folder invalid ")
      return nil
    else
      local position = humanoidRootPart.Position
      local localValue11 = nil
      local huge = math.huge

      for index5, value5 in ipairs(snowPlowRentals:GetChildren()) do
        if value5.Name == "Snow Plow Rental Location" then
          local vehicleRental = value5:FindFirstChild("VehicleRental")

          if vehicleRental and vehicleRental:IsA("BasePart") then
            local magnitude = (vehicleRental.Position - position).Magnitude

            if magnitude < huge then
              huge = magnitude
              localValue11 = vehicleRental
            end
          end
        end
      end

      return localValue11
    end
  end

  local chassi

  local function helperFunction6(parameter10)
    if not chassi then
      return
    else
      local lookVector = chassi.CFrame.LookVector
      local unit = (Vector3.new(parameter10.X, chassi.Position.Y, parameter10.Z) - chassi.Position).Unit
      local localValue12 = math.acos(lookVector:Dot(unit))

      if localValue12 < math.rad(10) then
        return
      else
        local localValue13 = math.clamp(localValue12 / math.pi, 0.05, 0.1)
        local cframe = CFrame.lookAt(chassi.Position, chassi.Position + unit)
        chassi.CFrame = chassi.CFrame:Lerp(cframe, localValue13)
        return
      end
    end
  end

  local localValue14 = 0

  local function helperFunction7(parameter11)
    if not parameter11 then
      return nil
    elseif parameter11:IsA("Model") then
      return parameter11.PrimaryPart or parameter11:FindFirstChildWhichIsA("BasePart")
    else
      if parameter11:IsA("BasePart") then
        return parameter11
      end

      return
    end
  end

  local localValue15

  local function helperFunction8()
    local findFirstChild = workspaceService:FindFirstChild(localPlayer.Name)

    if findFirstChild then
      local vehicleKITTENSTL45Snowplow =
        findFirstChild:FindFirstChild("Vehicle_KITTEN STL-45 Snowplow")

      if vehicleKITTENSTL45Snowplow and vehicleKITTENSTL45Snowplow.Parent then
        localValue15 = vehicleKITTENSTL45Snowplow
        chassi = localValue15:FindFirstChild("Chassi") or localValue15.PrimaryPart
      else
        localValue15 = nil
        chassi = nil
      end
    else
      localValue15 = nil
      chassi = nil
    end
  end

  local function helperFunction9(parameter12)
    local path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = true,
      AgentCanClimb = true,
    })

    local localValue16, localValue17 = pcall(function()
      path:ComputeAsync(humanoidRootPart.Position, parameter12)
    end)

    if not localValue16 or path.Status ~= Enum.PathStatus.Success then
      warn("Pathfinding humanoid failed:", localValue17 or path.Status.Name)
      return false
    end

    for index6, value6 in ipairs((path:GetWaypoints())) do
      if not localValue10 then
        return false
      end

      humanoid:MoveTo(value6.Position)

      if not humanoid.MoveToFinished:Wait() then
        warn("Failed to reach waypoint", value6.Position)
        return false
      end
    end

    return true
  end

  local localValue18

  local function helperFunction10()
    if #localValue18 == 0 then
      return nil
    end

    return localValue18[math.random(1, #localValue18)].Position
      + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
  end

  local function helperFunction11(parameter13, parameter14)
    local localValue19 = helperFunction7(parameter13)

    if not localValue19 then
      return false
    else
      local localValue20, localValue21 = pcall(function()
        setthreadidentity(2)

        require(localPlayer.PlayerScripts.Modules.InteractionHandler):ShowMenu(
          parameter13,
          localValue19.Position,
          localValue19
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
            local localValue22 = tick()
            tick()

            repeat
              for index7, value7 in ipairs(center:GetChildren()) do
                if value7:IsA("TextButton") and value7.Visible then
                  if value7.Text == parameter14 then
                    firesignal(value7.Activated)
                    firesignal(value7.MouseButton1Click)
                    return true
                  end
                end

                local textLabel = value7:FindFirstChild("TextLabel")

                if textLabel and textLabel.Text == parameter14 then
                  firesignal(value7.Activated)
                  firesignal(value7.MouseButton1Click)
                  return true
                end
              end

              task.wait(0.1)
            until tick() - localValue22 > 5

            return false
          end
        end
      end)

      if not localValue20 then
        warn("ERROR:", localValue21)
      end

      return localValue21
    end
  end

  local function helperFunction12(parameter15)
    if not chassi then
      return
    else
      local vector = Vector3.new(0, 0, -1)

      if parameter15 then
        local magnitude2 = (chassi.Position - parameter15).Magnitude

        if magnitude2 < 15 then
          vector = Vector3.zero
        elseif magnitude2 < 30 then
          vector = Vector3.new(0, 0, -0.3)
        end
      end

      activeController.moveVector = vector
      return
    end
  end

  local function helperFunction13()
    helperFunction8()

    if localValue15 and localValue15.Parent then
      return localValue15
    else
      local localValue23 = helperFunction5()

      if not localValue23 then
        warn("VehicleRental null")
        return nil
      elseif not helperFunction9(localValue23.Position) then
        warn("Failed to path to moped spawn")
        return nil
      elseif not helperFunction11(localValue23, "Use") then
        warn("Failed to interact with nearest VehicleRental")
        return nil
      else
        local localValue25 = tick()

        while tick() - localValue25 < 10 do
          if not localValue10 then
            return nil
          end

          task.wait(0.2)
          helperFunction8()

          if localValue15 and localValue15.Parent then
            return localValue15
          end
        end

        warn("Timeout waiting for moped spawn")
        return nil
      end
    end
  end

  local function helperFunction14()
    warn("RESETTING...")

    function localValue1159()
      localValue9.stopSnowplowing()
    end

    localValue10 = false

    if activeController then
      activeController.moveVector = Vector3.zero
    end

    task.wait(0.5)
    task.wait(1.5)

    localValue14 = 0
    currentTargetSnow = nil

    function localValue1168()
      helperFunction8()
    end

    chassi = nil
    localValue15 = nil
    localValue9.startSnowplowing()
  end

  localValue7 = false

  local function helperFunction15(parameter16)
    local position2, localValue27, localValue28

    if not chassi then
      warn("No moped body for pathfinding")
      return false
    end

    local function helperFunction16(parameter17, parameter18)
      local path2 = pathfindingService:CreatePath({
        AgentRadius = 10,
        AgentHeight = 6,
        WaypointSpacing = 6,
        AgentCanJump = false,
        AgentCanClimb = false,
        Costs = {
          Road = 1,
          Pavement = math.huge,
          Planks = math.huge,
          Terrain = math.huge,
          PierFences = math.huge,
          IgnoreArea = math.huge,
        },
      })

      local localValue30, localValue31 = pcall(function()
        path2:ComputeAsync(parameter17, parameter18)
      end)

      if localValue30 and path2.Status == Enum.PathStatus.Success then
        return path2:GetWaypoints()
      end

      warn("Path computation failed:", localValue31 or path2.Status.Name)
      return nil
    end

    local localValue32 = helperFunction16(chassi.Position, parameter16)

    if not localValue32 or #localValue32 < 2 then
      warn("Initial pathfinding failed.")
      localValue14 = localValue14 + 1
      warn("PATH FAIL COUNT =", localValue14)

      if localValue14 >= 15 then
        helperFunction14()
      end
      return false
    end

    local localValue26 = 2
    position2 = chassi.Position
    localValue27 = 0
    localValue28 = 0

    while localValue26 <= #localValue32 and localValue10 do
      local localValue33 = localValue32[localValue26]
      local restartOuter = false
      local advanceWaypoint = false
      local backup = false

      while not restartOuter and not advanceWaypoint and not backup do
        if (chassi.Position - localValue33.Position).Magnitude > 15 and localValue10 then
          if (chassi.Position - parameter16).Magnitude < 20 then
            activeController.moveVector = Vector3.new(0, 0, 0.6)
            local localValue34 = tick()

            while localValue10 and chassi.Velocity.Magnitude > 2 and tick() - localValue34 < 2 do
              task.wait()
            end

            activeController.moveVector = Vector3.zero
            return true
          end

          helperFunction6(localValue33.Position)
          helperFunction12(localValue33.Position)
          local localValue35 = runService.Heartbeat:Wait()

          if (chassi.Position - position2).Magnitude < 0.1 then
            localValue27 = localValue27 + localValue35

            if localValue27 > 0.25 then
              localValue28 = localValue28 + 1
              localValue27 = 0
              warn("Moped seems stuck. Attempt:", localValue28)

              if localValue28 == 2 then
                local rightVector = chassi.CFrame.RightVector
                local localValue36 =
                  helperFunction16(chassi.Position - rightVector * 10, parameter16)
                local localValue37 =
                  helperFunction16(chassi.Position + rightVector * 10, parameter16)

                if localValue36 then
                  localValue32 = localValue36
                  localValue26 = 1
                  position2 = chassi.Position
                  restartOuter = true
                elseif localValue37 then
                  localValue32 = localValue37
                  localValue26 = 1
                  position2 = chassi.Position
                  restartOuter = true
                else
                  warn("Sidestep failed")
                end
              elseif localValue28 >= 3 then
                backup = true
              end
            end
          else
            localValue27 = 0
            position2 = chassi.Position
          end
        else
          advanceWaypoint = true
        end
      end

      if advanceWaypoint then
        if localValue26 < #localValue32 and chassi.Velocity.Magnitude > 35 then
          local localValue38 = localValue32[localValue26 - 1]
          local localValue39 = localValue32[localValue26]
          local localValue40 = localValue32[localValue26 + 1]

          if localValue40 then
            if
              (localValue39.Position - localValue38.Position).Unit:Dot(
                (localValue40.Position - localValue39.Position).Unit
              ) < 0.9
            then
              activeController.moveVector = Vector3.new(0, 0, 0.8)
              task.wait(0.25)
            end
          end
        end

        localValue26 = localValue26 + 1
      elseif backup then
        warn("Moped stuck 3 times, backing up…")
        local localValue41 = tick()

        while tick() - localValue41 < 2 do
          if not localValue10 then
            return false
          end

          activeController.moveVector = Vector3.new(0, 0, 1)
          runService.Heartbeat:Wait()
        end

        activeController.moveVector = Vector3.zero
        local rightVector2 = chassi.CFrame.RightVector
        local localValue42 = helperFunction16(chassi.Position - rightVector2 * 15, parameter16)
        local localValue43 = helperFunction16(chassi.Position + rightVector2 * 15, parameter16)

        if localValue42 then
          localValue28 = 0
          localValue32 = localValue42
          localValue26 = 1
          position2 = chassi.Position
        elseif localValue43 then
          localValue26 = 1
          localValue32 = localValue43
          localValue28 = 0
          position2 = chassi.Position
        else
          warn("Sidestep failed after backup")
          local localValue44 = helperFunction16(chassi.Position, parameter16)

          if localValue44 then
            localValue26 = 1
            localValue32 = localValue44
            localValue28 = 0
            position2 = chassi.Position
            warn("Path recalculated after backing up")
          else
            warn("Failed even after full recalculation")
            return false
          end
        end
      end
    end

    activeController.moveVector = Vector3.zero
    return true
  end

  local function helperFunction17()
    local roads = workspace.Environment.RoadsNetwork.Network:FindFirstChild("Roads")
    local localValue45 = {}

    if not roads then
      return localValue45
    end

    for index8, value8 in ipairs(roads:GetDescendants()) do
      if value8:IsA("BasePart") then
        table.insert(localValue45, value8)
      end
    end

    return localValue45
  end

  localValue18 = helperFunction17()

  local function helperFunction18()
    localValue10 = true

    if not helperFunction13() then
      warn("Can't get moped")
      return
    end

    local localValue46

    while localValue10 do
      helperFunction8()

      local haveBody = false
      if not localValue15 or not localValue15.Parent then
        print("No moped found, trying to get one...")
        localValue15 = helperFunction13()

        if not localValue15 then
          warn("Failed to get moped, retrying in 5s")
          task.wait(5)
        else
          chassi = localValue15:FindFirstChild("Chassi") or localValue15.PrimaryPart

          if not chassi then
            warn("Moped has no body, retry in 5s")
            task.wait(5)
          else
            haveBody = true
          end
        end
      else
        haveBody = true
      end

      if haveBody then
        localValue46 = helperFunction10()

        if not localValue46 then
          warn("Can't find road point!")
          task.wait(1)
        else
          print("New point:", localValue46)

          if not helperFunction15(localValue46) then
            localValue14 = localValue14 + 1
            warn("Path failed, count =", localValue14)

            if localValue14 >= 15 then
              helperFunction14()
              return
            end
          else
            localValue14 = 0
          end

          task.wait(0.5)
        end
      end
    end
  end

  function localValue9.startSnowplowing()
    helperFunction1()

    if localValue10 then
      return
    end

    localValue10 = true
    print("Winter started!")
    task.spawn(helperFunction18)
  end

  function localValue9.stopSnowplowing()
    localValue10 = false
    activeController.moveVector = Vector3.zero
    print("Winter stopped.")
  end

  return localValue9
end
