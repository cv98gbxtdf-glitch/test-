-- Orіgіnаl Cоԁе Dеоbfuѕсatеԁ Вy LеаκD
-- https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local modules = localPlayer.PlayerScripts:FindFirstChild("Modules")

assert(modules, "Modules not found")

assert(require(modules:FindFirstChild("InteractionHandler")), "Cannot require InteractionHandler")

local dataService = replicatedStorage.Modules.DataService
local localValue1 = {}
local localValue2 = getconnections(dataService.DescendantAdded)[1].Function
local localValue3 = getupvalue(localValue2, 1)
local localValue4 = next
local localValue5, localValue6 = getupvalue(getupvalue(localValue2, 2), 1)

for localValue7, localValue8 in localValue4, localValue5, localValue6 do
  local sub = localValue8:sub(1, 2) == "F_" and localValue8:sub(3) or localValue8
  localValue1[sub] = localValue3[localValue7]
end

local function helperFunction1(parameter1)
  if not parameter1 or not parameter1.Parent then
    return false
  else
    local inUse = parameter1:FindFirstChild("InUse")

    if not inUse or inUse.Value ~= localPlayer then
      return false
    end

    return true
  end
end

local localValue9 = { autoFarmRunning = false, claimedWorkstation = nil }

local function helperFunction2(parameter2)
  local character = localPlayer.Character
  local localValue10, connect

  if not character then
    return false
  else
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
      return false
    end

    humanoid:MoveTo(parameter2)
    localValue10 = false

    connect = nil

    connect = humanoid.MoveToFinished:Connect(function()
      localValue10 = true
      connect:Disconnect()
    end)

    while not localValue10 do
      if not localValue9.autoFarmRunning then
        humanoid:MoveTo(character.PrimaryPart.Position)
        return false
      end

      task.wait(0.1)
    end

    return true
  end
end

local function helperFunction3(parameter3)
  if not parameter3 then
    return
  else
    local done = parameter3:FindFirstChild("Display")
      and parameter3.Display:FindFirstChild("Screen")
      and parameter3.Display.Screen:FindFirstChild("CashierGUI")
      and parameter3.Display.Screen.CashierGUI:FindFirstChild("Frame")
      and parameter3.Display.Screen.CashierGUI.Frame:FindFirstChild("Done")

    if done and done:IsA("GuiButton") then
      task.defer(function()
        pcall(function()
          firesignal(done.Activated)
        end)
      end)
      print("Pressed Done")
    end

    return
  end
end

local function helperFunction4(parameter4)
  local bags = parameter4:FindFirstChild("Bags")

  if not bags then
    return 0
  else
    local count = 0

    for key, value in pairs(bags:GetChildren()) do
      if value:IsA("BasePart") and value.Transparency == 0 then
        count = count + 1
      end
    end

    return count
  end
end

local function helperFunction5()
  if helperFunction1(localValue9.claimedWorkstation) then
    return localValue9.claimedWorkstation
  else
    local cashierWorkstations =
      workspaceService.Environment.Locations.City.Supermarket.Interior:FindFirstChild(
        "CashierWorkstations"
      )

    if not cashierWorkstations then
      return nil
    else
      local character2 = localPlayer.Character

      if not character2 or not character2.PrimaryPart then
        return nil
      else
        local localValue11 = nil
        local huge = math.huge

        for key2, value2 in pairs(cashierWorkstations:GetChildren()) do
          if
            value2.Name == "Workstation"
            and value2:FindFirstChild("BagHolder")
            and value2:FindFirstChild("InUse")
            and value2.InUse.Value == nil
          then
            local primaryPart = value2.BagHolder.PrimaryPart

            local basePart = primaryPart
            basePart = primaryPart or value2.BagHolder:FindFirstChildWhichIsA("BasePart")

            if basePart then
              local magnitude = (character2.PrimaryPart.Position - basePart.Position).Magnitude

              if magnitude < huge then
                huge = magnitude
                localValue11 = value2
              end
            end
          end
        end

        if localValue11 and localValue11.BagHolder then
          local primaryPart2 = localValue11.BagHolder.PrimaryPart

          local basePart2 = primaryPart2
          basePart2 = primaryPart2 or localValue11.BagHolder:FindFirstChildWhichIsA("BasePart")

          if basePart2 and helperFunction2(basePart2.Position) then
            task.wait(1)
            local bagsLeft = localValue11:FindFirstChild("BagsLeft")

            if not bagsLeft or bagsLeft.Value <= 0 then
              helperFunction3(localValue11)
              print("[INFO] Workstation hết BagHolder khi claim → Done 1 lần rồi bỏ")
              return nil
            end

            print("Claimed new workstation:", localValue11.Name)
            localValue9.claimedWorkstation = localValue11
            return localValue11
          end

          return nil
        end

        return nil
      end
    end
  end
