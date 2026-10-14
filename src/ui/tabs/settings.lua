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

  section26:AddToggle("Cfg_AutoHook", {
    Text = "Auto Send Job Stats",
    Default = false,
    Callback = function(value75)
      flags.webhookEnabled = value75
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
end
