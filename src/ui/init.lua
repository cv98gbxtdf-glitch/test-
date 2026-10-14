return function(ctx)
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

    -- Shared mutable flags. Primitives that need to be observed across tab
    -- boundaries and by background loops live here as table fields (closures
    -- see mutations through the table reference, which they can't do for
    -- plain local primitives).
    local flags = {
      running = true,
      uiQuiet = true,
      webhookEnabled = false,
    }
    -- Shared dropdown handles. Tabs assign on creation; the dropdown refresh
    -- loop reads via `env.dropdowns` to call `:SetValues` with fresh data.
    local dropdowns = { players = nil, build = nil, stats = nil }

    getgenv().WereTools_StopLoops = function()
      flags.running = false
    end
    local localPlayer = players.LocalPlayer
    local wereToolsModules = ctx.modules
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
    local OBSIDIAN_REPO =
      "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"
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
      if flags.uiQuiet then
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
      if flags.uiQuiet then
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

    -- Mood poll + plot player listing. Lifted here so UI tabs and the
    -- background loops can share them without the loops needing to reach
    -- into a tab's closure.
    local function helperFunction12()
      local localPlayer2 = players.LocalPlayer
      local statsFolder = replicatedStorage:FindFirstChild("Stats")
      if statsFolder and localPlayer2 then
        local record = statsFolder:FindFirstChild(localPlayer2.Name)
        if record then
          local moodData = record:FindFirstChild("MoodData")
          if moodData then
            return moodData.Value or "",
              moodData:FindFirstChild("Energy") and math.floor(tonumber(moodData.Energy.Value) or 0)
                or 0,
              moodData:FindFirstChild("Fun") and math.floor(tonumber(moodData.Fun.Value) or 0) or 0,
              moodData:FindFirstChild("Hunger") and math.floor(tonumber(moodData.Hunger.Value) or 0)
                or 0,
              moodData:FindFirstChild("Hygiene") and math.floor(
                tonumber(moodData.Hygiene.Value) or 0
              ) or 0
          end
          return 0, 0, 0, 0, 0
        end
        return 0, 0, 0, 0, 0
      end
      return 0, 0, 0, 0, 0
    end

    local function helperFunction14()
      local names = {}
      local plots = workspace:FindFirstChild("Plots")
      if not plots then
        return names
      end
      for _, plr in ipairs(players:GetPlayers()) do
        if plots:FindFirstChild("Plot_" .. plr.Name) then
          table.insert(names, plr.Name)
        end
      end
      return names
    end

    -- Shared mutable state table. `activeAutoFarm` crosses the Main↔Premium
    -- boundary; the mood boost loop in Premium needs to stop the autofarm
    -- the Main tab started.
    local state = { activeAutoFarm = nil }

    -- Service container passed to every tab factory and to loops.lua.
    local env = {
      ctx = ctx,
      Library = Library,
      SaveManager = SaveManager,
      ThemeManager = ThemeManager,
      window = weretoolsWindow,
      tabs = localValue18,
      modules = wereToolsModules,
      players = players,
      httpService = httpService,
      replicatedStorage = replicatedStorage,
      runService = runService,
      coreGui = coreGui,
      virtualUser = virtualUser,
      teleportService = teleportService,
      localPlayer = localPlayer,
      isPremium = localValue5,
      keyType = localValue4,
      keyRef = localValue3,
      cfg = localValue6,
      remotes = localValue16,
      skillTweaks = localValue2,
      flags = flags,
      dropdowns = dropdowns,
      state = state,
      auth = auth,
      helpers = {
        notify = helperFunction1,
        premiumRequired = helperFunction2,
        requirePremium = helperFunction3,
        confirmDialog = helperFunction4,
        jobModules = helperFunction5,
        parseShiftTime = helperFunction6,
        findDeep = helperFunction7,
        disableIdled = helperFunction8,
        startAntiAfk = helperFunction9,
        stopAntiAfk = helperFunction10,
        listPlayers = helperFunction11,
        pollMood = helperFunction12,
        listPlotPlayers = helperFunction14,
      },
    }

    require("ui/tabs/info")(env)
    require("ui/tabs/main")(env)
    require("ui/tabs/premium")(env)
    require("ui/tabs/build")(env)
    require("ui/tabs/misc")(env)
    require("ui/tabs/settings")(env)

    require("ui/loops")(env)
  end)
end
