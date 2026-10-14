return function(ctx)
  --[[
    Fіlе Deоbfusсаteԁ Uѕіng LеаκD
    https://discord.gg/AwGHNh7Z7T
]]

  local players = game:GetService("Players")
  local workspaceService = game:GetService("Workspace")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local localPlayer = players.LocalPlayer
  local spawnedCharacters = workspace:WaitForChild("_game"):WaitForChild("SpawnedCharacters")
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

  local localValue9 = getgenv()
  localValue9._icecream = getgenv()._icecream or {}

  local icecream = getgenv()._icecream

  if icecream.autoFarmRunning then
    icecream:stopAutoFarm()
    task.wait(0.5)
  end

  icecream.autoFarmRunning = false
  icecream.tableObjects = icecream.tableObjects or nil
  icecream.IceCreamCups = icecream.IceCreamCups or nil

  local localValue10 = {
    front_counter = Vector3.new(-253.026, 4.836, -223.23),
    ice_cream_cup = Vector3.new(-263.625, 4.828, -234.154),
    gradient = Vector3.new(-264.953, 5.296, -229.241),
    topping = Vector3.new(-260.417, 4.808, -237.638),
  }

  local humanoid = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "Humanoid"
  )

  local function helperFunction1(parameter1, parameter2)
    local findFirstChild

    repeat
      findFirstChild = parameter1:FindFirstChild(parameter2)
      task.wait(0.2)
    until findFirstChild

    return findFirstChild
  end

  local function helperFunction2(parameter3)
    local bindableEvent = Instance.new("BindableEvent")
    local moveToFinished = humanoid.MoveToFinished

    local connect

    connect = moveToFinished:Connect(function(parameter4)
      connect:Disconnect()
      bindableEvent:Fire(parameter4)
    end)

    humanoid:MoveTo(parameter3)
    local localValue11, localValue12 = pcall(function()
      return bindableEvent.Event:Wait()
    end)
    task.wait(0.3)
    return localValue11 and localValue12
  end

  local function helperFunction3()
    if icecream.tableObjects and icecream.IceCreamCups then
      return icecream.tableObjects, icecream.IceCreamCups
    else
      local localValue13 = helperFunction1(
        workspaceService.Environment.Locations.Beach.BensIceCream.Interior,
        "TableObjects"
      )

      local localValue14 = helperFunction1(localValue13, "IceCreamCups")

      icecream.tableObjects = localValue13
      icecream.IceCreamCups = localValue14

      return localValue13, localValue14
    end
  end

  local function helperFunction4()
    local character = localPlayer.Character

    if not character then
      return nil
    else
      local iceCreamCup = character:FindFirstChild("Ice Cream Cup")

      if not iceCreamCup then
        return nil
      else
        local ball1 = iceCreamCup:FindFirstChild("Ball1")
        local ball2 = iceCreamCup:FindFirstChild("Ball2")

        if ball1 and ball1.Transparency == 1 then
          return ball1
        end

        if ball2 and ball2.Transparency == 1 then
          return ball2
        end

        return nil
      end
    end
  end

  local function helperFunction5(parameter5)
    local customerTargets =
      workspaceService.Environment.Locations.Beach.BensIceCream:FindFirstChild("CustomerTargets")

    if customerTargets then
      for index, value in ipairs(customerTargets:GetChildren()) do
        local occupied = value:FindFirstChild("Occupied")

        if occupied and occupied.Value == parameter5 then
          return value
        end
      end

      return nil
    end

    return nil
  end

  function GoToWork(parameter6, name)
    local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )

    if not parameter6 then
      return
    end

    if (humanoidRootPart.Position - parameter6).Magnitude >= 30 then
      localValue1.ToWork:InvokeServer({ Name = name })
    end
  end

  function icecream.startAutoFarm(parameter7)
    if parameter7.autoFarmRunning then
      return
    else
      GoToWork(
        Vector3.new(-259.51312255859, 4.8369879722595, -231.52067565918),
        "BensIceCreamSeller"
      )

      parameter7.autoFarmRunning = true
      local tableObjects, iceCreamCups = helperFunction3()

      parameter7.tableObjects = tableObjects
      parameter7.IceCreamCups = iceCreamCups

      task.spawn(function()
        while parameter7.autoFarmRunning do
          local localValue15 = {}

          for key, value2 in pairs(spawnedCharacters:GetChildren()) do
            if value2.Name == "BensIceCreamCustomer" and value2:FindFirstChild("Order") then
              table.insert(localValue15, value2)
            end
          end

          if #localValue15 == 0 then
            helperFunction2(localValue10.front_counter)
            task.wait(2)
          else
            helperFunction2(localValue10.front_counter)

            for index2, value3 in ipairs(localValue15) do
              if not parameter7.autoFarmRunning then
                break
              else
                local order = value3:FindFirstChild("Order")

                if not order then
                else
                  local value4 = order:FindFirstChild("Flavor1") and order.Flavor1.Value
                  local value5 = order:FindFirstChild("Flavor2") and order.Flavor2.Value
                  local value6 = order:FindFirstChild("Topping") and order.Topping.Value

                  if not value4 or not value5 then
                  else
                    helperFunction2(localValue10.ice_cream_cup)
                    task.wait(0.5)
                    helperFunction2(localValue10.gradient)
                    local localValue16 = helperFunction4()

                    if localValue16 then
                      localValue1.AddIceCreamScoop:FireServer({
                        Type = "AddIceCreamScoop",
                        Taste = value4,
                        Ball = localValue16,
                      })

                      localValue16.Transparency = 0
                    end

                    task.wait(0.2)
                    local localValue17 = helperFunction4()

                    if localValue17 then
                      localValue1.AddIceCreamScoop:FireServer({
                        Type = "AddIceCreamScoop",
                        Taste = value5,
                        Ball = localValue17,
                      })

                      localValue17.Transparency = 0
                    end

                    task.wait(0.2)

                    if value6 and value6 ~= "" then
                      helperFunction2(localValue10.topping)

                      localValue1.AddIceCreamTopping:FireServer({
                        Type = "AddIceCreamTopping",
                        Taste = value6,
                      })

                      task.wait(0.2)
                    end

                    helperFunction2(localValue10.front_counter)
                    task.wait()
                    local localValue18 = helperFunction5(value3)

                    if localValue18 then
                      localValue1.JobCompleted:FireServer({
                        Type = "JobCompleted",
                        Workstation = localValue18,
                      })
                      local iceCreamCup2 = localPlayer.Character:FindFirstChild("Ice Cream Cup")

                      if iceCreamCup2 then
                        iceCreamCup2:Destroy()
                      end
                    end

                    task.wait(1.5)
                  end
                end
              end
            end
          end

          task.wait(1.5)
        end
      end)

      return
    end
  end

  function icecream:stopAutoFarm()
    self.autoFarmRunning = false
  end

  getgenv()._icecream = icecream
  return icecream
end
