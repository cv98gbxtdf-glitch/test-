return function(ctx)
  ---@source Dеоbfusсateԁ Ѕuссеsѕfullу Ву LеаκD
  ---@see https://discord.gg/AwGHNh7Z7T

  local workspaceService = game:GetService("Workspace")
  local pathfindingService = game:GetService("PathfindingService")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local players = game:GetService("Players")
  local localValue1 = {}
  local localPlayer = players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoid = character:WaitForChild("Humanoid")
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
  local localValue2 = false
  local localValue3 = false
  local localValue4 = false

  local function helperFunction1(parameter1, parameter2)
    local path = pathfindingService:CreatePath({
      AgentRadius = 2,
      AgentHeight = 5,
      AgentCanJump = false,
    })

    path:ComputeAsync(
      humanoidRootPart.Position,
      parameter1.Position
        - (parameter1.Position - humanoidRootPart.Position).Unit * (parameter2 or 6)
    )

    if path.Status ~= Enum.PathStatus.Success then
      return false
    end

    for index, value in ipairs(path:GetWaypoints()) do
      humanoid:MoveTo(value.Position)

      if not humanoid.MoveToFinished:Wait() then
        return false
      elseif value.Action == Enum.PathWaypointAction.Jump then
        humanoid.Jump = true
      end
    end

    return true
  end

  local function helperFunction2()
    local gameplay =
      workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor2.Science.Interior.Gameplay
    local localValue5 = {}

    for index2, value2 in ipairs(gameplay:GetChildren()) do
      local chemistryStationSpawnPosChemD = value2.Name:match("^ChemistryStationSpawnPosChem(%d+)$")

      if chemistryStationSpawnPosChemD then
        local localValue6 = tonumber(chemistryStationSpawnPosChemD)
        local findFirstChild = value2:FindFirstChild("Chem" .. localValue6)

        if findFirstChild then
          local largeBeakerGlass = findFirstChild:FindFirstChild("LargeBeakerGlass")

          local origin = largeBeakerGlass
          origin = largeBeakerGlass and largeBeakerGlass:FindFirstChild("Origin")

          if origin and origin:IsA("BasePart") then
            table.insert(localValue5, {
              id = localValue6,
              spawn = value2,
              station = findFirstChild,
              stationName = "Chem" .. localValue6,
              origin = origin,
            })
          end
        end
      end
    end

    return localValue5
  end

  local function helperFunction3()
    local localValue7 =
      getconnections(replicatedStorage.Modules.DataService.DescendantAdded)[1].Function
    local localValue8 = getupvalue(localValue7, 1)
    local localValue9 = {}

    for key, value3 in next, getupvalue(getupvalue(localValue7, 2), 1), nil do
      local sub = value3:sub(1, 2) == "F_" and value3:sub(3) or value3
      localValue9[sub] = localValue8[key]
    end

    return localValue9
  end

  local localValue10

  local function helperFunction4(parameter3, parameter4)
    local localValue11 = {}

    for i = 1, #parameter3 do
      local localValue12 = math.random(1, #parameter3)

      while localValue11[localValue12] do
        localValue12 = math.random(1, #parameter3)
      end

      localValue11[localValue12] = true
      local scaleName = parameter3[localValue12].scaleName or parameter3[localValue12].stationName

      if
        pcall(function()
          if parameter4 == "T_BalanceScale" then
            localValue10.AttemptClaimStation:FireServer({
              StationName = scaleName,
              TaskType = parameter4,
            })
          elseif parameter4 == "T_MixChemicals" then
            localValue10.RequestClaimChemistryStation:InvokeServer({ StationName = scaleName })
          end
        end)
      then
        return parameter3[localValue12]
      end
    end

    return nil
  end

  localValue10 = helperFunction3()
  local localValue13 = false

  local function helperFunction5()
    if localValue13 then
      return
    else
      localValue13 = true
      local scaleSpawnPosScale1 =
        workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor2.Science.Interior.Gameplay.ScaleSpawnPosScale1

      if not helperFunction1(scaleSpawnPosScale1, 4) then
        warn("Can't go to Scale1")
        localValue13 = false
        return
      else
        task.wait(1)
        local localValue14 = nil

        for key2, value4 in pairs(getgc(true)) do
          if type(value4) == "table" and rawget(value4, "sideBWeight") ~= nil then
            localValue14 = value4
            break
          end
        end

        if not localValue14 then
          warn("sideBWeight is null!")
          localValue13 = false
          return
        else
          local sideBWeight = localValue14.sideBWeight
          print("SideB:", sideBWeight)
          local weightsTableParent =
            scaleSpawnPosScale1:FindFirstChild("Scale1"):FindFirstChild("WeightsTableParent")

          local localValue15 = {
            [5] = weightsTableParent.ScaleWeightHeavy.Main.ClickDetector,
            [2] = weightsTableParent.ScaleWeightMedium.Main.ClickDetector,
            [1] = weightsTableParent.ScaleWeightLight.Main.ClickDetector,
          }

          local total = 0

          if localValue14.sideAWeights and type(localValue14.sideAWeights) == "table" then
            for key3, value5 in pairs(localValue14.sideAWeights) do
              total = total + value5
            end
          end

          local localValue16 = sideBWeight - total
          print(" Weights:", total, "| Need:", localValue16)

          for index3, value6 in ipairs({ 5, 2, 1 }) do
            while localValue16 >= value6 and localValue16 > 0 do
              local localValue17 = localValue15[value6]

              if localValue17 then
                fireclickdetector(localValue17, 0, "MouseClick")
                localValue16 = localValue16 - value6
                print(("Add %d, Weights Left %d"):format(value6, localValue16))
                task.wait(0.5)
              else
                break
              end
            end
          end

          print("Done balance task!")
          task.wait(1.5)
          localValue13 = false
          humanoid.Jump = true
          return
        end
      end
    end
  end

  local function helperFunction6()
    local localValue18, origin2

    if localValue3 then
      return print("Chemical running, skip")
    else
      localValue3 = true
      local localValue19 = helperFunction2()

      if #localValue19 == 0 then
        warn("❌ No chemistry station found!")
        localValue3 = false
        return
      end

      localValue18 = helperFunction4(localValue19, "T_MixChemicals")

      if not localValue18 then
        warn("❌ Cannot claim any chemistry station!")
        localValue3 = false
        return
      end

      origin2 = localValue18.origin

      if not origin2 or not origin2:IsA("BasePart") then
        warn("Station has no Origin part")
        localValue3 = false
        return
      end

      if not origin2 or not origin2:IsA("BasePart") then
        warn("Station has no Origin part")
        localValue3 = false
        return
      elseif not helperFunction1(origin2, 5) then
        warn("Cannot go to station", localValue18.stationName)
        localValue3 = false
        return
      else
        task.wait(1)
        local lower =
          localPlayer.PlayerGui.TopbarGui.Topbar.Header.SchoolHeader.SchoolFooter.FrameLeftBottom.TextLabelLeft.Text:lower()
        local localValue20 = nil

        for key4, value7 in pairs({
          purple = { "RedFlask", localValue18.stationName, "BlueFlask" },
          green = { "BlueFlask", localValue18.stationName, "YellowFlask" },
          orange = { "YellowFlask", localValue18.stationName, "RedFlask" },
        }) do
          if lower:find(key4) then
            localValue20 = value7
            break
          end
        end

        if not localValue20 then
          warn("⚠️ Cannot detect color")
          localValue3 = false
          return
        else
          table.insert(localValue20, localValue18.stationName)

          local function helperFunction7(parameter5)
            if parameter5 == localValue18.stationName then
              return origin2
            else
              local findFirstChild2 =
                workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor2.Science.Interior.Gameplay.ChemistryClass.ChemistryStationTable.Flasks:FindFirstChild(
                  parameter5
                )

              if not findFirstChild2 then
                return nil
              end

              return findFirstChild2.PrimaryPart
                or findFirstChild2:FindFirstChildWhichIsA("BasePart")
            end
          end

          for index4, value8 in ipairs(localValue20) do
            local localValue21 = helperFunction7(value8)

            if localValue21 then
              helperFunction1(localValue21, 4)

              if value8 ~= localValue18.stationName then
                task.wait(1)
                localValue10.RequestPickUpFlask:FireServer({ FlaskName = value8 })
              else
                task.wait(1)

                localValue10.RequestAttachAndPour:FireServer({
                  AttachOptions = {
                    DetachCarried = false,
                    LookStrength = 0.2,
                    Animation = "PourFlask",
                    NoEquipped = false,
                  },
                  Duration = 1.5,
                  StationName = localValue18.stationName,
                  AttachPosition = Vector3.new(944, 47, -273),
                })
              end

              task.wait(0.6)
            else
              warn("Cannot find flask:", value8)
            end
          end

          localValue3 = false
          localValue4 = false
          print("Done Mix Chemical:", localValue18.stationName)
          return
        end
      end
    end
  end

  local connect

  function localValue1.startChem()
    if localValue2 then
      return warn("AutoFarm is running!")
    end

    localValue2 = true
    print("Auto Chemistry started!")
    helperFunction1(
      { Position = Vector3.new(953.88836669922, 47.305213928223, -267.48876953125) },
      0
    )
    local textLabelLeft = nil

    repeat
      task.wait(0.5)

      pcall(function()
        textLabelLeft =
          localPlayer.PlayerGui.TopbarGui.Topbar.Header.SchoolHeader.SchoolFooter.FrameLeftBottom.TextLabelLeft
      end)
    until textLabelLeft ~= nil

    print("Get UI footerLabel!")
    local localValue22 = nil
    local localValue23 = false

    connect = textLabelLeft:GetPropertyChangedSignal("Text"):Connect(function()
      if not localValue2 then
        return
      else
        local lower2 = textLabelLeft.Text:lower()

        if lower2:find("claim") then
          if lower2:find("balance") then
            if localValue22 ~= "balance" or not localValue23 then
              localValue22 = "balance"
              localValue23 = true
              print("Claim Balance station...")
              helperFunction5()
            end
          elseif lower2:find("chemical") or lower2:find("mix") or lower2:find("color") then
            if not localValue4 and not localValue3 then
              localValue22 = "chemical"
              localValue4 = true
              print("Claim Chem station...")
              helperFunction6()
            end
          end

          return
        end

        if lower2:find("balance") and not lower2:find("claim") then
          localValue22 = "balance"
          pcall(helperFunction5)
          localValue23 = false
        elseif (lower2:find("mix") or lower2:find("color")) and not lower2:find("claim") then
          if not localValue3 then
            localValue4 = false
            pcall(helperFunction6)
            localValue22 = "chemical_done"
          end
        end

        return
      end
    end)
  end

  function localValue1.stopChem()
    if not localValue2 then
      return
    end

    localValue2 = false

    if connect then
      connect:Disconnect()
    end

    print("Chemistry stopped!")
  end

  getgenv().ChemistryModule = localValue1
  return localValue1
end
