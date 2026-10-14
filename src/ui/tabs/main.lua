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

  section5:AddToggle("EnableAutoFarm", {
    Text = "Start Auto Farm",
    Default = false,
    Callback = function(value16)
      if value16 then
        if state.activeAutoFarm and state.activeAutoFarm.stopAutoFarm then
          state.activeAutoFarm:stopAutoFarm()
        end
        local localValue48 = helperFunction5()[localValue6.Job]
        if localValue48 and localValue48.startAutoFarm then
          localValue48:startAutoFarm()
          state.activeAutoFarm = localValue48
          helperFunction1("Success", "Started AutoFarm: " .. tostring(localValue6.Job), 5)
        end
      else
        if state.activeAutoFarm and state.activeAutoFarm.stopAutoFarm then
          state.activeAutoFarm:stopAutoFarm()
        end
        state.activeAutoFarm = nil
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
      ctx.pub.AutoClaimPayCheck = value18
      if value18 then
        task.spawn(function()
          while ctx.pub.AutoClaimPayCheck do
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

  dropdowns.players = section7:AddDropdown("WrapPlayer", {
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
      ctx.pub.WrapgiftAmount = tonumber(value20) or 100000
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
        while localValue10 and flags.running do
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
                if state.activeAutoFarm and state.activeAutoFarm.stopAutoFarm then
                  state.activeAutoFarm:stopAutoFarm()
                end
                state.activeAutoFarm = nil
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
          while localValue9 and flags.running do
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
end
