return function(ctx)
  -- [ LeakD ] Thіѕ Ѕсrіpt Ԝаs Dеоbfuѕсаtеԁ Ву LеаκD
  -- [ Source ] https://discord.gg/AwGHNh7Z7T

  local tweenService = game:GetService("TweenService")
  local players = game:GetService("Players")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local localValue1 = {}
  local localValue2 = false
  local localValue3 = false
  local dataService = replicatedStorage.Modules.DataService
  local localPlayer = players.LocalPlayer
  local localValue4 = {}
  local localValue5 = getconnections(dataService.DescendantAdded)[1].Function
  local localValue6 = getupvalue(localValue5, 1)
  local localValue7 = next
  local localValue8, localValue9 = getupvalue(getupvalue(localValue5, 2), 1)

  for localValue10, localValue11 in localValue7, localValue8, localValue9 do
    local sub = localValue11:sub(1, 2) == "F_" and localValue11:sub(3) or localValue11
    localValue4[sub] = localValue6[localValue10]
  end

  local localPlayer2 = players.LocalPlayer

  local character = localPlayer2.Character or localPlayer2.CharacterAdded:Wait()
  character:WaitForChild("Humanoid")

  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

  local cframe = CFrame.new(
    -345.704285,
    -7.13671541,
    -113.191078,
    -0.0765071884,
    5.08329876e-8,
    0.997069001,
    5.79388759e-9,
    1,
    -5.05378388e-8,
    -0.997069001,
    1.91039762e-9,
    -0.0765071884
  )

  local function helperFunction1()
    for index, value in ipairs(workspace:GetDescendants()) do
      if
        value:IsA("Model")
        and value:FindFirstChild("Fishing Rod")
        and value.Name == localPlayer2.Name
      then
        return value:FindFirstChild("Fishing Rod")
      end
    end

    return nil
  end

  local function helperFunction2()
    local localValue12

    repeat
      if
        not pcall(function()
          localValue12 = require(localPlayer2.PlayerScripts.Modules._UI.HUDHandler)
        end) or not localValue12
      then
        task.wait(0.1)
      end
    until localValue12

    return localValue12
  end

  local function helperFunction3(parameter1)
    local hotbarUI = parameter1 and parameter1.HotbarUI

    if not hotbarUI then
      return
    else
      local equipData = hotbarUI.EquipData

      if not equipData or type(equipData.Function) ~= "function" then
        return
      else
        local localValue13, localValue14 = pcall(equipData.Function)

        if localValue13 then
          print("[AutoFishing] Used equipped item")
        else
          warn("[AutoFishing] Error using item:", localValue14)
        end

        return
      end
    end
  end

  local localValue15

  local function helperFunction4(parameter2, parameter3)
    if localValue3 then
      return
    end

    localValue3 = true

    localValue15 = task.spawn(function()
      while localValue2 and parameter3.Value == Vector3.zero do
        print("[AutoFishing] Pos is zero, retrying...")
        helperFunction3(parameter2)
        task.wait(1)
      end

      localValue3 = false
    end)
  end

  function GoToWork(parameter4, name)
    local humanoidRootPart2 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )

    if not parameter4 then
      return
    end

    if (humanoidRootPart2.Position - parameter4).Magnitude >= 100 then
      localValue4.ToWork:InvokeServer({ Name = name })
    end
  end

  local function helperFunction5()
    task.spawn(function()
      while localValue2 do
        if (humanoidRootPart.Position - cframe.Position).Magnitude > 8 then
          print("[AutoFishing] Too far from fishing spot, re-tweening...")

          local create = tweenService:Create(
            humanoidRootPart,
            TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { CFrame = cframe }
          )

          create:Play()
          create.Completed:Wait()
        end

        task.wait(2)
      end
    end)
  end

  local connect

  local function helperFunction6()
    local localValue16 = helperFunction2()
    local localValue17 = helperFunction1()
    assert(localValue17, "Fishing Rod not found for local player in workspace.")
    local pos = localValue17:WaitForChild("Pos")
    local value2 = pos.Value

    if value2 == Vector3.zero then
      task.wait(1)
      helperFunction4(localValue16, pos)
    end

    helperFunction5()

    connect = pos:GetPropertyChangedSignal("Value"):Connect(function()
      if not localValue2 then
        return
      else
        local value3 = pos.Value

        if value3 == Vector3.zero then
          helperFunction4(localValue16, pos)
        elseif value3.Y ~= value2.Y and value3.X == value2.X and value3.Z == value2.Z then
          print("[AutoFishing] Y changed (X,Z same), using item")
          helperFunction3(localValue16)
        end

        value2 = value3
        return
      end
    end)
  end

  function localValue1.startAutoFarm()
    if localValue2 then
      localValue1.stopAutoFarm()
      task.wait(0.3)
    end

    GoToWork(Vector3.new(-269.69891357422, 4.8776969909668, -103.50131225586), "HutFisherman")
    localValue2 = true

    local create2 = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
      { CFrame = cframe }
    )

    create2:Play()
    create2.Completed:Wait()

    helperFunction6()
    print("[AutoFishing] Started")
  end

  function localValue1.stopAutoFarm()
    localValue2 = false

    if connect then
      connect:Disconnect()
      connect = nil
    end

    if localValue15 then
      task.cancel(localValue15)
      localValue15 = nil
    end

    localValue3 = false
    print("[AutoFishing] Stopped")
  end

  return localValue1
end
