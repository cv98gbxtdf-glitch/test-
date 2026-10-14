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

  -- ───────── Misc Tab ─────────
  local section18 = localValue18.Misc:AddGroupbox({ Side = "Right", Name = "Local Player" })

  section18:AddToggle("InfStamina", {
    Text = "Infinite Stamina",
    Default = true,
    Callback = function(value58)
      task.spawn(function()
        while value58 and flags.running do
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
        while flags.running do
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

  dropdowns.stats = section25:AddDropdown("PlayerStatsTarget", {
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
end
