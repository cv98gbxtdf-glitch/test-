-- [ LeakD ] Тһіѕ Filе Ԝaѕ Deоbfuscаtеԁ Bу LеаκD
-- [ Source ] https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local humanoidRootPart = localPlayer.Character
  and localPlayer.Character:FindFirstChild("HumanoidRootPart")

local localValue1 = require(
  localPlayer
    :WaitForChild("PlayerScripts")
    :WaitForChild("Modules")
    :WaitForChild("InteractionHandler")
)
harvest = {}

local localValue2 = {
  ["Tomato Plant"] = true,
  ["Strawberry Bush"] = true,
  ["Berry Bush"] = true,
  ["Apple Tree"] = true,
  ["Watermelon Plant"] = true,
  ["Rose Bush"] = true,
  ["Orange Tree"] = true,
  ["Pear Tree"] = true,
  ["Lemon Tree"] = true,
  ["Coconut Palm Tree"] = true,
}

local localValue3 = {}

local function helperFunction1(parameter1, parameter2)
  for index, value in ipairs(parameter1:GetChildren()) do
    local textLabel = value:FindFirstChildOfClass("TextLabel")

    if textLabel and string.find(textLabel.Text, parameter2) then
      if value:IsA("GuiButton") or value:FindFirstChildOfClass("GuiButton") then
        firesignal(
          (value:IsA("GuiButton") and value or value:FindFirstChildOfClass("GuiButton")).Activated
        )
        return true
      elseif value:FindFirstChild("Activated") then
        firesignal(value.Activated)
        return true
      end
    end
  end

  return false
end

local function helperFunction2(parameter3)
  for index2, value2 in ipairs(parameter3:GetChildren()) do
    if localValue2[value2.Name] then
      table.insert(localValue3, value2)
    end

    helperFunction2(value2)
  end
end

local function helperFunction3(parameter4, parameter5)
  if not parameter4 then
    return
  else
    local vector = parameter5
    vector = parameter5 or Vector3.new(0, 0, -5)

    local localValue4 = parameter4.Position + vector
    local magnitude = (humanoidRootPart.Position - localValue4).Magnitude
    local localValue5 = math.clamp(magnitude / 23, 0.3, 4)
    local unit = (parameter4.Position - humanoidRootPart.Position).Unit
    local cframe = CFrame.new(localValue4, localValue4 + unit)
    local canCollide = humanoidRootPart.CanCollide
    humanoidRootPart.CanCollide = false

    local create = tweenService:Create(
      humanoidRootPart,
      TweenInfo.new(localValue5, Enum.EasingStyle.Linear),
      { CFrame = cframe }
    )

    create:Play()
    create.Completed:Wait()

    humanoidRootPart.CanCollide = canCollide
    return
  end
end

local localValue6 = false
local helperFunction4

local function helperFunction5()
  while localValue6 do
    for index3, value3 in ipairs(localValue3) do
      if not localValue6 then
        break
      else
        local objectModel = value3:FindFirstChild("ObjectModel")

        if objectModel then
          local harvestPart = objectModel:FindFirstChild("HarvestPart")

          if harvestPart and (harvestPart:IsA("Part") or harvestPart:IsA("MeshPart")) then
            if harvestPart.Transparency == 0 then
              helperFunction3(harvestPart)
              task.wait(0.1)
              local localValue7 = false

              for i = 1, 3 do
                if not localValue6 then
                  break
                else
                  helperFunction4(value3, "Interact")
                  local interactUI = playerGui:FindFirstChild("_interactUI")
                  local center = interactUI and interactUI:FindFirstChild("Center")

                  if center then
                    localValue7 = helperFunction1(center, "Harvest")

                    if localValue7 then
                      break
                    end
                  else
                    helperFunction3(harvestPart)
                    task.wait(0.5)
                  end

                  task.wait(0.1)
                end
              end

              if not localValue7 then
                warn("Failed after " .. 3 .. " attempts for plant " .. value3.Name)
              end

              task.wait(8)
            end
          end
        end
      end
    end

    task.wait(0.5)
  end
end

function helperFunction4(parameter6, parameter7)
  if not parameter6 or typeof(parameter6) ~= "Instance" then
    return false
  end

  local localValue8 = nil
  local primaryPart = nil

  if parameter6:IsA("BasePart") then
    primaryPart = parameter6
    localValue8 = parameter6
  elseif parameter6:IsA("Model") then
    localValue8 = parameter6
    primaryPart = parameter6.PrimaryPart or parameter6:FindFirstChildWhichIsA("BasePart")
  end

  local localValue9

  if not primaryPart or not localValue1 then
    return false
  else
    pcall(function()
      localValue1:ShowMenu(localValue8 or primaryPart, primaryPart.Position, primaryPart)
    end)
    task.wait(0.15)
    local interactUI2 = playerGui:FindFirstChild("_interactUI")

    local center2 = interactUI2
    center2 = interactUI2 and interactUI2:FindFirstChild("Center")

    if not center2 then
      return false
    else
      local getChildren = center2.GetChildren
      localValue9 = nil

      for index4, value4 in ipairs(getChildren(center2)) do
        local textLabel2 = value4:FindFirstChildWhichIsA("TextLabel")

        if textLabel2 and textLabel2.Text == parameter7 then
          localValue9 = value4
          break
        end
      end

      if not localValue9 then
        return false
      end

      pcall(function()
        firesignal((localValue9:FindFirstChildWhichIsA("GuiButton") or localValue9).Activated)
      end)
      task.wait(0.01)
      return true
    end
  end
end

function harvest.startAutoFarm()
  if localValue6 then
    warn("Already run")
    return
  else
    localValue3 = {}
    local localValue10 = "Plot_" .. localPlayer.Name
    local plots = workspace:FindFirstChild("Plots")

    if plots then
      local findFirstChild = plots:FindFirstChild(localValue10)

      if
        findFirstChild
        and findFirstChild:FindFirstChild("House")
        and findFirstChild.House:FindFirstChild("Objects")
      then
        helperFunction2(findFirstChild.House.Objects)

        if #localValue3 == 0 then
          warn("No plants found to harvest")
          return
        end

        localValue6 = true
        task.spawn(helperFunction5)
        print("Harvest started")
        return
      end

      warn("Player plot or house not found")
      return
    end

    warn("Workspace.Plots not found")
    return
  end
end

function harvest.stopAutoFarm()
  if not localValue6 then
    warn("Not running")
    return
  end

  localValue6 = false
  print("Harvest stopped")
end

return harvest
