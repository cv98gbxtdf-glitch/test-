-- [ LeakD ] Dеоbfuѕcаteԁ Ѕuссеѕѕfully Ву LеаkD
-- [ Source ] https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localValue1 = {}
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local waitForChild = character:WaitForChild("Humanoid", 10)
local dataService = replicatedStorage.Modules.DataService
local localValue2 = {}
local localValue3 = getconnections(dataService.DescendantAdded)[1].Function
local localValue4 = getupvalue(localValue3, 1)
local localValue5 = next
local localValue6, localValue7 = getupvalue(getupvalue(localValue3, 2), 1)

for localValue8, localValue9 in localValue5, localValue6, localValue7 do
  local sub = localValue9:sub(1, 2) == "F_" and localValue9:sub(3) or localValue9
  localValue2[sub] = localValue4[localValue8]
end

function GoToWork(parameter1, name)
  local humanoidRootPart2 = character:WaitForChild("HumanoidRootPart")

  if not parameter1 then
    return
  end

  if (humanoidRootPart2.Position - parameter1).Magnitude >= 30 then
    localValue2.ToWork:InvokeServer({ Name = name })
  end
end

_G.IsAutoFarming = false

local localValue10 = {}
localValue10.do_actions = {}
localValue10.hair_styles = nil
localValue10.hair_colors = nil

local helperFunction1

local function helperFunction2()
  if localValue10.hair_styles and localValue10.hair_colors then
    return true
  end

  helperFunction1()

  if #localValue10.do_actions > 0 then
    localValue10.hair_styles = getupvalue(localValue10.do_actions[1], 6)
    localValue10.hair_colors = getupvalue(localValue10.do_actions[1], 8)

    if localValue10.hair_styles then
      return true
    end

    warn("❌ data game is null.")
    return false
  end

  warn("❌ data game is null.")
  return false
end

function helperFunction1()
  localValue10.do_actions = {}
  local localValue11 = {}
  local localValue12, localValue13 = getgc(true)

  for key, value in next, localValue12, localValue13 do
    if
      typeof(value) == "function"
      and getfenv(value)
      and getfenv(value).script
      and getfenv(value).script.Name == "StylezHairdresser"
      and getinfo(value).name == "doAction"
      and not localValue11[value]
    then
      table.insert(localValue10.do_actions, value)
      localValue11[value] = true
    end
  end
end

local function helperFunction3(parameter2)
  local localValue14, localValue15 = pcall(function()
    local localValue16 = not waitForChild or not parameter2
    local bindableEvent, connect

    if localValue16 then
      return false
    else
      bindableEvent = Instance.new("BindableEvent")

      connect = nil

      connect = waitForChild.MoveToFinished:Connect(function(parameter3)
        if connect then
          connect:Disconnect()
        end

        bindableEvent:Fire(parameter3)
      end)

      waitForChild:MoveTo(parameter2)
      local localValue17, localValue18 = pcall(function()
        return bindableEvent.Event:Wait()
      end)
      task.wait(0.2)
      return localValue17 and localValue18
    end
  end)

  return localValue14 and localValue15 or false
end

local function helperFunction4(parameter4)
  if not parameter4 then
    return
  end

  if firesignal then
    pcall(function()
      firesignal(parameter4.Activated)
    end)
    pcall(function()
      firesignal(parameter4.MouseButton1Click)
    end)
  elseif getconnections then
    local localValue19 = getconnections(parameter4.Activated)

    if localValue19 then
      for key2, value2 in pairs(localValue19) do
        value2:Fire()
      end
    end

    local localValue20 = getconnections(parameter4.MouseButton1Click)

    if localValue20 then
      for key3, value3 in pairs(localValue20) do
        value3:Fire()
      end
    end
  else
    pcall(function()
      parameter4.Activated:Fire()
    end)
  end
end

local function helperFunction5(parameter5)
  if not parameter5 then
    return nil
  else
    local order = parameter5:FindFirstChild("Order")

    if not order then
      return nil
    else
      local value4 = order:FindFirstChild("Style") and order.Style.Value
      local value5 = order:FindFirstChild("Color") and order.Color.Value

      if not value4 or not value5 then
        return nil
      else
        local localValue21 = 1
        local localValue22 = 1

        for index, value6 in ipairs(localValue10.hair_styles) do
          if tostring(value6) == tostring(value4) then
            localValue22 = index
            break
          end
        end

        for index2, value7 in ipairs(localValue10.hair_colors) do
          if tostring(value7) == tostring(value5) then
            localValue21 = index2
            break
          end
        end

        return { styleClicks = localValue22 - 1, colorClicks = localValue21 - 1 }
      end
    end
  end
end

local hairdresserWorkstations

