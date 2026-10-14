return function(ctx)
  -- Fіlе Deоbfuѕсаted Usіng LеаκD
  -- https://discord.gg/AwGHNh7Z7T

  local tweenService = game:GetService("TweenService")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local players = game:GetService("Players")
  local localValue1 = {}
  local localPlayer = players.LocalPlayer
  local localValue2 = false
  local localValue3 = {}
  local dataService = replicatedStorage:WaitForChild("Modules"):WaitForChild("DataService")

  local localValue4, localValue5 = pcall(function()
    return getconnections(dataService.DescendantAdded)[1].Function
  end)

  if localValue4 and localValue5 then
    local localValue6 = getupvalue(localValue5, 1)
    local localValue7 = next
    local localValue8, localValue9 = getupvalue(getupvalue(localValue5, 2), 1)

    for localValue10, localValue11 in localValue7, localValue8, localValue9 do
      local sub = localValue11:sub(1, 2) == "F_" and localValue11:sub(3) or localValue11
      localValue3[sub] = localValue6[localValue10]
    end
  else
    warn("Cannot get Remotes!")
  end

  local function helperFunction1(parameter1)
    local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
      "HumanoidRootPart"
    )
    local getPivot

    if parameter1:IsA("Model") then
      getPivot = parameter1:GetPivot()
    else
      getPivot = parameter1.CFrame
    end

    local localValue12 = getPivot + Vector3.new(0, 3, 0)
    local magnitude = (humanoidRootPart.Position - localValue12.p).Magnitude
    humanoidRootPart.Anchored = true

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(magnitude / 16, Enum.EasingStyle.Linear),
      { CFrame = localValue12 }
    )

    create:Play()
    create.Completed:Wait()

    humanoidRootPart.Anchored = false
  end

  local localValue13

  local function helperFunction2()
    if not localValue13 then
      return warn("Please select target player!")
    else
      local localValue14 = "Plot_" .. localValue13
      local findFirstChild = workspace.Plots:FindFirstChild(localValue14)

      if not findFirstChild then
        warn("Cannot find: " .. localValue14)
        return
      else
        local objects = findFirstChild:FindFirstChild("House")
          and findFirstChild.House:FindFirstChild("Objects")

        if not objects then
          return
        else
          local giftWrappingStation = objects:FindFirstChild("Gift Wrapping Station")
          local simplicityDiningTable = objects:FindFirstChild("Simplicity Dining Table")

          if giftWrappingStation then
            helperFunction1(giftWrappingStation)

            if not localValue2 then
              return
            else
              if localValue3.Interact then
                localValue3.Interact:FireServer({
                  Target = giftWrappingStation,
                  Path = "1/P1/P2/P3/P4/P5/P6/P7/P8/P9/P10/P11/P12/P13/97",
                })
              end

              task.wait(1)

              local waitForChild =
                localPlayer:WaitForChild("PlayerGui"):WaitForChild("_GiftSelectFrame", 3)

              if waitForChild then
                if waitForChild:WaitForChild("GiftSelectFrame", 2) then
                  waitForChild.GiftSelectFrame:WaitForChild("Confirm", 2)
                end
              end

              task.wait(10)

              if not localValue2 then
                return
              end
            end
          end

          task.wait(0.5)

          if simplicityDiningTable then
            helperFunction1(simplicityDiningTable)

            if not localValue2 then
              return
            end

            local objectModel = simplicityDiningTable:FindFirstChild("ObjectModel")
            local placeArea = objectModel and objectModel:FindFirstChild("PlaceArea")
            local position = placeArea and placeArea.CFrame.Position or ""

            if localValue3.Interact then
              localValue3.Interact:FireServer({
                Target = simplicityDiningTable,
                Path = "2",
                Pos = position,
              })
            end

            task.wait(2)
            return
          end

          return
        end
      end
    end
  end

  function localValue1.setTarget(parameter2)
    if type(parameter2) == "string" and #parameter2 > 0 then
      localValue13 = parameter2
      return true
    end

    return false
  end

  function localValue1.startAutoWrap()
    local findFirstChild2, localValue15, localValue16

    if localValue2 then
      return
    else
      localValue2 = true
      local wrapgiftAmount = getgenv().WrapgiftAmount or 0
      findFirstChild2 = replicatedStorage:WaitForChild("Stats"):FindFirstChild(localPlayer.Name)
      localValue15 = 0
      localValue16 = wrapgiftAmount > 0

      if localValue16 then
        if findFirstChild2 and findFirstChild2:FindFirstChild("Money") then
          local value = findFirstChild2.Money.Value
          localValue15 = value - wrapgiftAmount
          print(
            "[AutoWrap] Start. Original Money: " .. value .. " | Expected:  <= " .. localValue15
          )
        else
          warn("[AutoWrap] Money value is nil!")
          localValue16 = false
        end
      else
        print("[AutoWrap] WrapgiftAmount is 0 or nil. Running infinitely.")
      end

      task.spawn(function()
        while localValue2 do
          if localValue16 and findFirstChild2 and findFirstChild2:FindFirstChild("Money") then
            if findFirstChild2.Money.Value <= localValue15 then
              print("[AutoWrap] Reached target amount. Stopping.")
              localValue1.stopAutoWrap()
              break
            end
          end

          helperFunction2()
          task.wait(1)
        end
      end)

      return
    end
  end

  function localValue1.stopAutoWrap()
    localValue2 = false
  end

  return localValue1
end
