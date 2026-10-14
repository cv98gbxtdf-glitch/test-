---@source Dеobfuѕсаtеԁ Ѕuссеssfully Ву LеаκD
---@see https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local virtualInputManager = game:GetService("VirtualInputManager")
local localPlayer = players.LocalPlayer
local localValue1 = { "Icebox Fridge", "FlexFreeze Fridge", "Arctic Fridge" }

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
character:WaitForChild("Humanoid")

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local modules = localPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules")
local playerGui = localPlayer:WaitForChild("PlayerGui")
local localValue2 = require(modules:WaitForChild("InteractionHandler"))
local localValue3 = loadstring(
  game:HttpGet("https://raw.githubusercontent.com/wereareone/weareone/refs/heads/main/UI.luau")
)().newNotify()

local function helperFunction1(title, content, parameter1)
  localValue3.new({
    Title = title,
    Content = content,
    Duration = parameter1 or 5,
    Icon = "rbxassetid://103660255446080",
  })
end

local function helperFunction2()
  for index, value in ipairs(workspace:WaitForChild("Plots"):GetChildren()) do
    if value.Name:match("^Plot_" .. localPlayer.Name) then
      return value
    end
  end

  return nil
end

local function helperFunction3(parameter2, parameter3, parameter4)
  local localValue4 = parameter2

  for index2, value2 in ipairs(parameter3) do
    local localValue5 = value2
    local localValue6, localValue7 = pcall(function()
      return localValue4:WaitForChild(localValue5, parameter4)
    end)

    if not localValue6 or not localValue7 then
      helperFunction1("Error", "Cant find: " .. localValue5, 3)
      return nil
    end

    localValue4 = localValue7
  end

  return localValue4
end

local function helperFunction4(parameter5, parameter6)
  if not parameter5 or typeof(parameter5) ~= "Instance" then
    return false
  end

  local localValue8 = nil
  local primaryPart = nil

  if parameter5:IsA("BasePart") then
    primaryPart = parameter5
    localValue8 = parameter5
  elseif parameter5:IsA("Model") then
    localValue8 = parameter5
    primaryPart = parameter5.PrimaryPart or parameter5:FindFirstChildWhichIsA("BasePart")
  end

  local localValue9, localValue10

  if not primaryPart or not localValue2 then
    return false
  else
    pcall(function()
      setthreadidentity(2)
      localValue2:ShowMenu(localValue8 or primaryPart, primaryPart.Position, primaryPart)
      setthreadidentity(7)
    end)

    local waitForChild = playerGui:WaitForChild("_interactUI", 5)

    local waitForChild2 = waitForChild
    waitForChild2 = waitForChild and waitForChild:WaitForChild("Center", 5)

    if not waitForChild2 then
      return false
    else
      localValue10 = nil
      local localValue11 = tick()

      if not localValue10 then
        tick()
      end

      repeat
        for index3, value3 in ipairs(waitForChild2:GetChildren()) do
          for index4, value4 in ipairs(value3:GetDescendants()) do
            if value4:IsA("TextLabel") and value4.Text == parameter6 then
              localValue10 = value3
              break
            end
          end

          if localValue10 then
            break
          end
        end

        if not localValue10 then
          task.wait(0.1)
        end

        localValue9 = localValue10 or tick() - localValue11 > 3
      until localValue9

      if not localValue10 then
        return false
      end

      pcall(function()
        firesignal((localValue10:FindFirstChildWhichIsA("GuiButton") or localValue10).Activated)
      end)
      task.wait(0.2)
      return true
    end
  end
end

local function helperFunction5()
  local findFirstChild = workspace.Plots:FindFirstChild("Plot_" .. localPlayer.Name)

  if not findFirstChild or not findFirstChild:FindFirstChild("House") then
    helperFunction1("Error", "Player plot null, please spawn a plot for " .. localPlayer.Name, 5)
    return nil
  else
    local counters = findFirstChild.House:FindFirstChild("Counters")

    if not counters then
      helperFunction1(
        "Error",
        "Counter is null, please put a counter in your plot for " .. localPlayer.Name,
        5
      )

      return nil
    end

    for index5, value5 in ipairs(counters:GetChildren()) do
      if value5.Name:match("Counter$") then
        helperFunction1("Success", "Found counter: " .. value5.Name, 3)
        return value5
      end
    end

    return nil
  end
