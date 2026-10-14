-- [ LeakD ] Fіlе Dеоbfuѕсаtеԁ Uѕіng LеаκD
-- [ Source ] https://discord.gg/AwGHNh7Z7T

local localValue1 = {}
local localValue2 = false
localValue1.Options = { FrostyFriends = true, SnowBallSkirmish = true, ArcticArt = true }
local wereToolsModules, localValue3

local function helperFunction1(parameter1, parameter2, parameter3)
  if string.lower(parameter2 or "") ~= "now!" then
    return
  end

  if localValue3 == parameter1 then
    return
  end

  print(" Detected:", parameter1)
  task.wait(5)

  if localValue3 and wereToolsModules then
    if localValue1.Options.FrostyFriends and wereToolsModules.FrostyFriends then
      wereToolsModules.FrostyFriends.stopFrostyFriends()
    end

    if localValue1.Options.SnowBallSkirmish and wereToolsModules.SnowBall then
      wereToolsModules.SnowBall.stopSnowBall()
    end

    if localValue1.Options.ArcticArt and wereToolsModules.ArcticArt then
      wereToolsModules.ArcticArt.stopArcticArt()
    end

    localValue3 = nil
  end

  if not wereToolsModules then
    warn(" modules nil")
    return
  end

  if
    parameter1 == "Frosty Friends"
    and localValue1.Options.FrostyFriends
    and wereToolsModules.FrostyFriends
  then
    localValue3 = "Frosty Friends"
    wereToolsModules.FrostyFriends.startFrostyFriends()
  elseif
    parameter1 == "Snowball Skirmish"
    and localValue1.Options.SnowBallSkirmish
    and wereToolsModules.SnowBall
  then
    localValue3 = "Snowball Skirmish"
    wereToolsModules.SnowBall.startSnowBall()
  elseif
    parameter1 == "Arctic Art"
    and localValue1.Options.ArcticArt
    and wereToolsModules.ArcticArt
  then
    localValue3 = "Arctic Art"
    wereToolsModules.ArcticArt.startArcticArt()
  else
    print(" Unknown or disabled event:", parameter1)
  end
end

function localValue1.setOption(parameter4, parameter5)
  if localValue1.Options[parameter4] == nil then
    return warn(" Invalid option name:", parameter4)
  end

  localValue1.Options[parameter4] = parameter5 == true
end

function localValue1.startEventActivities()
  wereToolsModules = _G.WereToolsModules

  if not wereToolsModules then
    warn("Modules not found!")
    return
  end

  local winterActivities = workspace.Environment.Locations.City.WinterActivities
  print("Starting event activity watcher...")
  localValue2 = true

  task.spawn(function()
    while localValue2 do
      for index, value in ipairs(winterActivities:GetChildren()) do
        local signGUI = value:FindFirstChild("SignGUI")

        local surfaceGui = signGUI
        surfaceGui = signGUI and signGUI:FindFirstChild("SurfaceGui")

        local findFirstChild = surfaceGui
        findFirstChild = surfaceGui and surfaceGui:FindFirstChild("1")

        local duration = findFirstChild
        duration = findFirstChild and findFirstChild:FindFirstChild("Duration")

        if findFirstChild and duration then
          helperFunction1(findFirstChild.Text, duration.Text, value)
        end
      end

      task.wait(1)
    end
  end)
end

function localValue1.stopEventActivities()
  print("Stopping event activity watcher...")
  localValue2 = false

  if wereToolsModules then
    if localValue1.Options.FrostyFriends and wereToolsModules.FrostyFriends then
      wereToolsModules.FrostyFriends.stopFrostyFriends()
    end

    if localValue1.Options.SnowBallSkirmish and wereToolsModules.SnowBall then
      wereToolsModules.SnowBall.stopSnowBall()
    end

    if localValue1.Options.ArcticArt and wereToolsModules.ArcticArt then
      wereToolsModules.ArcticArt.stopArcticArt()
    end
  end

  localValue3 = nil
  print("Watcher stopped.")
end

return localValue1
