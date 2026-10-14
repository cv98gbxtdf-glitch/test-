return function(ctx)
  ---@source Luа Ѕсriрt Deоbfusсateԁ Ву LеаκD
  ---@see https://discord.gg/AwGHNh7Z7T

  local pathfindingService = game:GetService("PathfindingService")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local players = game:GetService("Players")
  local localValue1 = {}
  local localValue2 = false
  local localPlayer = players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoid = character:WaitForChild("Humanoid")
  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

  local localValue3 = {
    Characters = {
      { Name = "Zebra", IconImageId = "rbxassetid://91210001460302" },
      { Name = "Tiger", IconImageId = "rbxassetid://101084196373782" },
      { Name = "Crocodile", IconImageId = "rbxassetid://104038957915818" },
      { Name = "Elephant", IconImageId = "rbxassetid://97545614493456" },
      { Name = "Monkey", IconImageId = "rbxassetid://112996185791197" },
    },
    Verbs = {
      { Name = "smells", IconImageId = "rbxassetid://88464012476224" },
      { Name = "sees", IconImageId = "rbxassetid://116847551520607" },
      { Name = "hears", IconImageId = "rbxassetid://106986142737060" },
      { Name = "tastes", IconImageId = "rbxassetid://81191388836995" },
      { Name = "touches", IconImageId = "rbxassetid://73829971701982" },
    },
    Objects = {
      { Name = "Flower", IconImageId = "rbxassetid://103927789736683" },
      { Name = "Coconut", IconImageId = "rbxassetid://127085021172665" },
      { Name = "Banana", IconImageId = "rbxassetid://131209221366158" },
      { Name = "Honeycomb", IconImageId = "rbxassetid://127690410704269" },
      { Name = "Grapes", IconImageId = "rbxassetid://122995339272910" },
    },
    Environments = {
      { Name = "Beach", IconImageId = "rbxassetid://127984405953188" },
      { Name = "Jungle", IconImageId = "rbxassetid://106608957341672" },
      { Name = "Mountain", IconImageId = "rbxassetid://109626247552372" },
      { Name = "Savannah", IconImageId = "rbxassetid://98605424273299" },
      { Name = "Swamp", IconImageId = "rbxassetid://108136866165352" },
    },
  }

  local helperFunction1

  local function helperFunction2(parameter1)
    return (
      helperFunction1(parameter1):gsub("^(a%s+)", ""):gsub("^(an%s+)", ""):gsub("^(the%s+)", "")
    )
  end

  function helperFunction1(parameter2)
    return (parameter2 or "")
      :lower()
      :gsub("<[^>]->", "")
      :gsub("%s+", " ")
      :gsub("^%s+", "")
      :gsub("%s+$", "")
  end

  local function helperFunction3(parameter3)
    return (
      helperFunction1(parameter3)
        :gsub("^(in%s+the%s+)", "")
        :gsub("^(on%s+the%s+)", "")
        :gsub("^(at%s+the%s+)", "")
        :gsub("^(into%s+the%s+)", "")
        :gsub("^(inside%s+the%s+)", "")
        :gsub("^(in%s+)", "")
        :gsub("^(on%s+)", "")
        :gsub("^(at%s+)", "")
        :gsub("^(into%s+)", "")
        :gsub("^(inside%s+)", "")
        :gsub("^(the%s+)", "")
    )
  end

  local function helperFunction4(parameter4, parameter5)
    local localValue4 = parameter4.Position - humanoidRootPart.Position

    if localValue4.Magnitude < 2 then
      return true
    else
      local unit = localValue4.Unit

      local path = pathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
      })

      path:ComputeAsync(humanoidRootPart.Position, parameter4.Position - unit * (parameter5 or 6))

      if path.Status ~= Enum.PathStatus.Success then
        return false
      end

      for index, value in ipairs(path:GetWaypoints()) do
        humanoid:MoveTo(value.Position)

        if not humanoid.MoveToFinished:Wait() then
          return false
        end
      end

      return true
    end
  end

  local function helperFunction5()
    local localValue5 =
      getconnections(replicatedStorage.Modules.DataService.DescendantAdded)[1].Function
    local localValue6 = getupvalue(localValue5, 1)
    local localValue7 = {}

    for key, value2 in next, getupvalue(getupvalue(localValue5, 2), 1), nil do
      local sub = value2:sub(1, 2) == "F_" and value2:sub(3) or value2
      localValue7[sub] = localValue6[key]
    end

    return localValue7
  end

  local localValue8 = helperFunction5()

  local function helperFunction6(stationName)
    localValue8.AttemptClaimStation:FireServer({
      StationName = stationName,
      TaskType = "T_WriteEssay",
    })
  end

  local frameText

  local function helperFunction7()
    for i = 1, 30 do
      task.wait(0.15)

      if frameText and frameText:FindFirstChild("TextLabel1") then
        return true
      end
    end

    return false
  end

  local function helperFunction8(parameter6, parameter7)
    local localValue9 = helperFunction1(parameter7)
    local localValue10 = localValue3[parameter6]

    if not localValue10 then
      return false
    end

    for index2, value3 in ipairs(localValue10) do
      local localValue11 = helperFunction1(value3.Name)

      if
        localValue11 == localValue9
        or localValue11:find(localValue9)
        or localValue9:find(localValue11)
      then
        localValue8.SubmitLanguageSelection:FireServer({
          Category = parameter6,
          SelectedIconImageId = value3.IconImageId,
        })

        task.wait(0.3)
        return true
      end
    end

    return false
  end

  local localValue12

  local function helperFunction9()
    local localValue13

    if not localValue12 then
      return
    else
      local localValue14 = { "Characters", "Verbs", "Objects", "Environments" }

      for index3, value4 in ipairs({
        frameText.TextLabel1,
        frameText.TextLabel2,
        frameText.TextLabel3,
        frameText.TextLabel4,
      }) do
        if not localValue2 then
          return
        else
          local localValue15 = helperFunction1(value4.Text or "")

          if index3 ~= 4 then
            localValue13 = helperFunction2(localValue15)
          else
            localValue13 = helperFunction3(localValue15)
          end

          if localValue13 ~= "" then
            print(
              string.format(
                "Language: Submitting [%s] for Category [%s]",
                localValue13,
                localValue14[index3]
              )
            )
            helperFunction8(localValue14[index3], localValue13)
          end
        end
      end

      return
    end
  end

  function localValue1.startLanguage()
    if localValue2 then
      return
    else
      localValue2 = true
      print("Auto Language Start")
      local gameplay =
        workspace.Environment.Locations.SchoolArea.School.Interior.Floor2.Language.Interior.Gameplay
      local localValue16 = {}

      for j = 1, 12 do
        local findFirstChild = gameplay:FindFirstChild("SchoolChairAndDesk" .. j)

        if findFirstChild then
          table.insert(localValue16, findFirstChild)
        end
      end

      if #localValue16 == 0 then
        warn("cannot find any chair")
        localValue2 = false
        return
      end

      for k = 1, #localValue16 do
        local localValue17 = localValue16[math.random(1, #localValue16)]
        print("Try chair:", localValue17.Name)
        local main = localValue17:FindFirstChild("Main")

        if not main then
          print("❌ Chair has no Main part:", localValue17.Name)
        elseif not helperFunction4(main, 5) then
        else
          task.wait(2)
          helperFunction6(localValue17.Name)

          local waitForChild = localPlayer
            :WaitForChild("PlayerGui")
            :WaitForChild("MainGUI")
            :WaitForChild("LanguageClassGui", 5)

          if not waitForChild then
            warn("❌ Error: LanguageClassGui not found in PlayerGui")
            localValue12 = nil
          else
            local localValue18 = false

            for m = 1, 30 do
              if waitForChild.Enabled then
                localValue18 = true
                break
              end

              task.wait(0.1)
            end

            if not localValue18 then
              warn(
                "❌ Error: LanguageClassGui is not enabled (Enabled = false) at chair:",
                localValue17.Name
              )

              localValue12 = nil
            else
              local waitForChild2 = waitForChild:WaitForChild("LanguageMainFrame", 5)

              if waitForChild2 then
                localValue12 = waitForChild2
                frameText = localValue12:WaitForChild("FrameMiddle"):WaitForChild("FrameText")

                localValue12:WaitForChild("FrameLeft"):WaitForChild("FrameCharacters")
                localValue12:WaitForChild("FrameLeft"):WaitForChild("FrameVerbs")
                localValue12:WaitForChild("FrameRight"):WaitForChild("FrameObjects")
                localValue12:WaitForChild("FrameRight"):WaitForChild("FrameEnvironments")
              else
                warn("❌ Error: LanguageMainFrame not found")
                localValue12 = nil
              end
            end
          end

          if localValue12 and helperFunction7() then
            print("Claim: ", localValue17.Name)
            break
          end

          print("Claim fail:", localValue17.Name, "retry other station")
          localValue12 = nil
        end
      end

      if not localValue12 then
        warn("Cannot claim station, stop")
        localValue2 = false
        return
      end

      task.spawn(function()
        while localValue2 do
          helperFunction9()
          task.wait(2)
        end
      end)

      return
    end
  end

  function localValue1.stopLanguage()
    if not localValue2 then
      return
    end

    localValue2 = false
    print("Auto Language STOPPED")
  end

  getgenv().LanguageModule = localValue1
  return localValue1
end
