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
          while localValue8 and flags.running do
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
          while localValue7 and flags.running do
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
                if state.activeAutoFarm and state.activeAutoFarm.stopAutoFarm then
                  state.activeAutoFarm:stopAutoFarm()
                  state.activeAutoFarm = nil
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
                  state.activeAutoFarm = localValue67
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
end
