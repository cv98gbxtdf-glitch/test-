---@source Lua Ѕсrірt Dеоbfuѕсаted By LeаκD
---@see https://discord.gg/AwGHNh7Z7T

local pathfindingService = game:GetService("PathfindingService")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local localValue1 = {}
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

localPlayer.CharacterAdded:Connect(function(character2)
  character = character2
  humanoid = character2:WaitForChild("Humanoid")
  humanoidRootPart = character2:WaitForChild("HumanoidRootPart")
end)

local label = localPlayer.PlayerGui:WaitForChild("TimeGui").TimeContainer.Time.Label
local suffix = localPlayer.PlayerGui.TimeGui.TimeContainer.Time.Suffix

local localValue2 = {
  chem = true,
  lang = true,
  art = true,
  phys = true,
}

local localValue3 = {}
local localValue4 = 0

local localValue5 = {
  Science = {
    id = "chem",
    moduleName = "Chem",
    pos = Vector3.new(963.63, 47.19, -266.29),
    waitPos = Vector3.new(980.94, 47.19, -265.74),
  },
  Gym = {
    id = "phys",
    moduleName = "Physical",
    pos = Vector3.new(1042.2, 27.22, -185.61),
    waitPos = Vector3.new(996.18, 27.19, -186.96),
  },
  Art = {
    id = "art",
    moduleName = "Art",
    pos = Vector3.new(960.7, 27.19, -253.26),
    waitPos = Vector3.new(980.42, 27.19, -252.6),
  },
  Language = {
    id = "lang",
    moduleName = "Language",
    pos = Vector3.new(962.41, 47.19, -252.35),
    waitPos = Vector3.new(978.78, 47.19, -252.32),
  },
}

local function helperFunction1()
  if tick() - localValue4 < 60 then
    return
  end

  function localValue951()
    local timeSlotContainer =
      localPlayer.PlayerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages.SchoolSchedulePage.CanvasGroup.SchoolClassSchedule.FrameTimeSlot.TimeSlotContainer

    if not timeSlotContainer then
      return
    end

    localValue3 = {}

    for index, value in ipairs(timeSlotContainer:GetChildren()) do
      if value:IsA("Frame") and value.Name:find("TimeSlot_") then
        local frame1 = value:FindFirstChild("Frame1")
        local classLabel = frame1 and frame1:FindFirstChild("ClassLabel")
        local timeLabel = frame1 and frame1:FindFirstChild("TimeLabel")

        if classLabel and timeLabel and classLabel.Text ~= "" then
          local text = classLabel.Text
          local localValue6 = nil

          for key, value2 in pairs(localValue5) do
            if text:find(key) then
              localValue6 = key
              break
            end
          end

          if localValue6 then
            local localValue7, localValue8, localValue9 =
              timeLabel.Text:match("(%d+):(%d+)%s*([APM]+)")

            if localValue7 and localValue8 and localValue9 then
              local localValue10 = tonumber(localValue7)
              local localValue11 = tonumber(localValue8)

              if localValue9 == "PM" and localValue10 ~= 12 then
                localValue10 = localValue10 + 12
              end

              if localValue9 == "AM" and localValue10 == 12 then
                localValue10 = 0
              end

              table.insert(
                localValue3,
                { key = localValue6, startTime = localValue10 * 60 + localValue11 }
              )
            end
          end
        end
      end
    end

    table.sort(localValue3, function(parameter1, parameter2)
      return parameter1.startTime < parameter2.startTime
    end)
  end

  localValue4 = tick()
end

local localValue12 = { currentSubject = nil, movedToClass = false, runningModule = false }