end

local function helperFunction6(parameter7, parameter8)
  for index6, value6 in ipairs(parameter7:GetChildren()) do
    for index7, value7 in ipairs(parameter8) do
      if value6.Name == value7 then
        return value6
      end
    end

    local localValue12 = helperFunction6(value6, parameter8)

    if localValue12 then
      return localValue12
    end
  end

  return nil
end

local function helperFunction7(parameter9)
  local findFirstChild2 = playerGui:FindFirstChild("_MessageBox", true)

  if not findFirstChild2 then
    return false
  else
    local buttonFrame = findFirstChild2:FindFirstChild("MessageBox")
      and findFirstChild2.MessageBox:FindFirstChild("ButtonFrame")

    if not buttonFrame then
      return false
    else
      local localValue13 = tick()

      while tick() - localValue13 < (parameter9 or 5) do
        for index8, value8 in ipairs(buttonFrame:GetChildren()) do
          local localValue14 = value8

          if localValue14:IsA("GuiButton") or localValue14:IsA("ImageButton") then
            pcall(function()
              firesignal(localValue14.Activated)
            end)
            return true
          end
        end

        task.wait(0.1)
      end

      helperFunction1("Error", "MessageBox: Timeout: Cannot find button in MessageBox", 3)
      return false
    end
  end
end

local function helperFunction8(parameter10, parameter11)
  if not parameter10 then
    return
  else
    local vector = parameter11
    vector = parameter11 or Vector3.new(0, 0, -3)

    local localValue15 = parameter10.Position + vector
    local magnitude = (humanoidRootPart.Position - localValue15).Magnitude
    local localValue16 = math.clamp(magnitude / 23, 0.3, 4)
    local unit = (parameter10.Position - humanoidRootPart.Position).Unit
    local cframe = CFrame.new(localValue15, localValue15 + unit)
    local canCollide = humanoidRootPart.CanCollide
    humanoidRootPart.CanCollide = false

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(localValue16, Enum.EasingStyle.Linear),
      { CFrame = cframe }
    )

    create:Play()
    create.Completed:Wait()

    humanoidRootPart.CanCollide = canCollide
    return
  end
end

local function helperFunction9()
  local localValue17 = helperFunction3(playerGui, {
    "_ListFrame (T_Ingredients)",
    "Frame",
    "ItemList",
    "ScrollFrame",
    "Garden Salad_Button",
  }, 10)

  if localValue17 then
    local take = localValue17:FindFirstChild("Take")
      or localValue17:FindFirstChildWhichIsA("ImageButton")

    if take then
      firesignal(take.Activated)
      return true
    end

    return false
  end

  return false
end

local helperFunction10

local function helperFunction11(parameter12)
  local count = 0
  local localValue18 = parameter12 or 1

  while count < localValue18 do
    local localValue19, localValue20 = helperFunction10(2)

    if localValue19 and localValue20 then
      if localValue20.Text == "E" then
        firesignal(localValue19.MouseButton1Click, localValue19)
      else
        local text = localValue20.Text

        pcall(function()
          virtualInputManager:SendKeyEvent(true, text, false, game)
          task.wait(0.05)
          virtualInputManager:SendKeyEvent(false, text, false, game)
        end)
      end

      count = count + 1
    else
      helperFunction1("Error", "❌ DefaultButton null ( " .. count + 1 .. ")", 3)
    end

    task.wait(0.5)
  end

  helperFunction1("Success", "Task Done after " .. count .. " count", 3)
end

function helperFunction10(parameter13)
  local localValue21 = tick()
  tick()

  repeat
    local defaultButton = localPlayer.PlayerGui:FindFirstChild("FloatingGui")
      and localPlayer.PlayerGui.FloatingGui:FindFirstChild("DefaultButton")

    local textLabel = defaultButton and defaultButton:FindFirstChild("TextLabel")

    if defaultButton and textLabel then
      return defaultButton, textLabel
    end

    task.wait(0.1)
  until tick() - localValue21 > (parameter13 or 2)

  return nil, nil
end

local localValue22 = false