local function helperFunction6()
  local magnitude = 25
  local localValue23 = hairdresserWorkstations
  local localValue24

  for index3, value8 in ipairs(localValue23:GetChildren()) do
    local mat = value8:FindFirstChild("Mat")

    if mat and (humanoidRootPart.Position - mat.Position).Magnitude < magnitude then
      localValue24 = value8
      magnitude = (humanoidRootPart.Position - mat.Position).Magnitude
    end
  end

  local localValue25, localValue26

  if not localValue24 then
    warn("⚠️ Cant find any chair. going closely!")
    task.wait(2)
    return
  else
    local mirror = localValue24:FindFirstChild("Mirror")

    local hairdresserGUI = mirror
    hairdresserGUI = mirror and mirror:FindFirstChild("HairdresserGUI")

    if not hairdresserGUI then
      warn("Error: Cant find GUI")
      return
    else
      local style = hairdresserGUI.Frame:FindFirstChild("Style")
      local color = hairdresserGUI.Frame:FindFirstChild("Color")

      local localValue27 = style
      localValue27 = style and style:FindFirstChild("Next")

      local localValue28 = color
      localValue28 = color and color:FindFirstChild("Next")

      local done = hairdresserGUI.Frame:FindFirstChild("Done")
      local mat2 = localValue24.Mat
      local localValue29 = nil
      local count = 0

      while _G.IsAutoFarming do
        task.wait(0.5)
        count = count + 1

        for key4, value9 in pairs((workspace._game.SpawnedCharacters:GetChildren())) do
          if value9:FindFirstChild("HumanoidRootPart") and value9:FindFirstChild("Order") then
            if (value9.HumanoidRootPart.Position - mat2.Position).Magnitude < 5 then
              localValue29 = value9
              break
            end
          end
        end

        if localValue29 or count > 20 then
          if not localValue29 then
            return
          end

          task.wait(1.5)

          if not _G.IsAutoFarming then
            return
          else
            local localValue30 = helperFunction5(localValue29)

            if localValue30 then
              for i = 1, localValue30.styleClicks do
                if not _G.IsAutoFarming then
                  return
                end

                helperFunction4(localValue27)
                task.wait(0.35)
              end

              task.wait(0.5)

              for j = 1, localValue30.colorClicks do
                if not _G.IsAutoFarming then
                  return
                end

                helperFunction4(localValue28)
                task.wait(0.35)
              end

              task.wait(0.8)

              if _G.IsAutoFarming then
                helperFunction4(done)
              end

              localValue25 = 0

              repeat
                task.wait(0.5)
                localValue25 = localValue25 + 0.5
                local localValue31 = false

                if localValue29.Parent and localValue29:FindFirstChild("HumanoidRootPart") then
                  if (localValue29.HumanoidRootPart.Position - mat2.Position).Magnitude < 6 then
                    localValue31 = true
                  end
                end

                local localValue32 = not localValue31

                localValue26 = localValue32
                localValue26 = localValue32 or localValue25 > 10 or not _G.IsAutoFarming
              until localValue26

              task.wait(1)
              return
            end

            warn("Error getting color/style.")
            localValue25 = 0

            repeat
              task.wait(0.5)
              localValue25 = localValue25 + 0.5
              local localValue33 = false

              if localValue29.Parent and localValue29:FindFirstChild("HumanoidRootPart") then
                if (localValue29.HumanoidRootPart.Position - mat2.Position).Magnitude < 6 then
                  localValue33 = true
                end
              end

              local localValue34 = not localValue33

              localValue26 = localValue34
              localValue26 = localValue34 or localValue25 > 10 or not _G.IsAutoFarming
            until localValue26

            task.wait(1)
            return
          end
        end
      end

      return
    end
  end
end

function localValue1.startAutoFarm()
  if _G.IsAutoFarming then
    warn("Auto Farm already running!")
    return
  end

  GoToWork(Vector3.new(-56.156295776367, 4.4826912879944, -331.23257446289), "StylezHairdresser")

  hairdresserWorkstations =
    workspace.Environment.Locations.City.StylezHairStudio.Interior.HairdresserWorkstations
  _G.IsAutoFarming = true
  print(" Sart AUTO FARM...")
  helperFunction3(Vector3.new(-71.53188, 5.22083, -342.91287))

  task.spawn(function()
    if not helperFunction2() then
      _G.IsAutoFarming = false
      return
    end

    while _G.IsAutoFarming do
      pcall(function()
        helperFunction6()
      end)
      task.wait(0.5)
    end

    print("Stop Auto Farm.")
  end)
end

function localValue1.stopAutoFarm()
  _G.IsAutoFarming = false
  print("Stoping Auto Farm... (waiting current customer)")
end

return localValue1