local function helperFunction2()
  local localValue13 = ""

  if localValue13 == "" then
    local text2 = label.Text
    local text3 = suffix.Text

    if text2 and text2 ~= "" then
      localValue13 = text2 .. " " .. text3
    end
  end

  local localValue14, localValue15, localValue16 =
    string.match(localValue13, "(%d+):(%d+)%s*([APM]+)")

  if not localValue14 then
    return 0, 0
  else
    local localValue17 = tonumber(localValue14) or 0
    local localValue18 = tonumber(localValue15) or 0

    if localValue16 == "PM" and localValue17 ~= 12 then
      localValue17 = localValue17 + 12
    end

    if localValue16 == "AM" and localValue17 == 12 then
      localValue17 = 0
    end

    return localValue17, localValue18
  end
end

local localValue19 = false

local function helperFunction3()
  local mainGUI = localPlayer.PlayerGui:FindFirstChild("MainGUI")

  if not mainGUI then
    return
  end

  for key2, value3 in pairs({ "ClassResultsPopup", "MaxLevelClassResultsPopup" }) do
    local findFirstChild = mainGUI:FindFirstChild(value3)

    if
      findFirstChild
      and findFirstChild:FindFirstChild("ClassResultsFrame")
      and findFirstChild.ClassResultsFrame.Visible
    then
      local closeButton =
        findFirstChild.ClassResultsFrame.CanvasGroup.Header:FindFirstChild("CloseButton")

      if closeButton then
        if firesignal then
          firesignal(closeButton.Activated)
        else
          for key3, value4 in pairs(getconnections(closeButton.Activated)) do
            value4:Fire()
          end
        end
      end
    end
  end
end

local helperFunction4

local function helperFunction5(parameter3, parameter4)
  local vector = parameter4

  local localValue20, localValue21 = pcall(function()
    vector = vector or Vector3.new(0, 0, 0)

    if not (humanoid and humanoidRootPart) then
      return false
    else
      local localValue22 = parameter3 + vector

      local path = pathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
        AgentCanClimb = false,
      })

      path:ComputeAsync(humanoidRootPart.Position, localValue22)

      if path.Status ~= Enum.PathStatus.Success then
        humanoid:MoveTo(localValue22)
        return false
      end

      for index2, value5 in ipairs(path:GetWaypoints()) do
        if value5.Action == Enum.PathWaypointAction.Jump then
          humanoid.Jump = true
          task.wait(0.15)
        end

        local vector2 = Vector3.new(value5.Position.X, value5.Position.Y, value5.Position.Z)
        humanoid:MoveTo(vector2)

        if not humanoid.MoveToFinished:Wait() then
          helperFunction4(vector2)
          task.wait(0.1)
        end

        if (humanoidRootPart.Position - localValue22).Magnitude < 3 then
          break
        end
      end

      task.wait(0.3)
      return true
    end
  end)

  return localValue20 and localValue21
end

function helperFunction4_1(parameter5, parameter6)
  if not humanoidRootPart then
    return
  else
    local vector3 = parameter6
    vector3 = parameter6 or Vector3.new(0, 2, -4)

    local localValue23 = humanoidRootPart
    local localValue24 = parameter5 + vector3
    local magnitude = (localValue23.Position - localValue24).Magnitude
    local localValue25 = math.clamp(magnitude / 23, 0.3, 4)
    local cframe = humanoidRootPart.CFrame
    local cframe2 = CFrame.new(localValue24, localValue24 + cframe.LookVector)
    local canCollide = humanoidRootPart.CanCollide
    humanoidRootPart.CanCollide = false

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(localValue25, Enum.EasingStyle.Linear),
      { CFrame = cframe2 }
    )

    create:Play()
    create.Completed:Wait()

    humanoidRootPart.CanCollide = canCollide
    return
  end
end

task.spawn(function()
  while task.wait(0.5) do
    pcall(function()
      helperFunction3()
    end)
  end
end)

local wereToolsModules

local function helperFunction6()
  if not wereToolsModules then
    return
  end

  getgenv().ChemistryModule.stopChem()
  getgenv().LanguageModule.stopLanguage()
  getgenv().ArtModule.stopArt()
  getgenv().BasketballFarm.stopPhysics()

  localValue12.runningModule = false
end