local function helperFunction12()
  if not localValue22 then
    return false
  else
    local findFirstChild3 = workspace.Plots:FindFirstChild("Plot_" .. localPlayer.Name)

    if not findFirstChild3 or not findFirstChild3:FindFirstChild("House") then
      return false
    else
      local localValue23 = helperFunction6(findFirstChild3.House, localValue1)

      if not localValue23 then
        return false
      else
        local localValue24 = helperFunction5()

        if not localValue24 then
          return false
        else
          local basePart = localValue23:IsA("BasePart") and localValue23
            or localValue23.PrimaryPart
            or localValue23:FindFirstChildWhichIsA("BasePart")

          if not basePart then
            return false
          end

          helperFunction8(basePart)

          if not localValue22 then
            return false
          end

          task.wait(0.5)

          if not helperFunction4(localValue23, "Take Ingredients") then
            return false
          end

          task.wait(0.5)

          if not helperFunction9() then
            return false
          else
            local basePart2 = localValue24:IsA("BasePart") and localValue24
              or localValue24.PrimaryPart
              or localValue24:FindFirstChildWhichIsA("BasePart")

            if not basePart2 then
              return false
            end

            helperFunction8(basePart2)

            if not localValue22 then
              return false
            end

            task.wait(0.3)

            if not helperFunction4(localValue24, "Cut") then
              return false
            end

            task.wait(0.3)
            helperFunction11(5)

            if not localValue22 then
              return false
            end

            task.wait(1)
            helperFunction8(basePart2)
            task.wait(0.3)

            if not helperFunction4(localValue24, "Mix") then
              return false
            end

            task.wait(0.3)
            helperFunction11(2)
            task.wait(2)
            return true
          end
        end
      end
    end
  end
end

local function helperFunction13(parameter14)
  local objectModel = parameter14:FindFirstChild("ObjectModel")

  if not objectModel then
    return false
  else
    local body = objectModel:FindFirstChild("Body")

    if not body then
      return false
    end

    return body.Size.Y >= 11.9 and body.Size.X >= 4.4 and body.Size.Z >= 4.4
  end
end

local function helperFunction14()
  local localValue25 = require(localPlayer.PlayerScripts.Modules._UI.HUDHandler)
  local hotbarUI = localValue25 and localValue25.HotbarUI

  if not hotbarUI then
    return
  else
    local equipData = hotbarUI.EquipData

    if equipData and typeof(equipData.Function) == "function" then
      equipData.Function()
    else
      helperFunction1("Error", "UseItem null", 3)
    end

    return
  end
end

local localValue26 = {
  "Old Television",
  "NYX VintageView TV",
  "NYX Wall Mounted VintageView TV",
  'Acutus 22" TV',
  "AcuSlim TV",
  "NYX OptiVision TV",
  "AcuSlim II TV",
  "Pixelview Infinity",
  "iWatch TV",
  "Pixelview 360",
}

local function helperFunction15(parameter15)
  local poweredOn = parameter15:FindFirstChild("PoweredOn")
  return poweredOn and poweredOn.Value
end

local function helperFunction16()
  local localValue27 = helperFunction3(playerGui, {
    "_ListFrame (I_Plant)",
    "Frame",
    "ItemList",
    "ScrollFrame",
    "Rough Tree_Button",
  }, 10)

  if localValue27 then
    local take2 = localValue27:FindFirstChild("Take")
      or localValue27:FindFirstChildWhichIsA("GuiButton")

    if take2 then
      firesignal(take2.Activated)
      helperFunction1("Success", "Take Rough Tree", 3)
      return true
    end

    return
  end
end

local localValue28 = false

local function helperFunction17()
  local localValue29 = helperFunction2()

  if not localValue29 then
    return {}
  else
    local house = localValue29:FindFirstChild("House")

    if not house then
      return {}
    else
      local objects = house:FindFirstChild("Objects")

      if not objects then
        return {}
      else
        local localValue30 = {}

        for index9, value9 in ipairs(objects:GetChildren()) do
          if value9.Name == "Dirt Pile" then
            local itemHolder = value9:FindFirstChild("ItemHolder")

            if itemHolder and itemHolder:FindFirstChild("Rough Tree") then
              table.insert(localValue30, value9)
            end
          end
        end

        return localValue30
      end
    end
  end
end

