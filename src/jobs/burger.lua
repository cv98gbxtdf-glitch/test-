return function(ctx)
  --[[
    Sоurcе Cоԁe Dеоbfuѕсаtеԁ Ву LеаκD
    https://discord.gg/AwGHNh7Z7T
]]

  local replicatedStorage = game:GetService("ReplicatedStorage")
  local players = game:GetService("Players")
  local pathfindingService = game:GetService("PathfindingService")
  local runService = game:GetService("RunService")
  local localPlayer = players.LocalPlayer
  local dataService = replicatedStorage.Modules.DataService
  local localValue1 = debug.getupvalue(require(replicatedStorage.Modules.DataService).FireServer, 5)
  local localValue2 = {}
  local localValue3 = getconnections(dataService.DescendantAdded)[1].Function
  local localValue4 = getupvalue(localValue3, 1)
  local localValue5 = next
  local localValue6, localValue7 = getupvalue(getupvalue(localValue3, 2), 1)

  for localValue8, localValue9 in localValue5, localValue6, localValue7 do
    local sub = localValue9:sub(1, 2) == "F_" and localValue9:sub(3) or localValue9
    localValue2[sub] = localValue4[localValue8]
  end

  local localValue10 = {}
  local localValue11 = false
  local localValue12 = {}
  local localValue13 = {}
  local localValue14 = {}

  function invokeServer(parameter1)
    local localValue15 = table.clone(parameter1)
    local localValue16 = localValue1(localValue15.Type, true)

    if not localValue16 then
      return
    end

    localValue15.Type = nil
    return localValue16:InvokeServer(localValue15)
  end

  function clickButton(parameter2, parameter3)
    pcall(function()
      firesignal(players.LocalPlayer.PlayerGui._interactUI.InteractIndicator.Activated)
    end)

    task.wait(1)

    pcall(function()
      firesignal(players.LocalPlayer.PlayerGui._interactUI.Center.Button.Activated)
    end)
  end

  function getCurrentStation(parameter4)
    local huge = math.huge
    local localValue17

    for key, value in pairs(parameter4:GetChildren()) do
      if value:IsA("Model") and value.PrimaryPart then
        local magnitude = (value.PrimaryPart.Position - localPlayer.Character.PrimaryPart.Position).Magnitude
        local localValue18 = magnitude < huge
        local inUse = value:FindFirstChild("InUse")

        if
          localValue18
          and (
            not inUse
            or inUse.Value == nil
            or inUse.Value == false
            or inUse.Value == localPlayer
          )
        then
          localValue17 = value
          huge = magnitude
        end
      end
    end

    return localValue17
  end

  function pathfind(parameter5, parameter6)
    local getControls =
      require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
    getControls:Disable()

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local path

    if type(parameter6) == "table" then
      path = pathfindingService:CreatePath(parameter6)
    else
      path = pathfindingService:CreatePath()
    end

    path:ComputeAsync(humanoidRootPart.Position, parameter5)
    local localValue19, localValue20 = path:GetWaypoints()

    for key2, value2 in next, localValue19, localValue20 do
      humanoid:MoveTo(value2.Position)

      if value2.Action == Enum.PathWaypointAction.Jump then
        humanoid.Jump = true
      end

      humanoid.MoveToFinished:Wait()
    end

    getControls:Enable()
  end

  local currentCamera = workspace.CurrentCamera

  function lookAt(parameter7)
    local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )
    local vector = Vector3.new(parameter7.X, humanoidRootPart2.Position.Y, parameter7.Z)

    humanoidRootPart2.CFrame = CFrame.new(
      humanoidRootPart2.Position,
      humanoidRootPart2.Position + (vector - humanoidRootPart2.Position).Unit
    )

    currentCamera.CFrame = CFrame.new(
      currentCamera.CFrame.Position,
      currentCamera.CFrame.Position + humanoidRootPart2.CFrame.LookVector
    )
  end

  function findCountFromTextLabels(parameter8)
    for index, value3 in ipairs(parameter8:GetChildren()) do
      if value3.ClassName == "TextLabel" then
        local xD = value3.Text:match("^x(%d+)$")

        if xD then
          return tonumber(xD)
        end
      elseif value3.ClassName == "ImageLabel" then
        local localValue21 = findCountFromTextLabels(value3)

        if localValue21 then
          return localValue21
        end
      end
    end

    return 1
  end

  function findSizeFromTextLabels(parameter9)
    for index2, value4 in ipairs(parameter9:GetChildren()) do
      if value4.ClassName == "ImageLabel" then
        for index3, value5 in ipairs(value4:GetChildren()) do
          if value5.ClassName == "TextLabel" and value5.Text:match("^[LSM]$") then
            return value5.Text
          end
        end
      end
    end

    return nil
  end

  getgenv().sideBaseCodes = { fries = 11, moz_sticks = 21, onion_rings = 31 }
  getgenv().drinkBaseCodes = { soda = 11, fruit_juice = 21, milkshake = 31 }
  getgenv().sizeOffsets = { S = 0, M = 1, L = 2 }

  local function helperFunction1()
    for index4, value6 in ipairs(getgc(true)) do
      if typeof(value6) == "function" and islclosure(value6) and not isexecutorclosure(value6) then
        if debug.info(value6, "n") == "loadFrame" then
          localValue14[value6] = true
        end
      end
    end
  end

  function parseFrame(parameter10)
    local localValue22 = {}
    local isBurger = false
    local isDrinkOrSide = false

    local localValue23 = {
      ["rbxassetid://14358866788"] = "patty_left",
      ["rbxassetid://14358886220"] = "patty_right",
      ["rbxassetid://14358865402"] = "lettuce",
      ["rbxassetid://14358884748"] = "tomato",
      ["rbxassetid://14358880695"] = "cheese",
      ["rbxassetid://14467423053"] = "fries",
      ["rbxassetid://14467425084"] = "soda",
      ["rbxassetid://14467509651"] = "moz_sticks",
      ["rbxassetid://14358878251"] = "onion",
      ["rbxassetid://14467511580"] = "onion_rings",
      ["rbxassetid://9555980177"] = "fruit_juice",
      ["rbxassetid://1588110682"] = "milkshake",
    }

    local size

    for index5, value7 in ipairs(parameter10:GetChildren()) do
      if value7.ClassName == "ImageLabel" then
        local localValue24 = localValue23[value7.Image]

        if localValue24 then
          localValue22[localValue24] = (localValue22[localValue24] or 0)
            + (findCountFromTextLabels(value7) or 1)

          if
            localValue24 == "patty_left"
            or localValue24 == "patty_right"
            or localValue24 == "lettuce"
            or localValue24 == "tomato"
            or localValue24 == "cheese"
            or localValue24 == "onion"
          then
            isBurger = true
          elseif
            localValue24 == "fries"
            or localValue24 == "moz_sticks"
            or localValue24 == "onion_rings"
            or localValue24 == "soda"
            or localValue24 == "fruit_juice"
            or localValue24 == "milkshake"
          then
            isDrinkOrSide = true
            size = findSizeFromTextLabels(value7)
          end
        end
      end
    end

    return {
      parts = localValue22,
      isBurger = isBurger,
      isDrinkOrSide = isDrinkOrSide,
      size = size,
    }
  end

  function calculatePattyCount(parameter11)
    local pattyLeft = parameter11.patty_left or 0
    local localValue25 = pattyLeft > 0
    local pattyRight = parameter11.patty_right or 0

    if localValue25 and pattyRight > 0 then
      return -(pattyLeft + pattyRight)
    elseif pattyLeft > 0 then
      return 10 + pattyLeft
    else
      if pattyRight > 0 then
        return 20 + pattyRight
      end

      return 0
    end
  end

  function getSideCode(parameter12, parameter13)
    local localValue26 = sideBaseCodes[parameter12]

    if not localValue26 then
      return nil
    end

    return localValue26 + (sizeOffsets[parameter13] or 0)
  end

  function getDrinkCode(parameter14, parameter15)
    local localValue27 = drinkBaseCodes[parameter14]

    if not localValue27 then
      return nil
    end

    return localValue27 + (sizeOffsets[parameter15] or 0)
  end

  function buildOrderTable(parameter16)
    local localValue28 = { 0, 0, 0, 0, 0, 2 }

    local localValue29 = {
      cheese = 2,
      lettuce = 3,
      tomato = 4,
      onion = 5,
    }

    local localValue30, localValue31

    for index6, value8 in ipairs(parameter16) do
      if value8.isBurger then
        local localValue32 = calculatePattyCount(value8.parts)

        if localValue32 == 0 then
          localValue32 = 11
        end

        localValue28[1] = localValue28[1] + localValue32

        for key3, value9 in pairs(value8.parts) do
          if key3 ~= "patty_left" and key3 ~= "patty_right" then
            local localValue33 = localValue29[key3]

            if localValue33 then
              localValue28[localValue33] = localValue28[localValue33] + value9
            end
          end
        end
      elseif value8.isDrinkOrSide then
        for key4, value10 in pairs(value8.parts) do
          if sideBaseCodes[key4] then
            localValue30 = getSideCode(key4, value8.size)
          elseif drinkBaseCodes[key4] then
            localValue31 = getDrinkCode(key4, value8.size)
          end
        end
      end
    end

    local localValue34 = { { Order = { localValue28 } } }

    if localValue30 then
      localValue34[1].Order[2] = localValue30
    end

    if localValue31 then
      localValue34[1].Order[3] = localValue31
    end

    return localValue34
  end

  local function helperFunction2()
    localValue12 = {}
    localValue13 = {}
    localValue14 = {}
  end

  local helperFunction3

  local function helperFunction4(parameter17)
    pathfind(parameter17.StationPart.Position)
    lookAt(parameter17.InteractionPoint.InteractionPoint.Position)

    repeat
      task.wait(1)
      clickButton("Use Register")
    until parameter17.InUse.Value == localPlayer

    print("got station")
    local value11 = parameter17.Occupied.Value

    if value11 then
      helperFunction3(value11)
    end
  end

  function helperFunction3(parameter18)
    helperFunction2()
    helperFunction1()

    for key5, value12 in pairs(localValue14) do
      if not localValue12[key5] then
        localValue12[key5] = true

        for index7, value13 in ipairs((debug.getupvalues(key5))) do
          if typeof(value13) == "table" and value13.Frames and not localValue13[value13.Frames] then
            localValue13[value13.Frames] = true
            local localValue35 = {}

            for key6, value14 in pairs(value13.Frames) do
              local localValue36 = value14
              local localValue37, localValue38 = pcall(function()
                return parseFrame(localValue36)
              end)

              if localValue37 and localValue38 then
                table.insert(localValue35, localValue38)
              end
            end

            local localValue39 = buildOrderTable(localValue35)

            if typeof(localValue39) == "table" and localValue39[1] and localValue39[1].Order then
              pcall(function()
                invokeServer({ Type = "ConfirmOrderCashier", Order = localValue39[1].Order })
                task.wait(3.5)
              end)
            end
          end
        end
      end
    end
  end

  local function helperFunction5()
    while localValue11 do
      local localValue40 = getCurrentStation(
        workspace.Environment.Locations.City.BloxBurgers.Interior.ScriptableObjects.Cashier.Workstations
      )

      if localValue40 then
        helperFunction4(localValue40)
      end
    end

    task.wait()
  end

  function GoToWork(parameter19, name)
    local humanoidRootPart3 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )

    if not parameter19 then
      return
    else
      local magnitude2 = (humanoidRootPart3.Position - parameter19).Magnitude

      if magnitude2 >= 10 then
        localValue2.ToWork:InvokeServer({ Name = name })
      else
        warn("Too far from job:", magnitude2)
      end

      return
    end
  end

  function localValue10.startAutoFarm()
    if localValue11 then
      print("already running")
      return
    end

    GoToWork(Vector3.new(217.24227905273, 4.5677819252014, 291.65658569336), "BloxBurgersEmployee")

    localValue11 = true
    helperFunction2()
    task.spawn(helperFunction5)
  end

  function localValue10.stopAutoFarm()
    localValue11 = false
    helperFunction2()
    print("stopped")
  end

  return localValue10
end
