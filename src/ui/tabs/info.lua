return function(env)
  local ctx = env.ctx
  local Library = env.Library
  local SaveManager = env.SaveManager
  local ThemeManager = env.ThemeManager
  local weretoolsWindow = env.window
  local localValue18 = env.tabs
  local players = env.players
  local httpService = env.httpService
  local replicatedStorage = env.replicatedStorage
  local runService = env.runService
  local coreGui = env.coreGui
  local virtualUser = env.virtualUser
  local teleportService = env.teleportService
  local localPlayer = env.localPlayer
  local wereToolsModules = env.modules
  local hairdresser = wereToolsModules.hairdresser
  local burger = wereToolsModules.burger
  local cashier = wereToolsModules.cashier
  local teacher = wereToolsModules.teacher
  local icecream = wereToolsModules.icecream
  local mechanic = wereToolsModules.mechanic
  local miner = wereToolsModules.miner
  local stocker = wereToolsModules.stocker
  local lumber = wereToolsModules.lumber
  local bakery = wereToolsModules.bakery
  local pizza = wereToolsModules.pizza
  local janitor = wereToolsModules.janitor
  local fisher = wereToolsModules.fisher
  local taxi = wereToolsModules.taxi
  local skillModule = wereToolsModules.SkillModule
  local harvest = wereToolsModules.harvest
  local buildModule = wereToolsModules.BuildModule
  local wrapgift = wereToolsModules.wrapgift
  local graphic = wereToolsModules.graphic
  local camera = wereToolsModules.Camera
  local previewBuild = wereToolsModules.PreviewBuild
  local boostModule = wereToolsModules.BoostModule
  local schoolController = wereToolsModules.schoolController
  local localValue2 = env.skillTweaks
  local localValue3 = env.keyRef
  local localValue4 = env.keyType
  local localValue5 = env.isPremium
  local localValue6 = env.cfg
  local localValue16 = env.remotes
  local flags = env.flags
  local dropdowns = env.dropdowns
  local state = env.state
  local auth = env.auth
  local helperFunction1 = env.helpers.notify
  local helperFunction2 = env.helpers.premiumRequired
  local helperFunction3 = env.helpers.requirePremium
  local helperFunction4 = env.helpers.confirmDialog
  local helperFunction5 = env.helpers.jobModules
  local helperFunction6 = env.helpers.parseShiftTime
  local helperFunction7 = env.helpers.findDeep
  local helperFunction8 = env.helpers.disableIdled
  local helperFunction9 = env.helpers.startAntiAfk
  local helperFunction10 = env.helpers.stopAntiAfk
  local helperFunction11 = env.helpers.listPlayers
  local helperFunction12 = env.helpers.pollMood
  local helperFunction14 = env.helpers.listPlotPlayers

  -- ───────── Info Tab ─────────
  local section = localValue18.Info:AddGroupbox({ Side = "Left", Name = "Player Mood Status" })

  local localValue21, localValue22, localValue23, localValue24, localValue25 = helperFunction12()
  local label = section:AddLabel("<b>Overall Mood:</b> " .. localValue21, true)
  local label2 = section:AddLabel("Energy: " .. localValue22 .. "%", true)
  local label3 = section:AddLabel("Fun: " .. localValue23 .. "%", true)
  local label4 = section:AddLabel("Hunger: " .. localValue24 .. "%", true)
  local label5 = section:AddLabel("Hygiene: " .. localValue25 .. "%", true)

  task.spawn(function()
    while task.wait(15) do
      pcall(function()
        local localValue26, localValue27, localValue28, localValue29, localValue30 =
          helperFunction12()
        label:SetText("<b>Overall Mood:</b> " .. localValue26)
        label2:SetText("Energy: " .. localValue27 .. "%")
        label3:SetText("Fun: " .. localValue28 .. "%")
        label4:SetText("Hunger: " .. localValue29 .. "%")
        label5:SetText("Hygiene: " .. localValue30 .. "%")
      end)
    end
  end)

  local section2 = localValue18.Info:AddGroupbox({ Side = "Right", Name = "School Schedule" })

  task.spawn(function()
    pcall(function()
      local playerGui = players.LocalPlayer:FindFirstChild("PlayerGui")
      if not playerGui then
        return
      end
      local topbarGui = playerGui:FindFirstChild("TopbarGui")
      local localValue31 = topbarGui
      if topbarGui then
        local topbar = playerGui.TopbarGui:FindFirstChild("Topbar")
        local localValue32 = topbar
        if topbar then
          local expanded = playerGui.TopbarGui.Topbar:FindFirstChild("Expanded")
          local localValue33 = expanded
          if expanded then
            local canvasGroup = playerGui.TopbarGui.Topbar.Expanded:FindFirstChild("CanvasGroup")
            local timeSlotContainer = canvasGroup
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup:FindFirstChild("TweenContainer")
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer:FindFirstChild(
                "Pages"
              )
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages:FindFirstChild(
                "SchoolSchedulePage"
              )
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages.SchoolSchedulePage:FindFirstChild(
                "CanvasGroup"
              )
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages.SchoolSchedulePage.CanvasGroup:FindFirstChild(
                "SchoolClassSchedule"
              )
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages.SchoolSchedulePage.CanvasGroup.SchoolClassSchedule:FindFirstChild(
                "FrameTimeSlot"
              )
              and playerGui.TopbarGui.Topbar.Expanded.CanvasGroup.TweenContainer.Pages.SchoolSchedulePage.CanvasGroup.SchoolClassSchedule.FrameTimeSlot:FindFirstChild(
                "TimeSlotContainer"
              )
            localValue33 = timeSlotContainer
          end
          localValue32 = localValue33
        end
        localValue31 = localValue32
      end

      local localValue34 = false
      local localValue35 = localValue31
      if localValue35 then
        local localValue36 = {}
        for index4, value7 in ipairs(localValue35:GetChildren()) do
          if
            value7:IsA("GuiObject")
            and string.match(value7.Name, "^TimeSlot_%%d") == nil
            and string.match(value7.Name, "^TimeSlot_%d")
          then
            local frame1 = value7:FindFirstChild("Frame1")
            if frame1 then
              local classLabel = frame1:FindFirstChild("ClassLabel")
              local roomLabel = frame1:FindFirstChild("RoomLabel")
              local localValue37 = classLabel
              local timeLabel = frame1:FindFirstChild("TimeLabel")
              if classLabel then
                localValue37 = roomLabel and timeLabel and classLabel.Text ~= ""
              end
              if localValue37 then
                local text = classLabel.Text
                local localValue38 = "at " .. roomLabel.Text .. " | " .. timeLabel.Text
                local localValue39 = text .. "|" .. localValue38
                if not localValue36[localValue39] then
                  localValue36[localValue39] = true
                  localValue34 = true
                  section2:AddLabel("<b>" .. text .. "</b>\n" .. localValue38, true)
                end
              end
            end
          end
        end
      end
      if not localValue34 then
        section2:AddLabel("<b>Loading...</b>\nGo to school to update calendar!", true)
      end
      return
    end)
  end)

  local section3 = localValue18.Info:AddGroupbox({ Side = "Left", Name = "Job Info" })

  local label6 = section3:AddLabel("Current Job: Loading...", true)
  local label7 = section3:AddLabel("Efficiency: 0%", true)
  local label8 = section3:AddLabel("Shift Earning: $0", true)
  local label9 = section3:AddLabel("Total Earning From this session: $0", true)

  task.spawn(function()
    while task.wait(20) do
      if not flags.running then
        break
      end
      pcall(function()
        local localValue40 = replicatedStorage:FindFirstChild("Stats")
        if localValue40 and localValue40:FindFirstChild(localPlayer.Name) then
          local localValue41 = localValue40[localPlayer.Name]
          local job = localValue41:FindFirstChild("Job")
          if job then
            local value8 = job.Value or "None"
            local value9 = job:FindFirstChild("Efficiency") and job.Efficiency.Value or 0
            local value10 = job:FindFirstChild("ShiftEarnings") and job.ShiftEarnings.Value or 0
            local money = localValue41:FindFirstChild("Money")
            local localValue42 = 0
            if money then
              localValue42 = money.Value - 0
              if localValue42 < 0 then
                localValue42 = 0
              end
            end
            label6:SetText("Current Job: " .. tostring(value8))
            label7:SetText("Efficiency: " .. tostring(value9) .. "%")
            label8:SetText("Shift Earning: $" .. tostring(value10))
            label9:SetText("Total Earning From this session: $" .. tostring(localValue42))
          end
        end
      end)
    end
  end)

  local section4 = localValue18.Info:AddGroupbox({ Side = "Right", Name = "Skill Info" })

  local localValue43 =
    { "Art", "Athletic", "Cooking", "Gaming", "Gardening", "Intelligence", "Music", "Writing" }
  local localValue44 = {}
  for index5, value11 in ipairs(localValue43) do
    localValue44[value11] = section4:AddLabel(value11 .. ": Lvl 0 | 0 XP", true)
  end

  task.spawn(function()
    while task.wait(25) do
      if not flags.running then
        break
      end
      pcall(function()
        local localValue45 = replicatedStorage:FindFirstChild("Stats")
        if localValue45 and localValue45:FindFirstChild(localPlayer.Name) then
          local skillData = localValue45[localPlayer.Name]:FindFirstChild("SkillData")
          if skillData then
            for index6, value12 in ipairs(localValue43) do
              local findFirstChild3 = skillData:FindFirstChild(value12)
              if findFirstChild3 then
                local value13 = findFirstChild3.Value or 0
                local xp = findFirstChild3:FindFirstChild("XP")
                local value14 = xp and xp.Value or 0
                if localValue44[value12] then
                  localValue44[value12]:SetText(
                    value12 .. ": Lvl " .. tostring(value13) .. " | " .. tostring(value14) .. " XP"
                  )
                end
              end
            end
          end
        end
      end)
    end
  end)
end
