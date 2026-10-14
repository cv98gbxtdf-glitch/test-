-- ─────────────────────────────────────────────────────────────
-- main UI  (Obsidian port of the former Maclib UI block)
-- ─────────────────────────────────────────────────────────────
task.spawn(function()
  local players = game:GetService("Players")
  local httpService = game:GetService("HttpService")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local runService = game:GetService("RunService")
  local coreGui = game:GetService("CoreGui")
  local virtualUser = game:GetService("VirtualUser")
  local teleportService = game:GetService("TeleportService")

  if getgenv().WereTools_Obsidian_Instance then
    if getgenv().WereTools_StopLoops then
      getgenv().WereTools_StopLoops()
    end
    task.wait(0.5)
  end

  getgenv().WereTools_Obsidian_Instance = true
  local localValue1 = true
  getgenv().WereTools_StopLoops = function()
    localValue1 = false
  end
  local localPlayer = players.LocalPlayer
  local wereToolsModules = _G.WereToolsModules or {}
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
  local localValue2 = { Gardening = true, Cooking = true }
  local auth = _G.auth or getgenv and getgenv().auth
  local localValue3 = auth and auth._io_r() or ""
  local localValue4 = auth and auth._type(localValue3) or "Trial"
  local localValue5 = localValue4 ~= "Trial"

  local localValue6 = {
    Job = "TaxiJob",
    WrapgiftPlayer = localPlayer.Name,
    BuildPlayer = localPlayer.Name,
    HouseID = "",
    MoodLevel = 10,
    Skill = "Cooking",
    CarSpeed = "1",
    FakeMoney = "1000000",
    FakeBlockbux = "50000",
    WebhookURL = "",
    PingID = "",
    HopDelay = "15",
    HouseFinderValue = "0",
    PlayerStatsTarget = localPlayer.Name,
  }

  local localValue7 = false
  local localValue8 = false
  local localValue9 = false
  local localValue10 = false
  local localValue11 = false
  local localValue12 = 0
  local localValue13 = true
  local localValue14 = false
  local localValue15 = true
  local localValue16 = {}

  pcall(function()
    local dataService = replicatedStorage.Modules.DataService
    local connFn = getconnections(dataService.DescendantAdded)[1].Function
    local remoteMap = getupvalue(connFn, 1)
    local nextFn = next
    local src, state = getupvalue(getupvalue(connFn, 2), 1)
    for k, v in nextFn, src, state do
      local sub = v:sub(1, 2) == "F_" and v:sub(3) or v
      localValue16[sub] = remoteMap[k]
    end
  end)

  -- Pull Obsidian + addons from the official repo.
  local OBSIDIAN_REPO = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"
  local libSrc
  local ok, src = pcall(function()
    return game:HttpGet(OBSIDIAN_REPO .. "Library.lua")
  end)
  if ok and type(src) == "string" and #src > 1000 then
    libSrc = src
    print("[WereTools] Obsidian via " .. OBSIDIAN_REPO .. " (" .. #src .. " bytes)")
  end
  if not libSrc then
    warn("[WereTools] Obsidian unavailable — cannot open window.")
    return
  end
  local Library = loadstring(libSrc)()
  local SaveManager = loadstring(game:HttpGet(OBSIDIAN_REPO .. "addons/SaveManager.lua"))()
  local ThemeManager = loadstring(game:HttpGet(OBSIDIAN_REPO .. "addons/ThemeManager.lua"))()

  local weretoolsWindow = Library:CreateWindow({
    Title = "WERETOOLS",
    Footer = "Bloxburg Script | "
      .. (localValue5 and "Premium Edition" or "Trial")
      .. " | Key: "
      .. localValue4,
    Size = UDim2.fromOffset(868, 500),
    ToggleKeybind = Enum.KeyCode.RightControl,
    NotifySide = "Right",
    ShowCustomCursor = true,
  })

  local function helperFunction1(title, description, parameter1)
    if localValue15 then
      return
    end
    pcall(function()
      Library:Notify({
        Title = title,
        Description = description,
        Time = parameter1 or 5,
      })
    end)
  end

  local function helperFunction2()
    if localValue15 then
      return
    end
    Library:Notify({
      Title = "Premium Required",
      Description = "You must purchase Premium Key to use this feature!",
      Time = 5,
    })
  end

  local function helperFunction3()
    if localValue5 then
      return true
    end
    helperFunction2()
    return false
  end

  local dialogCounter = 0
  local function helperFunction4(title2, description2, parameter2)
    dialogCounter = dialogCounter + 1
    weretoolsWindow:AddDialog("WereToolsDialog" .. dialogCounter, {
      Title = title2,
      Description = description2,
      AutoDismiss = true,
      OutsideClickDismiss = true,
      FooterButtons = {
        Cancel = {
          Title = "Cancel",
          Variant = "Ghost",
          Order = 1,
        },
        Confirm = {
          Title = "Confirm",
          Variant = "Primary",
          Order = 2,
          Callback = function()
            if parameter2 then
              parameter2()
            end
          end,
        },
      },
    })
  end

  local localValue18 = {
    Info = weretoolsWindow:AddTab("Info", "info"),
    Main = weretoolsWindow:AddTab("Main", "home"),
    Premium = weretoolsWindow:AddTab("Premium", "star"),
    Build = weretoolsWindow:AddTab("Auto Build", "hammer"),
    Misc = weretoolsWindow:AddTab("Miscellaneous", "wrench"),
    Themes = weretoolsWindow:AddTab("Themes", "palette"),
    Settings = weretoolsWindow:AddTab("Settings & Webhook", "settings"),
  }

  local function helperFunction5()
    return {
      TaxiJob = taxi,
      StylezHairdresser = hairdresser,
      PizzaPlanetDelivery = pizza,
      BloxBurgersEmployee = burger,
      HighSchoolTeacher = teacher,
      SchoolJanitor = janitor,
      HutFisherman = fisher,
      SupermarketCashier = cashier,
      BensIceCreamSeller = icecream,
      MikesMechanic = mechanic,
      CaveMiner = miner,
      SupermarketStocker = stocker,
      LumberWoodcutter = lumber,
      PizzaPlanetBaker = bakery,
    }
  end

  local function helperFunction6(parameter3)
    if type(parameter3) ~= "string" then
      return 0
    end
    return (tonumber(parameter3:match("(%d+)h")) or 0) * 60
      + (tonumber(parameter3:match("(%d+)m")) or 0)
  end

  local function helperFunction7(parameter4, parameter5)
    local findFirstChild = parameter4
    for index, value4 in ipairs(parameter5) do
      if not findFirstChild then
        return nil
      end
      findFirstChild = findFirstChild:FindFirstChild(value4)
    end
    return findFirstChild
  end

  local function helperFunction8(parameter6)
    pcall(function()
      for index2, value5 in ipairs(getconnections(parameter6.Idled)) do
        value5:Disable()
      end
    end)
  end

  local connect

  local function helperFunction9()
    helperFunction8(localPlayer)
    if connect then
      connect:Disconnect()
    end
    connect = localPlayer.Idled:Connect(function()
      virtualUser:CaptureController()
      virtualUser:ClickButton2(Vector2.new())
    end)
    localValue13 = true
  end

  local function helperFunction10()
    if connect then
      connect:Disconnect()
      connect = nil
    end
    localValue13 = false
  end

  local function helperFunction11()
    local localValue19 = {}
    for index3, value6 in ipairs(players:GetPlayers()) do
      table.insert(localValue19, value6.Name)
    end
    return localValue19
  end

  -- ───────── Info Tab ─────────
  local section = localValue18.Info:AddGroupbox({ Side = "Left", Name = "Player Mood Status" })

  local function helperFunction12()
    local localPlayer2 = players.LocalPlayer
    local localValue20 = replicatedStorage:FindFirstChild("Stats")
    if localValue20 and localPlayer2 then
      local findFirstChild2 = localValue20:FindFirstChild(localPlayer2.Name)
      if findFirstChild2 then
        local moodData = findFirstChild2:FindFirstChild("MoodData")
        if moodData then
          return moodData.Value or "",
            moodData:FindFirstChild("Energy") and math.floor(tonumber(moodData.Energy.Value) or 0)
              or 0,
            moodData:FindFirstChild("Fun") and math.floor(tonumber(moodData.Fun.Value) or 0) or 0,
            moodData:FindFirstChild("Hunger") and math.floor(tonumber(moodData.Hunger.Value) or 0)
              or 0,
            moodData:FindFirstChild("Hygiene") and math.floor(tonumber(moodData.Hygiene.Value) or 0)
              or 0
        end
        return 0, 0, 0, 0, 0
      end
      return 0, 0, 0, 0, 0
    end
    return 0, 0, 0, 0, 0
  end

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
      if not localValue1 then
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
      if not localValue1 then
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

  -- ───────── Main Tab ─────────
  local section5 = localValue18.Main:AddGroupbox({ Side = "Right", Name = "Auto Farm" })

  section5:AddDropdown("JobSelect", {
    Text = "Select Job",
    Values = {
      "TaxiJob",
      "StylezHairdresser",
      "PizzaPlanetDelivery",
      "BloxBurgersEmployee",
      "HighSchoolTeacher",
      "SchoolJanitor",
      "HutFisherman",
      "BensIceCreamSeller",
      "MikesMechanic",
      "SupermarketCashier",
      "CaveMiner",
      "SupermarketStocker",
      "LumberWoodcutter",
      "PizzaPlanetBaker",
    },
    Default = 1,
    Callback = function(value15)
      localValue6.Job = value15
    end,
  })

  section5:AddButton({
    Text = "Teleport to Job",
    Func = function()
      local job = localValue6.Job
      if not job or job == "" then
        return
      end
      local ok = pcall(function()
        require(localPlayer.PlayerScripts.Modules.JobHandler):GoToWork(job)
      end)
      if not ok and localValue16.ToWork then
        pcall(function()
          localValue16.ToWork:InvokeServer({ Name = job })
        end)
      end
      helperFunction1("Teleport", "Heading to " .. job, 3)
    end,
  })

  section5:AddButton({
    Text = "Force End Shift",
    Func = function()
      pcall(function()
        local localValue46 = require(localPlayer.PlayerScripts.Modules.JobHandler)
        localValue46:StopWorking()
        task.wait(0.3)
        localValue46:StopWorking()
      end)
    end,
  })

  local localValue47

  section5:AddToggle("EnableAutoFarm", {
    Text = "Start Auto Farm",
    Default = false,
    Callback = function(value16)
      if value16 then
        if localValue47 and localValue47.stopAutoFarm then
          localValue47:stopAutoFarm()
        end
        local localValue48 = helperFunction5()[localValue6.Job]
        if localValue48 and localValue48.startAutoFarm then
          localValue48:startAutoFarm()
          localValue47 = localValue48
          helperFunction1("Success", "Started AutoFarm: " .. tostring(localValue6.Job), 5)
        end
      else
        if localValue47 and localValue47.stopAutoFarm then
          localValue47:stopAutoFarm()
        end
        localValue47 = nil
      end
    end,
  })

  local section6 = localValue18.Main:AddGroupbox({ Side = "Left", Name = "Settings" })

  section6:AddToggle("AntiAFK", {
    Text = "Anti AFK",
    Tooltip = "Prevent 20 minutes kicked from ROBLOX",
    Default = true,
    Callback = function(value17)
      if value17 then
        helperFunction9()
      else
        helperFunction10()
      end
    end,
  })

  section6:AddToggle("AutoClaimPayCheck", {
    Text = "Auto Claim Pay Check",
    Tooltip = "Help you to claim pay check when it pop up.",
    Default = false,
    Callback = function(value18)
      getgenv().AutoClaimPayCheck = value18
      if value18 then
        task.spawn(function()
          while getgenv().AutoClaimPayCheck do
            pcall(function()
              local close = players.LocalPlayer.PlayerGui.MainGUI.PaycheckFrame.Close
              if close then
                firesignal(close.Activated)
              end
            end)
            task.wait(30)
          end
        end)
      end
    end,
  })

  section6:AddButton({
    Text = "Potato Graphics",
    Tooltip = "Optimize your device performance (useful on mobile)",
    Func = function()
      if graphic and graphic.setPotatoMode then
        graphic.setPotatoMode(true)
      end
    end,
  })

  local section7 = localValue18.Main:AddGroupbox({ Side = "Left", Name = "Wrap Gift" })

  section7:AddLabel(
    "<b>Tutorial</b>\nThis feature help you to bypass donation limit, you must use alt account to use this feature, more information on official discord!. Make sure you placed Simplicity Dining Table and Gift Wrapping Station",
    true
  )

  local selectPlayerDropdown = section7:AddDropdown("WrapPlayer", {
    Text = "Select Player",
    Values = helperFunction11(),
    Default = 1,
    Callback = function(value19)
      localValue6.WrapgiftPlayer = value19
    end,
  })

  section7:AddButton({
    Text = "Goto Plot",
    Func = function()
      if localValue16.ToPlot then
        localValue16.ToPlot:InvokeServer({ Player = localValue6.WrapgiftPlayer })
        helperFunction1("Success", "Teleported to " .. tostring(localValue6.WrapgiftPlayer), 3)
      end
    end,
  })

  section7:AddInput("WrapgiftAmount", {
    Text = "Set Money Amount",
    Placeholder = "100000",
    Callback = function(value20)
      getgenv().WrapgiftAmount = tonumber(value20) or 100000
    end,
  })

  section7:AddToggle("AutoWrapGift", {
    Text = "Auto Wrap Gift",
    Default = false,
    Callback = function(value21)
      if not wrapgift then
        return
      elseif value21 then
        if wrapgift.setTarget and not wrapgift.setTarget(localValue6.WrapgiftPlayer) then
          return
        end
        if wrapgift.startAutoWrap then
          wrapgift.startAutoWrap()
        end
        return
      else
        if wrapgift.stopAutoWrap then
          wrapgift.stopAutoWrap()
        end
        return
      end
    end,
  })

  local section8 = localValue18.Main:AddGroupbox({ Side = "Right", Name = "Break System" })

  local localValue49 = 40
  local localValue50 = 5

  local localValue51 = {
    "TopbarGui",
    "Topbar",
    "Expanded",
    "CanvasGroup",
    "TweenContainer",
    "Pages",
    "JobPage",
    "CanvasGroup",
    "ShiftContainer",
    "DurationContainer",
    "ShiftDurationLabel",
  }

  section8:AddLabel(
    "<b>Tutorial</b>\nBreaks give you more legit behaviours, which prevents banning from bloxburg staff! (Recommend always turn this on).",
    true
  )

  section8:AddInput("BreakAfter", {
    Text = "Break After Minutes",
    Placeholder = "40",
    Callback = function(value22)
      localValue49 = tonumber(value22) or 40
    end,
  })

  section8:AddInput("BreakDuration", {
    Text = "Break Duration (minutes)",
    Placeholder = "5",
    Callback = function(value23)
      localValue50 = tonumber(value23) or 5
    end,
  })

  section8:AddButton({
    Text = "Set Breaks",
    Func = function()
      helperFunction1(
        "Info",
        "Settings Saved: "
          .. tostring(localValue49)
          .. "m work / "
          .. tostring(localValue50)
          .. "m break",
        3
      )
    end,
  })

  section8:AddToggle("EnableBreaks", {
    Text = "Start Breaks",
    Default = false,
    Callback = function(value24)
      localValue10 = value24
      if not value24 then
        return
      end
      task.spawn(function()
        while localValue10 and localValue1 do
          task.wait(1)
          if localValue11 then
            if os.time() >= localValue12 then
              localValue11 = false
            end
          else
            pcall(function()
              local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
              if not playerGui2 then
                return
              end
              local localValue52 = helperFunction7(playerGui2, localValue51)
              if not localValue52 then
                return
              end
              if helperFunction6(localValue52.Text) >= localValue49 then
                localValue11 = true
                localValue12 = os.time() + localValue50 * 60
                if localValue47 and localValue47.stopAutoFarm then
                  localValue47:stopAutoFarm()
                end
                localValue47 = nil
                local character = localPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                  character.Humanoid.Jump = true
                end
                task.wait(2)
                local jobHandler = localPlayer.PlayerScripts.Modules:FindFirstChild("JobHandler")
                if jobHandler then
                  require(jobHandler):StopWorking()
                end
                helperFunction1(
                  "Break System",
                  "Resting for " .. tostring(localValue50) .. " minutes.",
                  4
                )
              end
              return
            end)
          end
        end
      end)
    end,
  })

  local section9 = localValue18.Main:AddGroupbox({ Side = "Right", Name = "School Farms" })

  section9:AddToggle("SchoolChem", {
    Text = "Chemistry",
    Default = true,
    Callback = function(value25)
      if schoolController and schoolController.setOption then
        schoolController.setOption("chem", value25)
      end
    end,
  })

  section9:AddToggle("SchoolLang", {
    Text = "Language",
    Default = true,
    Callback = function(value26)
      if schoolController and schoolController.setOption then
        schoolController.setOption("lang", value26)
      end
    end,
  })

  section9:AddToggle("SchoolArt", {
    Text = "Art",
    Default = true,
    Callback = function(value27)
      if schoolController and schoolController.setOption then
        schoolController.setOption("art", value27)
      end
    end,
  })

  section9:AddToggle("SchoolPhys", {
    Text = "Physics",
    Default = true,
    Callback = function(value28)
      if schoolController and schoolController.setOption then
        schoolController.setOption("phys", value28)
      end
    end,
  })

  section9:AddButton({
    Text = "Teleport to School",
    Func = function()
      local char = localPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(999.67, 47.19, -251.87)
        helperFunction1("Teleport", "Teleported to school", 3)
      end
    end,
  })

  section9:AddToggle("SchoolAuto", {
    Text = "Start Auto School",
    Default = false,
    Callback = function(value29)
      if not schoolController then
        return
      end
      if value29 and schoolController.startController then
        schoolController.startController()
      elseif not value29 and schoolController.stopController then
        schoolController.stopController()
      end
    end,
  })

  local section10 = localValue18.Main:AddGroupbox({ Side = "Left", Name = "Skills" })

  section10:AddDropdown("MainSkillSelect", {
    Text = "Select Skill",
    Values = {
      "Cooking",
      "Gardening",
      "Intelligence",
      "Painting",
      "Writing",
      "Music",
      "Athletic",
      "Gaming",
    },
    Default = 1,
    Callback = function(value30)
      localValue6.Skill = value30
    end,
  })

  local localValue53

  section10:AddToggle("MainAutoSkill", {
    Text = "Auto Farm Skill",
    Default = false,
    Callback = function(value31)
      localValue9 = value31
      if value31 then
        if localValue53 and coroutine.status(localValue53) ~= "dead" then
          return
        end
        localValue53 = task.spawn(function()
          while localValue9 and localValue1 do
            local skill = localValue6.Skill or "Cooking"
            if skillModule and skillModule[skill] then
              pcall(skillModule[skill])
            end
            task.wait(localValue2[skill] and 1 or 2)
          end
        end)
        return
      end
      if skillModule then
        pcall(function()
          if skillModule.StopCooking then
            skillModule.StopCooking()
          end
        end)
        pcall(function()
          if skillModule.StopGardening then
            skillModule.StopGardening()
          end
        end)
      end
    end,
  })

  section10:AddToggle("MainAutoHarvest", {
    Text = "Auto Harvest",
    Default = false,
    Callback = function(value32)
      if skillModule then
        skillModule.AutoHarvest = value32
      end
      if not harvest then
        return
      end
      if value32 and harvest.startAutoFarm then
        harvest.startAutoFarm()
      elseif not value32 and harvest.stopAutoFarm then
        harvest.stopAutoFarm()
      end
    end,
  })

  if localValue13 then
    helperFunction9()
  end

  -- ───────── Premium Tab ─────────
  local section11 = localValue18.Premium:AddGroupbox({ Side = "Left", Name = "Auto Pay Mood" })

  section11:AddToggle("AutoPayMood", {
    Text = "Enable Pay Boost Mood",
    Tooltip = "This feature allow you to auto use your blockbux to recharge your mood faster without going to home!",
    Default = false,
    Callback = function(value33)
      if value33 and not helperFunction3() then
        localValue8 = false
        return
      end
      localValue8 = value33
      if value33 then
        task.spawn(function()
          while localValue8 and localValue1 do
            task.wait(5)
            if not localValue8 then
              break
            end
            pcall(function()
              local playerGui3 = localPlayer:FindFirstChild("PlayerGui")
              if not playerGui3 then
                return
              end
              local messageBox = playerGui3:FindFirstChild("_MessageBox")
              if not messageBox then
                return
              end
              local messageBox2 = messageBox:FindFirstChild("MessageBox")
              if not messageBox2 then
                return
              end
              local title3 = messageBox2:FindFirstChild("Title")
              local localValue54 = not title3
              local buttonFrame = messageBox2:FindFirstChild("ButtonFrame")
              if localValue54 or not buttonFrame then
                return
              end
              if title3.Text == "Boost Mood" then
                for index7, value34 in ipairs(buttonFrame:GetChildren()) do
                  local textLabel = value34:FindFirstChild("TextLabel")
                  if textLabel and textLabel.Text == "Yes" then
                    firesignal(value34.Activated)
                    break
                  end
                end
              end
              return
            end)
          end
        end)
      end
    end,
  })

  local section12 = localValue18.Premium:AddGroupbox({ Side = "Right", Name = "Mood Settings" })

  section12:AddSlider("MoodTriggerSlider", {
    Text = "Trigger Below",
    Default = 40,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(value35)
      localValue6.MoodTrigger = value35
    end,
  })

  section12:AddSlider("MoodTargetSlider", {
    Text = "Boost To",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(value36)
      localValue6.MoodTarget = value36
    end,
  })

  local funBoost = true
  local hygieneBoost = true
  local hungerBoost = true
  local energyBoost = true

  section12:AddToggle("MoodFun", {
    Text = "Fun Boost",
    Default = true,
    Callback = function(value37)
      if not helperFunction3() then
        return
      end
      funBoost = value37
    end,
  })

  section12:AddToggle("MoodHygiene", {
    Text = "Hygiene Boost",
    Default = true,
    Callback = function(value38)
      if not helperFunction3() then
        return
      end
      hygieneBoost = value38
    end,
  })

  section12:AddToggle("MoodHunger", {
    Text = "Hunger Boost",
    Default = true,
    Callback = function(value39)
      if not helperFunction3() then
        return
      end
      hungerBoost = value39
    end,
  })

  section12:AddToggle("MoodEnergy", {
    Text = "Energy Boost",
    Default = true,
    Callback = function(value40)
      if not helperFunction3() then
        return
      end
      energyBoost = value40
    end,
  })

  local localValue55 = false
  local localValue56

  section12:AddToggle("AutoMoodBoost", {
    Text = "Start Auto Mood",
    Default = false,
    Callback = function(value41)
      localValue7 = value41
      if not helperFunction3() then
        return
      end
      if value41 then
        localValue55 = false
        localValue56 = task.spawn(function()
          while localValue7 and localValue1 do
            local localValue57, localValue58 = pcall(function()
              local moodTrigger = localValue6.MoodTrigger or 10
              local moodTarget = localValue6.MoodTarget or 90
              local job2 = localValue6.Job
              local findFirstChild4 =
                replicatedStorage:WaitForChild("Stats"):FindFirstChild(localPlayer.Name)
              local moodData2 = findFirstChild4 and findFirstChild4:FindFirstChild("MoodData")
              local localValue59
              if not moodData2 then
                return
              end
              local localValue61 = {}
              if funBoost and moodData2:FindFirstChild("Fun") then
                table.insert(localValue61, moodData2.Fun.Value)
              end
              if hygieneBoost and moodData2:FindFirstChild("Hygiene") then
                table.insert(localValue61, moodData2.Hygiene.Value)
              end
              if hungerBoost and moodData2:FindFirstChild("Hunger") then
                table.insert(localValue61, moodData2.Hunger.Value)
              end
              if energyBoost and moodData2:FindFirstChild("Energy") then
                table.insert(localValue61, moodData2.Energy.Value)
              end
              local localValue62 = 100
              if #localValue61 > 0 then
                localValue62 = math.min(table.unpack(localValue61))
              end
              if moodTrigger > 0 and job2 and not localValue55 and localValue62 < moodTrigger then
                localValue55 = true
                helperFunction1(
                  "Mood Boost",
                  "Low mood detected (" .. math.floor(localValue62) .. "%). Starting boost...",
                  5
                )
                local character2 = localPlayer.Character
                local humanoid = character2 and character2:FindFirstChild("Humanoid")
                if humanoid then
                  humanoid.Jump = true
                end
                task.wait(1)
                if localValue47 and localValue47.stopAutoFarm then
                  localValue47:stopAutoFarm()
                  localValue47 = nil
                end
                localValue16.ToPlot:InvokeServer({ Player = localPlayer.Name })
                task.wait(4)
                local localValue63 = require(localPlayer.PlayerScripts.Modules.JobHandler)
                localValue63:StopWorking()
                task.wait(0.3)
                localValue63:StopWorking()
                task.wait(1)
                if boostModule and boostModule.RunBoostFlow then
                  local localValue64, localValue65 = pcall(function()
                    boostModule.RunBoostFlow({
                      Level = moodTarget,
                      Fun = funBoost,
                      Hygiene = hygieneBoost,
                      Hunger = hungerBoost,
                      Energy = energyBoost,
                    })
                  end)
                  if not localValue64 then
                    warn("Boost failed:", localValue65)
                  end
                else
                  warn("BoostModule not loaded")
                end
                local function helperFunction13()
                  local findFirstChild5 =
                    replicatedStorage:WaitForChild("Stats"):FindFirstChild(localPlayer.Name)
                  local moodData3 = findFirstChild5 and findFirstChild5:FindFirstChild("MoodData")
                  if not moodData3 then
                    return true
                  end
                  if funBoost and moodData3.Fun.Value < moodTarget then
                    return false
                  end
                  if hygieneBoost and moodData3.Hygiene.Value < moodTarget then
                    return false
                  end
                  if hungerBoost and moodData3.Hunger.Value < moodTarget then
                    return false
                  end
                  if energyBoost and moodData3.Energy.Value < moodTarget then
                    return false
                  end
                  return true
                end
                local localValue66 = tick() + 60
                if not helperFunction13() then
                  tick()
                end
                repeat
                  task.wait(1)
                  localValue59 = helperFunction13() or tick() > localValue66
                until localValue59
                require(localPlayer.PlayerScripts.Modules.JobHandler):GoToWork(job2)
                task.wait(3)
                local localValue67 = helperFunction5()[job2]
                if localValue67 and localValue67.startAutoFarm then
                  localValue67:startAutoFarm()
                  localValue47 = localValue67
                  helperFunction1("Job Resumed", "Returned to work: " .. job2, 3)
                end
                localValue55 = false
              end
              return
            end)
            if not localValue57 then
              warn("Mood loop error:", localValue58)
            end
            task.wait(5)
          end
        end)
      else
        if localValue56 then
          task.cancel(localValue56)
          localValue56 = nil
        end
        localValue55 = false
      end
    end,
  })

  -- ───────── Build Tab ─────────
  local section13 = localValue18.Build:AddGroupbox({ Side = "Left", Name = "Save House" })

  local function helperFunction14()
    local localValue68 = {}
    local plots = workspace:FindFirstChild("Plots")
    if not plots then
      return localValue68
    end
    for index8, value42 in ipairs(players:GetPlayers()) do
      if plots:FindFirstChild("Plot_" .. value42.Name) then
        table.insert(localValue68, value42.Name)
      end
    end
    return localValue68
  end

  local selectPlayerDropdown2 = section13:AddDropdown("BuildSelectPlayer", {
    Text = "Select Player",
    Values = helperFunction14(),
    Default = 1,
    Callback = function(value43)
      localValue6.BuildPlayer = value43
    end,
  })

  section13:AddButton({
    Text = "Goto Plot Player",
    Func = function()
      local buildPlayer = localValue6.BuildPlayer
      if not buildPlayer or buildPlayer == "" then
        return
      end
      if localValue16.ToPlot then
        localValue16.ToPlot:InvokeServer({ Player = buildPlayer })
        helperFunction1("Success", "Teleported to " .. buildPlayer .. "'s plot.", 3)
      end
    end,
  })

  section13:AddButton({
    Text = "Save Build",
    Func = function()
      local buildPlayer2 = localValue6.BuildPlayer
      if not buildPlayer2 or buildPlayer2 == "" then
        return
      end
      task.spawn(function()
        if buildModule and buildModule.save_house then
          if buildModule.save_house(buildPlayer2) then
            helperFunction1("Success", "House Id copied for: " .. buildPlayer2, 3)
          else
            helperFunction1("Error", "Failed to save house for: " .. buildPlayer2, 3)
          end
        end
      end)
    end,
  })

  section13:AddToggle("BuildEnableCamera", {
    Text = "Free Camera",
    Tooltip = "You can move around your world, useful when you want to see the house interior without permission!",
    Default = false,
    Callback = function(value44)
      if camera and camera.Set then
        camera.Set(value44)
      end
    end,
  })

  local section14 = localValue18.Build:AddGroupbox({ Side = "Right", Name = "Build Preview" })
  local section15 = localValue18.Build:AddGroupbox({ Side = "Right", Name = "Multi Build Config" })
  local section16 = localValue18.Build:AddGroupbox({ Side = "Right", Name = "Load Build from ID" })
  local section17 = localValue18.Build:AddGroupbox({ Side = "Left", Name = "Build Settings" })

  local houseID = ""

  section14:AddInput("PreviewHouseID", {
    Text = "House ID",
    Placeholder = "Paste House ID.",
    Callback = function(value45)
      houseID = value45
    end,
  })

  section14:AddButton({
    Text = "Load Preview Build",
    Func = function()
      if houseID ~= "" and previewBuild and previewBuild.load_preview then
        local loaded = previewBuild.load_preview(houseID)
        if loaded then
          helperFunction1("Preview", "Rendering preview for ID: " .. tostring(houseID), 3)
        end
      end
    end,
  })

  section14:AddButton({
    Text = "Delete Preview Build",
    Func = function()
      if previewBuild and previewBuild.destroy_previewBuild then
        previewBuild.destroy_previewBuild(true)
      end
    end,
  })

  section14:AddDivider()
  section14:AddLabel("<b>Configuration</b>", true)

  section14:AddToggle("ObjectsColide", {
    Text = "Objects Collide",
    Tooltip = "Turn this off if you want to go through objects.",
    Default = true,
    Callback = function(value46)
      if type(getgenv().BUILD_OPTION) ~= "table" then
        getgenv().BUILD_OPTION = {}
      end
      getgenv().BUILD_OPTION.CanCollide = value46
    end,
  })

  section14:AddToggle("ShowStructuralItems", {
    Text = "Show Structural Items",
    Tooltip = "Turn this on if you want to see structural items.",
    Default = true,
    Callback = function(value47)
      if type(getgenv().BUILD_OPTION) ~= "table" then
        getgenv().BUILD_OPTION = {}
      end
      getgenv().BUILD_OPTION.ShowStructuralItems = value47
    end,
  })

  section16:AddButton({
    Text = "Get More Builds",
    Tooltip = "Paste this link on your browser and find your favourite builds",
    Func = function()
      pcall(function()
        setclipboard("https://weretools.xyz/dashboard/")
      end)
    end,
  })

  section16:AddInput("LoadHouseID", {
    Text = "ID House",
    Tooltip = "Dont have ID? Click Get more builds button above",
    Placeholder = "Paste House ID",
    Callback = function(value48)
      localValue6.HouseID = value48
    end,
  })

  section16:AddButton({
    Text = "Load Build",
    Tooltip = "After get your ID house, ensure that enter the build mode and click this button",
    Func = function()
      local sS = tostring(localValue6.HouseID or ""):match("^%s*(.-)%s*$")
      if sS == "" then
        return
      end
      task.spawn(function()
        local localValue69 = request or http_request or syn and syn.request
        local localValue70 = false
        local wereToolsSessionToken = _G.WereToolsSessionToken
        local urlEncode = wereToolsSessionToken and httpService:UrlEncode(wereToolsSessionToken)
          or ""
        local jsonDecode
        if localValue69 then
          pcall(function()
            for _, base in ipairs(BACKENDS) do
              local localValue71 = localValue69({
                Url = base .. "/api/upload/" .. sS,
                Method = "GET",
              })
              if
                localValue71
                and localValue71.StatusCode == 200
                and localValue71.Body
                and localValue71.Body ~= ""
              then
                local okParse, parsed = pcall(function()
                  return httpService:JSONDecode(localValue71.Body)
                end)
                if okParse and type(parsed) == "table" and parsed.success ~= false then
                  jsonDecode = parsed
                  localValue70 = true
                  break
                end
              end
            end
            if not localValue70 then
              warn("Load Build: id " .. sS .. " not found on any backend")
            end
          end)
        end
        local localValue72 = "Confirm Auto Build"
        local localValue73
        if localValue70 and jsonDecode then
          local function helperFunction15(parameter7)
            return tostring(parameter7):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
          end
          local realValue = jsonDecode.real_value
            or jsonDecode.data and jsonDecode.data.real_value
            or 0
          local blockbuxValue = jsonDecode.blockbux_value
            or jsonDecode.data and jsonDecode.data.blockbux_value
            or 0
          local gamepasses = jsonDecode.gamepasses or jsonDecode.data and jsonDecode.data.gamepasses
          local skills = jsonDecode.skills or jsonDecode.data and jsonDecode.data.skills
          local localValue74 = "None"
          local localValue75 = "None"
          if type(gamepasses) == "table" and #gamepasses > 0 then
            localValue74 = table.concat(gamepasses, ", ")
          elseif type(gamepasses) == "string" and gamepasses ~= "" then
            localValue74 = gamepasses
          end
          if type(skills) == "table" and #skills > 0 then
            localValue75 = table.concat(skills, ", ")
          elseif type(skills) == "string" and skills ~= "" then
            localValue75 = skills
          end
          localValue73 = string.format(
            "Money: $%s\nBlockbux: %s\nGamepasses: %s\nSkills: %s",
            helperFunction15(realValue),
            helperFunction15(blockbuxValue),
            localValue74,
            localValue75
          )
        else
          localValue72 = "Force Build (Server Error)"
          localValue73 =
            "Could not get data (Check F9 for details).\nDo you want to force build anyway?"
        end
        helperFunction4(localValue72, localValue73, function()
          task.spawn(function()
            if buildModule and buildModule.load_house then
              buildModule.load_house(sS, false)
            else
              warn("BuildModule not found!")
            end
          end)
        end)
      end)
    end,
  })

  section16:AddButton({
    Text = "Continue Build",
    Tooltip = "This feature help you continue previous build, helpful when you got disconnected!",
    Func = function()
      if buildModule and buildModule.continue_build then
        buildModule.continue_build()
      end
    end,
  })

  section15:AddLabel(
    "<b>Tutorial</b>\nMulti Build is a feature that help you build fast, You can sellect specific part and use mutiple account to build a house.",
    true
  )

  section15:AddDropdown("MultiBuildConfig", {
    Text = "Select Objects",
    Values = {
      "Walls",
      "Floors",
      "Roofs",
      "Basements",
      "Paths",
      "Counters",
      "Fences",
      "Pools",
      "Objects",
    },
    Multi = true,
    Callback = function(value49)
      local localValue76 = {
        Walls = false,
        Floors = false,
        Roofs = false,
        Basements = false,
        Paths = false,
        Counters = false,
        Fences = false,
        Pools = false,
        Objects = false,
      }
      for key, value50 in pairs(value49) do
        if type(key) == "number" and type(value50) == "string" then
          if localValue76[value50] ~= nil then
            localValue76[value50] = true
          end
        elseif type(key) == "string" and type(value50) == "boolean" then
          if localValue76[key] ~= nil then
            localValue76[key] = value50
          end
        end
      end
      if getgenv().WereTools_UpdateBuild then
        for key2, value51 in pairs(localValue76) do
          getgenv().WereTools_UpdateBuild(key2, value51)
        end
      end
    end,
  })

  section17:AddToggle("BuildUseVehicles", {
    Text = "Use Vehicles",
    Tooltip = "Turn this on if you want to buy cars when building.",
    Default = false,
    Callback = function(value52)
      if buildModule and buildModule.set_settings then
        buildModule.set_settings({ use_vehicles = value52 })
      end
    end,
  })

  section17:AddToggle("BuildUseBlockbux", {
    Text = "Use Blockbux",
    Tooltip = "Turn this on if you want to use blockbux when building.",
    Default = false,
    Callback = function(value53)
      if buildModule and buildModule.set_settings then
        buildModule.set_settings({ use_blockbux = value53 })
      end
    end,
  })

  section17:AddInput("BuildBlockbuxAmount", {
    Text = "Set Blockbux Amount",
    Placeholder = "e.g., 100",
    Callback = function(value54)
      local localValue77 = tonumber(value54)
      if localValue77 then
        if buildModule and buildModule.set_settings then
          buildModule.set_settings({ use_blockbux_amount = localValue77 })
        end
        helperFunction1("Blockbux Set", "Blockbux amount set to: " .. localValue77, 2)
      end
    end,
  })

  section17:AddDivider()
  section17:AddLabel(
    "<b>Dangerous Section</b>\nDo not modify anything if you dont know under features doing.",
    true
  )

  section17:AddInput("SetMaxRetries", {
    Text = "Set Max Retries",
    Tooltip = "The amount of times rebuild when a object failed to place",
    Placeholder = "2",
    Callback = function(value55)
      if buildModule and buildModule.setMaxRetries then
        buildModule.setMaxRetries(value55)
      end
    end,
  })

  section17:AddInput("SetPlacementTime", {
    Text = "Set Placement Wait Time",
    Tooltip = "The waiting time for the next placement, longer time will make the build more accurate but require much time!",
    Placeholder = "1",
    Callback = function(value56)
      if buildModule and buildModule.setPlacementTime then
        buildModule.setPlacementTime(value56)
      end
    end,
  })

  section17:AddInput("SetColorTime", {
    Text = "Set Color Wait Time",
    Tooltip = "The waiting time for the next coloring, longer time will make the build more accurate but require much time!",
    Placeholder = "1",
    Callback = function(value57)
      if buildModule and buildModule.setColorTime then
        buildModule.setColorTime(value57)
      end
    end,
  })

  -- ───────── Misc Tab ─────────
  local section18 = localValue18.Misc:AddGroupbox({ Side = "Right", Name = "Local Player" })

  section18:AddToggle("InfStamina", {
    Text = "Infinite Stamina",
    Default = true,
    Callback = function(value58)
      task.spawn(function()
        while value58 and localValue1 do
          local character3 = localPlayer.Character
          if character3 then
            local humanoid2 = character3:FindFirstChild("Humanoid")
            if humanoid2 then
              humanoid2.MaxHealth = math.huge
              humanoid2.Health = math.huge
            end
          end
          task.wait(1)
        end
      end)
    end,
  })

  local section19 =
    localValue18.Misc:AddGroupbox({ Side = "Left", Name = "Neighborhood Configuration" })

  local localValue78

  local function helperFunction16()
    if localValue78 and localValue78 ~= "" then
      localValue16.JoinPrivateServer:InvokeServer({ Search = localValue78 })
    end
  end

  section19:AddInput("NeighborhoodID", {
    Text = "Paste Neighborhood ID/ Name Player",
    Placeholder = "999",
    Callback = function(value59)
      localValue78 = value59
    end,
  })

  section19:AddToggle("NeighborhoodConfig", {
    Text = "Auto Join Neighborhood",
    Default = false,
    Callback = function(value60)
      if not value60 then
        return
      end
      helperFunction16()
    end,
  })

  local connect2

  section19:AddToggle("AutoRejoin", {
    Text = "Auto Rejoin When Kicking",
    Default = false,
    Callback = function(value61)
      localValue14 = value61
      if value61 then
        connect2 = players.LocalPlayer.OnTeleport:Connect(function(parameter8)
          if localValue14 then
            if #players:GetPlayers() <= 1 then
              teleportService:Teleport(game.PlaceId, players.LocalPlayer)
            else
              teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, players.LocalPlayer)
            end
          end
        end)
      elseif connect2 then
        connect2:Disconnect()
        connect2 = nil
      end
    end,
  })

  local section20 = localValue18.Misc:AddGroupbox({ Side = "Left", Name = "Plot Snipper" })

  function getPlayerHouses()
    local localValue79 = {}
    local localValue80 = replicatedStorage:FindFirstChild("Stats")
    local findFirstChild6 = localValue80 and localValue80:FindFirstChild(localPlayer.Name)
    local houses = findFirstChild6 and findFirstChild6:FindFirstChild("Houses")
    if not houses then
      warn("House folder not found")
      return localValue79
    end
    for index9, value62 in ipairs(houses:GetChildren()) do
      table.insert(localValue79, value62.Name)
    end
    return localValue79
  end

  local function helperFunction17()
    local plots2 = workspace:FindFirstChild("Plots")
    if not plots2 then
      return false
    end
    return plots2:FindFirstChild("Plot_" .. players.LocalPlayer.Name) ~= nil
  end

  local localValue81

  section20:AddDropdown("HouseSelection", {
    Text = "Select House to Load",
    Values = getPlayerHouses(),
    Default = 1,
    Callback = function(value63)
      localValue81 = value63
    end,
  })

  local localValue82 = false

  section20:AddToggle("AutoClaimPlot", {
    Text = "Auto Claim Plot",
    Default = false,
    Callback = function(value64)
      localValue82 = value64
      if not value64 then
        return
      end
      task.spawn(function()
        local localValue83 = tick()
        while not localValue81 and tick() - localValue83 < 5 do
          if not localValue82 then
            return
          end
          task.wait(0.2)
        end
        if not localValue81 then
          return
        end
        while localValue82 do
          if helperFunction17() then
            localValue82 = false
            break
          end
          localValue16.LoadHouse:InvokeServer({ House = localValue81 })
          task.wait(1)
          localValue16.ToPlot:InvokeServer({ Player = localPlayer.Name })
          task.wait(3)
        end
      end)
    end,
  })

  local section21 = localValue18.Misc:AddGroupbox({ Side = "Right", Name = "Bypass Features" })

  section21:AddToggle("BypassGP", {
    Text = "Bypass Gamepasses",
    Tooltip = "Only bypass advanced placement not entire gamepasses.",
    Default = false,
    Callback = function(value65)
      if not value65 then
        return
      end
      for key3, value66 in
        pairs(
          replicatedStorage
            :WaitForChild("Stats")
            :WaitForChild(localPlayer.Name)
            :WaitForChild("Gamepasses")
            :GetChildren()
        )
      do
        if value66:IsA("BoolValue") then
          value66.Value = true
        end
      end
    end,
  })

  local section22 = localValue18.Misc:AddGroupbox({ Side = "Left", Name = "Freeze UI" })

  section22:AddLabel(
    "<b>Tutorial</b>\nThis feature help you always to keep your mood, your mood will never be negative.",
    true
  )

  section22:AddToggle("FreezeUI", {
    Text = "Freeze UI",
    Default = false,
    Tooltip = "You must on the Main menu (do not load your plot) to use this feature!",
    Callback = function(value67)
      pcall(function()
        localPlayer.PlayerGui.MainMenuGui.Enabled = not value67
        localPlayer.PlayerGui.HouseSelectionGUI = not value67
      end)
    end,
  })

  local section23 = localValue18.Misc:AddGroupbox({ Side = "Right", Name = "Fake Stats" })

  section23:AddInput("FakeMoney", {
    Text = "Fake Money",
    Placeholder = "1000000",
    Callback = function(value68)
      localValue6.FakeMoney = value68
    end,
  })

  section23:AddInput("FakeBlockbux", {
    Text = "Fake Blockbux",
    Placeholder = "10000",
    Callback = function(value69)
      localValue6.FakeBlockbux = value69
    end,
  })

  section23:AddButton({
    Text = "Apply Fake Stats",
    Func = function()
      local findFirstChild7 =
        replicatedStorage:WaitForChild("Stats"):FindFirstChild(localPlayer.Name)
      if findFirstChild7 then
        local money2 = findFirstChild7:FindFirstChild("Money")
        local blockbux = findFirstChild7:FindFirstChild("Blockbux")
        if money2 then
          money2.Value = tonumber(localValue6.FakeMoney) or 1000000
        end
        if blockbux then
          blockbux.Value = tonumber(localValue6.FakeBlockbux) or 10000
        end
      end
    end,
  })

  local section24 = localValue18.Misc:AddGroupbox({ Side = "Left", Name = "Car Configuration" })

  section24:AddInput("CarSpeed", {
    Text = "Car Speed",
    Placeholder = "1",
    Callback = function(value70)
      localValue6.CarSpeed = value70
    end,
  })

  section24:AddButton({
    Text = "Set Speed",
    Func = function()
      local localValue84 = tonumber(localValue6.CarSpeed) or 1
      task.spawn(function()
        while localValue1 do
          local character4 = localPlayer.Character
          if character4 then
            local humanoid3 = character4:FindFirstChild("Humanoid")
            if humanoid3 then
              humanoid3.WalkSpeed = 16 * localValue84
            end
          end
          task.wait(1)
        end
      end)
      helperFunction1("Car", "Speed set to " .. tostring(localValue6.CarSpeed), 3)
    end,
  })

  local section25 = localValue18.Misc:AddGroupbox({ Side = "Right", Name = "Player Stats Viewer" })

  local selectPlayerDropdown3 = section25:AddDropdown("PlayerStatsTarget", {
    Text = "Select Player",
    Values = helperFunction11(),
    Default = 1,
    Callback = function(value71)
      localValue6.PlayerStatsTarget = value71
    end,
  })

  section25:AddButton({
    Text = "View Player Stats",
    Func = function()
      local playerStatsTarget = localValue6.PlayerStatsTarget
      local findFirstChild8 =
        replicatedStorage:WaitForChild("Stats"):FindFirstChild(playerStatsTarget)
      if not findFirstChild8 then
        return
      end
      local money3 = findFirstChild8:FindFirstChild("Money")
      local blockbux2 = findFirstChild8:FindFirstChild("Blockbux")
      local houses2 = findFirstChild8:FindFirstChild("Houses")
      if not (money3 and blockbux2 and houses2) then
        return
      end
      local text2 = ""
      for key4, value72 in pairs(houses2:GetChildren()) do
        local totalValue = value72:FindFirstChild("TotalValue")
        if totalValue and totalValue:IsA("IntValue") then
          text2 = text2 .. value72.Name .. ": $" .. tostring(totalValue.Value) .. "\n"
        end
      end
      local localValue85 = {}
      table.insert(localValue85, "Money: $" .. tostring(money3.Value))
      table.insert(localValue85, "Blockbux: $" .. tostring(blockbux2.Value))
      if text2 ~= "" then
        table.insert(localValue85, "Houses:")
        table.insert(localValue85, text2)
      else
        table.insert(localValue85, "No houses found.")
      end
      helperFunction1(
        "Stats of " .. tostring(playerStatsTarget),
        table.concat(localValue85, "\n"),
        10
      )
    end,
  })

  task.spawn(function()
    pcall(function()
      local wereToolsAutoHopJson = readfile("WereTools_AutoHop.json")
      if wereToolsAutoHopJson then
        local jsonDecode2 = httpService:JSONDecode(wereToolsAutoHopJson)
        if jsonDecode2 then
          if jsonDecode2.value then
            localValue6.HouseFinderValue = tostring(jsonDecode2.value)
          end
          if jsonDecode2.HopDelay then
            localValue6.HopDelay = tostring(jsonDecode2.HopDelay)
          end
        end
      end
    end)
  end)

  -- ───────── Settings Tab (Webhook + Community) ─────────
  local section26 = localValue18.Settings:AddGroupbox({ Side = "Right", Name = "Discord Webhook" })

  section26:AddInput("WebhookURL", {
    Text = "Webhook URL",
    Placeholder = "https://...",
    Callback = function(value73)
      localValue6.WebhookURL = value73
    end,
  })

  section26:AddInput("PingID", {
    Text = "Ping ID",
    Placeholder = "<@ID>",
    Callback = function(value74)
      localValue6.PingID = value74
    end,
  })

  section26:AddButton({
    Text = "Save Webhook",
    Func = function()
      writefile(
        "WereToolsWebhook.txt",
        httpService:JSONEncode({ url = localValue6.WebhookURL, ping = localValue6.PingID })
      )
    end,
  })

  local localValue86 = false

  section26:AddToggle("Cfg_AutoHook", {
    Text = "Auto Send Job Stats",
    Default = false,
    Callback = function(value75)
      localValue86 = value75
    end,
  })

  local section27 = localValue18.Settings:AddGroupbox({ Side = "Right", Name = "Community" })

  section27:AddButton({
    Text = "Copy Discord Invite",
    Func = function()
      setclipboard("https://discord.gg/weretools")
    end,
  })

  section27:AddButton({
    Text = "Alternative Invite",
    Func = function()
      setclipboard("https://discord.gg/hGpWBnVheT")
    end,
  })

  -- ───────── Themes & Save/Config addons ─────────
  ThemeManager:SetLibrary(Library)
  ThemeManager:SetFolder("WereTools")
  ThemeManager:ApplyToTab(localValue18.Themes)

  SaveManager:SetLibrary(Library)
  SaveManager:IgnoreThemeSettings()
  SaveManager:SetIgnoreIndexes({})
  SaveManager:SetFolder("WereTools")
  SaveManager:BuildConfigSection(localValue18.Settings)

  pcall(function()
    local jsonDecode3 = httpService:JSONDecode(readfile("WereToolsWebhook.txt"))
    localValue6.WebhookURL = jsonDecode3.url
    localValue6.PingID = jsonDecode3.ping
  end)

  task.spawn(function()
    local localValue87 = 0
    local localValue88 = -1

    while localValue1 do
      task.wait(5)
      if not localValue86 then
      else
        pcall(function()
          if tick() - localValue87 < 15 then
            return
          else
            local localValue89 = replicatedStorage:FindFirstChild("Stats")
            if localValue89 and localValue89:FindFirstChild(localPlayer.Name) then
              local localValue90 = localValue89[localPlayer.Name]
              local job3 = localValue90:FindFirstChild("Job")
              if job3 then
                local value76 = job3.Value or "None"
                local value77 = job3:FindFirstChild("ShiftEarnings") and job3.ShiftEarnings.Value
                local efficiency = job3:FindFirstChild("Efficiency")
                local localValue91 = value77 or 0
                local value78 = efficiency and job3.Efficiency.Value or 0
                local money4 = localValue90:FindFirstChild("Money")
                local blockbux3 = localValue90:FindFirstChild("Blockbux")
                local value79 = money4 and money4.Value or 0
                local value80 = blockbux3 and blockbux3.Value or 0
                local localValue92, localValue93, localValue94, localValue95, localValue96 =
                  helperFunction12()
                local localValue97 = 0
                if money4 and 0 then
                  localValue97 = value79 - 0
                  if localValue97 < 0 then
                    localValue97 = 0
                  end
                end
                if localValue91 > 0 and localValue91 ~= localValue88 then
                  localValue87 = tick()
                  localValue88 = localValue91
                  local localValue98 = request or http_request or syn and syn.request
                  if localValue98 and localValue6.WebhookURL ~= "" then
                    local localValue99 = {
                      content = localValue6.PingID
                          and localValue6.PingID ~= ""
                          and localValue6.PingID
                        or "",
                      username = "Were Tools WebHook",
                      avatar_url = "https://imagizer.imageshack.com/img924/3550/syF2Vn.png",
                      embeds = {
                        {
                          title = "Were Tools Stats",
                          color = 1752220,
                          fields = {
                            { name = "Current Job", value = tostring(value76), inline = true },
                            {
                              name = "Shift Earnings",
                              value = "$" .. tostring(localValue91),
                              inline = true,
                            },
                            {
                              name = "Efficiency",
                              value = tostring(value78) .. "%",
                              inline = true,
                            },
                            {
                              name = "Total Pay (Session)",
                              value = "$" .. tostring(localValue97),
                              inline = true,
                            },
                            { name = "Money", value = "$" .. tostring(value79), inline = true },
                            { name = "Blockbux", value = tostring(value80), inline = true },
                            {
                              name = "----- MOOD DATA -----",
                              value = "**MOOD DATA**",
                              inline = false,
                            },
                            {
                              name = "Overall",
                              value = tostring(localValue92) .. "%",
                              inline = true,
                            },
                            {
                              name = "Energy",
                              value = tostring(localValue93) .. "%",
                              inline = true,
                            },
                            { name = "Fun", value = tostring(localValue94) .. "%", inline = true },
                            {
                              name = "Hunger",
                              value = tostring(localValue95) .. "%",
                              inline = true,
                            },
                            {
                              name = "Hygiene",
                              value = tostring(localValue96) .. "%",
                              inline = true,
                            },
                          },
                          timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                        },
                      },
                    }
                    localValue98({
                      Url = localValue6.WebhookURL,
                      Method = "POST",
                      Headers = { ["Content-Type"] = "application/json" },
                      Body = httpService:JSONEncode(localValue99),
                    })
                  end
                end
              end
            end
            return
          end
        end)
      end
    end
  end)

  task.spawn(function()
    while localValue1 do
      task.wait(600)
      if localValue3 == "" then
        break
      end
      auth._req_01(localValue3, auth._sys_id(), function(parameter9, parameter10)
        if parameter9 and auth._sec_02(parameter10._validationProof) then
          _G.WereToolsSessionToken = parameter10.session_token
        else
          auth._io_d()
        end
      end)
    end
  end)

  task.spawn(function()
    while localValue1 do
      task.wait(30)
      pcall(function()
        local localValue100 = helperFunction11()
        local localValue101 = helperFunction14()
        if selectPlayerDropdown and selectPlayerDropdown.SetValues then
          selectPlayerDropdown:SetValues(localValue100)
        end
        if selectPlayerDropdown3 and selectPlayerDropdown3.SetValues then
          selectPlayerDropdown3:SetValues(localValue100)
        end
        if selectPlayerDropdown2 and selectPlayerDropdown2.SetValues then
          selectPlayerDropdown2:SetValues(localValue101)
        end
      end)
    end
  end)

  pcall(function()
    local jsonDecode4 = httpService:JSONDecode(readfile("WereTools_AutoHop.json"))
    if jsonDecode4 then
      localValue6.HouseFinderValue = tostring(jsonDecode4.value or "0")
      localValue6.HopDelay = tostring(jsonDecode4.HopDelay or "15")
    end
  end)

  SaveManager:LoadAutoloadConfig()

  task.wait(0.5)
  localValue15 = false

  local localValue102

  localValue102 = hookmetamethod(game, "__namecall", function(parameter11, ...)
    local localValue103 = getnamecallmethod()
    local localValue104 = ...
    if not checkcaller() and localValue103 == "FireServer" then
      if type(localValue104) == "table" then
        if localValue104.Type == "LookDir" then
          return
        end
      end
      return localValue102(parameter11, ...)
    end
    return localValue102(parameter11, ...)
  end)
end)