local function helperFunction7()
  local localValue26 = {
    isActive = false,
    subject = nil,
    isBreak = false,
    timeLeft = "00:00",
  }

  pcall(function()
    local textLabelA =
      localPlayer.PlayerGui.TopbarGui.Topbar.Header.SchoolHeader.SchoolFrameTop:FindFirstChild(
        "TextLabelA"
      )

    if textLabelA and textLabelA.Text ~= "" then
      local localValue27 = string.gsub(textLabelA.Text, "<[^>]+>", "")
      localValue26.timeLeft = string.match(localValue27, "(%d+:%d+)") or "00:00"

      if string.find(string.lower(localValue27), "break") then
        localValue26.isBreak = true
      else
        for key4, value6 in pairs(localValue5) do
          if string.find(string.lower(localValue27), string.lower(key4)) then
            localValue26.subject = key4

            if localValue26.timeLeft ~= "00:00" then
              localValue26.isActive = true
            end

            break
          end
        end
      end
    end
  end)

  return localValue26
end

local helperFunction8

local function helperFunction9()
  if not localValue19 then
    return
  end

  wereToolsModules = _G.WereToolsModules

  if not wereToolsModules then
    return
  else
    helperFunction3()
    helperFunction8()
    local localValue28 = helperFunction7()

    if localValue28.isActive and localValue28.subject then
      local subject = localValue28.subject

      if not localValue12.runningModule and localValue2[localValue5[subject].id] then
        local moduleName = localValue5[subject].moduleName
        print("Starting : " .. moduleName .. " Flow")

        if moduleName == "Chem" then
          getgenv().ChemistryModule.startChem()
        elseif moduleName == "Physical" then
          getgenv().BasketballFarm.startPhysics()
        elseif moduleName == "Art" then
          getgenv().ArtModule.startArt()
        elseif moduleName == "Language" then
          getgenv().LanguageModule.startLanguage()
        end

        localValue12.runningModule = true
      end
    elseif localValue12.runningModule then
      helperFunction6()
      print("Class ended from UI Countdown! Stopping modules.")
      localValue12.runningModule = false
    end

    return
  end
end

function helperFunction8()
  if not humanoidRootPart then
    return
  else
    helperFunction1()
    local localValue29, localValue30 = helperFunction2()
    local localValue31 = localValue29 * 60 + localValue30
    local localValue32 = helperFunction7()
    local subject2 = nil
    local localValue33 = false

    if localValue32.isActive and localValue32.subject then
      subject2 = localValue32.subject
    else
      for index3, value7 in ipairs(localValue3) do
        local localValue34 = value7.startTime - localValue31

        if localValue34 > 0 and localValue34 <= 30 then
          subject2 = value7.key
          localValue33 = true
          break
        end
      end
    end

    if subject2 and localValue2[localValue5[subject2].id] then
      localValue12.currentSubject = subject2
      local pos = localValue5[subject2].pos

      if localValue33 and localValue5[subject2].waitPos then
        pos = localValue5[subject2].waitPos
      end

      if (humanoidRootPart.Position - pos).Magnitude > 15 then
        if
          not localValue12.movedToClass
          or localValue12.currentSubject ~= localValue12.lastSubjectMoved
        then
          print("Moving to " .. subject2 .. (localValue33 and " (Prep)" or " (Class)"))
          helperFunction5(pos)

          localValue12.movedToClass = true
          localValue12.lastSubjectMoved = subject2
        end
      else
        localValue12.movedToClass = true
      end
    else
      localValue12.currentSubject = nil
      localValue12.movedToClass = false
    end

    return
  end
end

function localValue1.setOption(parameter7, parameter8)
  localValue2[parameter7] = parameter8
end

function localValue1.startController()
  if localValue19 then
    return
  end

  localValue19 = true

  task.spawn(function()
    while localValue19 do
      helperFunction9()
      task.wait(1)
    end
  end)
end

function localValue1.stopController()
  localValue19 = false
  helperFunction6()
  localValue12 = { currentSubject = nil, movedToClass = false, runningModule = false }
end

return localValue1