end

local cframe = CFrame.new(532.849243, 20.8600121, -764.018677, 0, 0, 1, 0, 1, 0, -1, 0, 0)
local localValue12 = 0

local function helperFunction6(parameter5)
  if
    not parameter5
    or not parameter5:FindFirstChild("DroppedFood")
    or not parameter5:FindFirstChild("BagHolder")
  then
    return
  else
    local getChildren = parameter5.DroppedFood:GetChildren()
    local localValue13 = math.max(1, math.ceil(#getChildren / 3))
    local localValue14 = helperFunction4(parameter5)

    while localValue14 < localValue13 do
      localValue1.TakeNewBag:FireServer({ Workstation = parameter5 })
      task.wait(1)
      localValue14 = helperFunction4(parameter5)
    end

    return
  end
end

local function helperFunction7(parameter6)
  if not parameter6 then
    return
  elseif tick() - localValue12 < 2 then
    return
  else
    local bagsLeft2 = parameter6:FindFirstChild("BagsLeft")

    if not bagsLeft2 or bagsLeft2.Value > 0 then
      return
    else
      local bagCrate =
        workspaceService.Environment.Locations.City.Supermarket.Geometry.Crates.BagCrate

      if not bagCrate then
        return
      elseif not helperFunction2(cframe.Position) then
        return
      elseif not helperFunction2(bagCrate.Position) then
        return
      else
        localValue1.TakeNewBags:FireServer({ Object = bagCrate })
        task.wait(0.6)
        local scanner = parameter6:FindFirstChild("Scanner")

        if scanner and parameter6.BagHolder then
          if
            (
              parameter6.BagHolder.PrimaryPart
              or parameter6.BagHolder:FindFirstChildWhichIsA("BasePart")
            ) and helperFunction2(scanner.Position)
          then
            localValue1.RestockBags:FireServer({ Workstation = parameter6 })
          end
        end

        localValue12 = tick()
        return
      end
    end
  end
end

function GoToWork(parameter7, name)
  local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter7 then
    return
  end

  if (humanoidRootPart.Position - parameter7).Magnitude >= 10 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

function localValue9.startAutoFarm(parameter8)
  if parameter8.autoFarmRunning then
    return
  end

  parameter8.autoFarmRunning = true
  local localValue15 = false
  GoToWork(Vector3.new(547.81072998047, 23.33768081665, -721.52856445312), "SupermarketCashier")

  parameter8.thread = task.spawn(function()
    while parameter8.autoFarmRunning do
      if not helperFunction1(parameter8.claimedWorkstation) then
        parameter8.claimedWorkstation = helperFunction5()

        if not parameter8.claimedWorkstation then
          print("Waiting for free workstation...")
          task.wait(2)
        end
      end

      local claimedWorkstation = parameter8.claimedWorkstation

      if claimedWorkstation then
        localValue15 = false
        local droppedFood = claimedWorkstation:FindFirstChild("DroppedFood")

        if droppedFood and #droppedFood:GetChildren() > 0 then
          helperFunction7(claimedWorkstation)
          helperFunction6(claimedWorkstation)

          for key3, value3 in pairs(droppedFood:GetChildren()) do
            if not parameter8.autoFarmRunning then
              break
            elseif value3.Parent == droppedFood then
              if not localValue1.ScanDroppedItem:FireServer({ Item = value3 }) then
                localValue1.TakeNewBag:FireServer({ Workstation = claimedWorkstation })
                task.wait(0.8)
                localValue1.ScanDroppedItem:FireServer({ Item = value3 })
              end

              task.wait(1.5)
            end
          end
        elseif not localValue15 then
          helperFunction3(claimedWorkstation)
          localValue15 = true
          task.wait(4)
          print("Waiting for next customer...")
        end
      end

      task.wait(0.5)
    end
  end)
end

function localValue9.stopAutoFarm(parameter9)
  parameter9.autoFarmRunning = false
  parameter9.claimedWorkstation = nil

  if parameter9.thread then
    task.cancel(parameter9.thread)
    parameter9.thread = nil
  end
end

return localValue9
