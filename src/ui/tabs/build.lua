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

  -- ───────── Build Tab ─────────
  local section13 = localValue18.Build:AddGroupbox({ Side = "Left", Name = "Save House" })

  dropdowns.build = section13:AddDropdown("BuildSelectPlayer", {
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
      if type(ctx.pub.BUILD_OPTION) ~= "table" then
        ctx.pub.BUILD_OPTION = {}
      end
      ctx.pub.BUILD_OPTION.CanCollide = value46
    end,
  })

  section14:AddToggle("ShowStructuralItems", {
    Text = "Show Structural Items",
    Tooltip = "Turn this on if you want to see structural items.",
    Default = true,
    Callback = function(value47)
      if type(ctx.pub.BUILD_OPTION) ~= "table" then
        ctx.pub.BUILD_OPTION = {}
      end
      ctx.pub.BUILD_OPTION.ShowStructuralItems = value47
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
        local wereToolsSessionToken = ctx.auth:sessionToken()
        local urlEncode = wereToolsSessionToken and httpService:UrlEncode(wereToolsSessionToken)
          or ""
        local jsonDecode
        if localValue69 then
          pcall(function()
            for _, base in ipairs(ctx.config.backends) do
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
      if ctx.pub.WereTools_UpdateBuild then
        for key2, value51 in pairs(localValue76) do
          ctx.pub.WereTools_UpdateBuild(key2, value51)
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
end
