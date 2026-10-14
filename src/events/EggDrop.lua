return function(ctx)
  -- ----------------------------------------------------
  -- Luа Ѕсrірt Deobfuѕсаtеԁ Ву LеakD
  -- https://discord.gg/AwGHNh7Z7T
  -- ----------------------------------------------------

  local players = game:GetService("Players")
  local localValue1 = {}
  local localPlayer = players.LocalPlayer
  local localValue2 = false

  local function helperFunction1()
    local localValue3 = workspace:FindFirstChild("_game")

    if not localValue3 then
      return nil
    else
      local eggDropWorldAssets = localValue3:FindFirstChild("EggDropWorldAssets")
      local eggDropArea = eggDropWorldAssets and eggDropWorldAssets:FindFirstChild("EggDropArea")
      local origin = eggDropArea and eggDropArea:FindFirstChild("Origin")
      return origin and origin:FindFirstChild("ClientNodes")
    end
  end

  local function helperFunction2()
    while localValue2 do
      local localValue4 = helperFunction1()

      if not localValue4 then
        task.wait(3)
      else
        local getChildren = localValue4:GetChildren()

        local humanoidRootPart = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
          table.sort(getChildren, function(parameter1, parameter2)
            local origin2 = parameter1:FindFirstChild("EggDropEgg")
              and parameter1.EggDropEgg:FindFirstChild("Origin")

            local origin3 = parameter2:FindFirstChild("EggDropEgg")
              and parameter2.EggDropEgg:FindFirstChild("Origin")

            if not origin2 or not origin3 then
              return false
            end

            return (humanoidRootPart.Position - origin2.Position).Magnitude
              < (humanoidRootPart.Position - origin3.Position).Magnitude
          end)
        end

        for key, value in pairs(getChildren) do
          if not localValue2 then
            break
          else
            local origin4 = value:FindFirstChild("EggDropEgg")
              and value.EggDropEgg:FindFirstChild("Origin")

            if origin4 and origin4:IsA("BasePart") then
              pcall(function()
                pathfind(origin4.Position)
              end)
              task.wait(0.2)
            end
          end
        end

        task.wait(0.5)
      end
    end
  end

  function localValue1.startEasterEgg()
    if localValue2 then
      return
    end

    localValue2 = true
    task.spawn(helperFunction2)
  end

  function localValue1.stopEasterEgg()
    localValue2 = false
  end

  return localValue1
end