local function helperFunction18()
  local localValue31 = helperFunction2()

  if not localValue31 then
    helperFunction1("Error", "Gardening: Plot not loaded", 5)
    return false
  end

  if not localValue31:WaitForChild("House"):FindFirstChild("Objects") then
    helperFunction1("Error", "Gardening: Objects missing", 5)
    return false
  else
    local localValue32 = helperFunction17()

    if #localValue32 == 0 then
      helperFunction1("Gardening", "No Rough Tree on plot", 3)
      return false
    else
      local localValue33 = false

      for index10, value10 in ipairs(localValue32) do
        local itemHolder2 = value10:FindFirstChild("ItemHolder")

        if itemHolder2 then
          for index11, value11 in ipairs(itemHolder2:GetChildren()) do
            local localValue34 = value11

            if not helperFunction13(localValue34) then
            else
              localValue33 = true
              helperFunction8(localValue34)
              task.wait(0.3)
              pcall(function()
                helperFunction4(localValue34, "Sell ($ 105)")
              end)
              task.wait(0.2)
            end
          end
        end
      end

      if localValue33 then
        helperFunction1("Gardening", "Sold all mature Rough Trees!", 3)
      else
        helperFunction1("Gardening", "Tree not mature yet. Waiting…", 3)
      end

      return localValue33
    end
  end
end

local function helperFunction19()
  local localValue35 = helperFunction2()

  if not localValue35 then
    helperFunction1("Error", "Gardening: Plot haven't loaded", 5)
    return
  else
    local objects2 = localValue35:WaitForChild("House"):FindFirstChild("Objects")

    if not objects2 then
      helperFunction1("Error", "Gardening: Cannot find Objects", 5)
      return
    else
      local count2 = 0

      repeat
        local localValue36 = {}

        for index12, value12 in ipairs(objects2:GetChildren()) do
          if value12.Name == "Dirt Pile" then
            local localValue37 = false
            local itemHolder3 = value12:FindFirstChild("ItemHolder")

            if itemHolder3 and itemHolder3:FindFirstChild("Rough Tree") then
              localValue37 = true
            end

            if not localValue37 then
              table.insert(localValue36, value12)
            end
          end
        end

        if #localValue36 == 0 then
          helperFunction1("Success", "All Dirt Pile already planted!", 3)
          break
        end

        for i = 1, #localValue36 do
          local localValue38 = localValue36[i]

          local localValue39, localValue40 = pcall(function()
            helperFunction8(localValue38)
            task.wait(0.3)

            if helperFunction4(localValue38, "Plant") then
              task.wait(1.5)
              helperFunction16()
              task.wait(9)
            else
              helperFunction1("Warning", "Gardening: UI not ready: " .. tostring(localValue38), 3)
              task.wait(1)
            end
          end)

          if not localValue39 then
            helperFunction1(
              "Error",
              "Gardening: plants: "
                .. tostring(localValue38)
                .. ", error: "
                .. tostring(localValue40),
              5
            )
          end
        end

        count2 = count2 + 1
        task.wait(1)
      until count2 >= 10

      return
    end
  end
end

local function helperFunction20()
  if not localValue28 then
    return false
  end

  helperFunction19()

  if not localValue28 then
    return false
  end

  task.wait(2)
  helperFunction18()

  if not localValue28 then
    return false
  end

  return true
end

local localValue41 = {
  "Pearingtosh",
  "E3 Home Computer",
  "iSlim Laptop",
  "iSlim Computer",
  "EPX Computer",
  "EPX-Ultra Computer",
}

local function helperFunction21(parameter16)
  local localValue42 = {}

  for index13, value13 in ipairs(parameter16:GetChildren()) do
    table.insert(localValue42, value13)

    for index14, value14 in ipairs(helperFunction21(value13)) do
      table.insert(localValue42, value14)
    end
  end

  return localValue42
end

local function helperFunction22()
  local localValue43 = helperFunction2()

  if not localValue43 then
    return nil
  else
    local objects3 = localValue43:WaitForChild("House"):FindFirstChild("Objects")

    if not objects3 then
      return nil
    else
      local localValue44 = {}

      for index15, value15 in ipairs((helperFunction21(objects3))) do
        for index16, value16 in ipairs(localValue41) do
          if value15.Name == value16 then
            table.insert(localValue44, value15)
          end
        end
      end

      if #localValue44 == 0 then
        return nil
      end

      return localValue44[math.random(1, #localValue44)]
    end
  end
end

local localValue45 = {}

local function helperFunction23(parameter17, parameter18)
  local center = playerGui:WaitForChild("_interactUI"):WaitForChild("Center")
  local localValue46 = tick()
  tick()

  repeat
    for index17, value17 in ipairs(center:GetChildren()) do
      if value17:IsA("GuiButton") then
        local textLabel2 = value17:FindFirstChild("TextLabel") or value17

        if textLabel2 and string.lower(textLabel2.Text) == string.lower(parameter17) then
          firesignal(value17.Activated)
          return true
        end
      end
    end

    task.wait(0.1)
  until tick() - localValue46 > (parameter18 or 3)

  helperFunction1("Error", "PlayDevice: Cant find " .. parameter17, 3)
  return false
end

local localValue47 = {
  "Pearingtosh",
  "E3 Home Computer",
  "iSlim Laptop",
  "iSlim Computer",
  "EPX Computer",
  "EPX-Ultra Computer",
}

local helperFunction24

local function helperFunction25()
  local localValue48 = helperFunction2()

  if not localValue48 then
    return nil
  else
    local objects4 = localValue48:WaitForChild("House"):FindFirstChild("Objects")

    if not objects4 then
      return nil
    else
      local localValue49 = {}

      for index18, value18 in ipairs((helperFunction24(objects4))) do
        for index19, value19 in ipairs(localValue47) do
          if value18.Name == value19 then
            table.insert(localValue49, value18)
          end
        end
      end

      if #localValue49 == 0 then
        return nil
      end

      return localValue49[math.random(1, #localValue49)]
    end
  end
end

function helperFunction24(parameter19)
  local localValue50 = {}

  for index20, value20 in ipairs(parameter19:GetChildren()) do
    table.insert(localValue50, value20)

    for index21, value21 in ipairs(helperFunction24(value20)) do
      table.insert(localValue50, value21)
    end
  end

  return localValue50
end

local localValue51

function localValue45.Cooking()
  if localValue51 and coroutine.status(localValue51) ~= "dead" then
    helperFunction1("Warning", "Cooking Loop already running!", 3)
    return
  end

  localValue22 = true

  localValue51 = task.spawn(function()
    while localValue22 do
      if not helperFunction12() then
        helperFunction1("Warning", "Cooking Step failed, retrying…", 3)
      end

      task.wait(1)
    end
  end)
end

function localValue45.StopCooking()
  localValue22 = false
end

local localValue52

function localValue45.Gardening()
  if localValue52 and coroutine.status(localValue52) ~= "dead" then
    return
  end

  localValue28 = true

  localValue52 = task.spawn(function()
    while localValue28 do
      if not helperFunction20() then
        break
      end

      task.wait(1)
    end
  end)
end

function localValue45.StopGardening()
  localValue28 = false
end

function localValue45.Intelligence()
  local localValue53 = helperFunction2()

  if not localValue53 then
    helperFunction1("Error", "Intelligence: Plot haven't loaded", 5)
    return
  else
    local localValue54 = helperFunction6(localValue53:WaitForChild("House"), localValue26)

    if not localValue54 then
      helperFunction1("Error", "Intelligence: Cannot find TV", 5)
      return
    end

    helperFunction8(localValue54)

    if not helperFunction15(localValue54) then
      helperFunction4(localValue54, "Turn On")
      task.wait(0.5)
      helperFunction7(3)
      task.wait(1)
      local localValue55 = false

      for j = 1, 20 do
        if helperFunction4(localValue54, "Watch") then
          localValue55 = true
          break
        end

        task.wait(0.1)
      end

      if not localValue55 then
        helperFunction1("Error", "BoostFunTV: Cannot find Watch button after turning on TV", 5)
        return
      end

      return
    end

    helperFunction4(localValue54, "Watch")
    return
  end
end

function localValue45.Music()
  local localValue56 = helperFunction2()

  if not localValue56 then
    helperFunction1("Error", "Music: Plot haven't loaded", 5)
    return
  else
    local localValue57 = helperFunction6(localValue56:WaitForChild("House"), {
      "Acoustic Guitar",
      "Electric Guitar",
      "Classic Piano",
      "Modern Guitar",
      "Fine Piano",
      "DJ Booth",
    })

    if not localValue57 then
      helperFunction1("Error", "Music: Cannot find Stereo", 5)
      return
    end

    helperFunction8(localValue57)

    if
      localValue57.Name == "Acoustic Guitar"
      or localValue57.Name == "Electric Guitar"
      or localValue57.Name == "Modern Guitar"
    then
      helperFunction4(localValue57, "Use")
      task.wait(1)
      helperFunction14()
    else
      helperFunction4(localValue57, "Play")
      task.wait(0.5)
      firesignal(localPlayer.PlayerGui._interactUI.Center.Button.Activated)
    end

    return
  end
end

function localValue45.Athletic()
  local localValue58 = helperFunction2()

  if not localValue58 then
    helperFunction1("Error", "Athletic: Plot haven't loaded", 5)
    return
  else
    local localValue59 = helperFunction6(localValue58:WaitForChild("House"), { "Yoga Mat" })

    if not localValue59 then
      helperFunction1("Error", "Athletic: Cannot find Yoga Mat", 5)
      return
    end

    helperFunction8(localValue59)
    helperFunction4(localValue59, "Use")
    return
  end
end

function localValue45.Painting()
  local localValue60 = helperFunction2()

  if not localValue60 then
    helperFunction1("Error", "Painting: Plot haven't loaded", 5)
    return
  else
    local localValue61 = helperFunction6(localValue60:WaitForChild("House"), { "Painting Stand" })

    if not localValue61 then
      helperFunction1("Error", "Painting: Cannot find Easel", 5)
      return
    end

    helperFunction8(localValue61)
    helperFunction4(localValue61, "Interact")
    task.wait(0.5)
    firesignal(localPlayer.PlayerGui._interactUI.Center:GetChildren()[2].Activated)
    return
  end
end

function localValue45.Writing()
  local localValue62 = helperFunction22()

  if not localValue62 then
    helperFunction1("Error", "Writing: Cant find any devices in your plot", 5)
    return
  else
    local basePart3 = localValue62:IsA("BasePart") and localValue62
      or localValue62.PrimaryPart
      or localValue62:FindFirstChildWhichIsA("BasePart")

    if not basePart3 then
      helperFunction1("Error", "Writing: Device's part is null", 5)
      return
    end

    helperFunction8(basePart3)
    task.wait(0.3)

    if not pcall(function()
      helperFunction4(localValue62, "Interact")
    end) then
      helperFunction1("Error", "Writing: Cant Interact", 5)
      return
    else
      task.wait(0.5)

      local function helperFunction26()
        local waitForChild3 =
          players.LocalPlayer.PlayerGui:WaitForChild("_interactUI", 5):WaitForChild("Center", 5)

        if not waitForChild3 then
          helperFunction1("Error", "Writing: Center UI null", 3)
          return false
        end

        for index22, value22 in ipairs(waitForChild3:GetChildren()) do
          local localValue63 = value22

          if localValue63:IsA("GuiButton") then
            local textLabel3 = localValue63:FindFirstChild("TextLabel")

            if textLabel3 and textLabel3.Text == "Write Book" then
              pcall(function()
                firesignal(localValue63.Activated)
              end)
              return true
            end
          end
        end

        helperFunction1("Error", "Writing: Write Book button null", 3)
        return false
      end

      if not helperFunction26() then
        helperFunction1("Error", "Writing: Write Book error with clicking", 3)
      end

      return
    end
  end
end

function localValue45.Gaming()
  local localValue64 = helperFunction25()

  if not localValue64 then
    helperFunction1("Error", "PlayDevice: Can't find any device in plot", 5)
    return
  else
    local basePart4 = localValue64:IsA("BasePart") and localValue64
      or localValue64.PrimaryPart
      or localValue64:FindFirstChildWhichIsA("BasePart")

    if not basePart4 then
      return warn("[PlayDevice] Device part null")
    end

    helperFunction8(basePart4)
    task.wait(0.3)
    helperFunction4(localValue64, "Interact")
    task.wait(0.5)

    if not helperFunction23("Play", 3) then
      return
    end

    task.wait(0.5)
    helperFunction23("Ping Pong", 5)
    return
  end
end

return localValue45
