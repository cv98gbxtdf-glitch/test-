-- Orіgіnаl Соԁе Dеobfuѕсаtеԁ Ву LеаκD
-- https://discord.gg/AwGHNh7Z7T

local workspaceService = game:GetService("Workspace")
local pathfindingService = game:GetService("PathfindingService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localValue1 = {}
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local currentCamera = workspaceService.CurrentCamera

local localValue2 = {
  Candlestick = "Candlestick",
  Pitcher = "PitcherVase",
  ["Bouquet Vase"] = "BouquetVase",
  Bowl = "BowlVase",
  UrnVase = "UrnVase",
  Teapot = "Teapot",
}

local function helperFunction1(parameter1)
  return localValue2[parameter1.Text
    :gsub("Sculpt a Clay ", "")
    :gsub("Sculpt an Clay ", "")
    :match("^%s*(.-)%s*$")]
end

local function helperFunction2(parameter2)
  local text = parameter2.Text

  if text:find("Paint the sculpture with ") then
    return (text:gsub("Paint the sculpture with ", ""))
  end

  return nil
end

function pathfind(parameter3, parameter4)
  local getControls = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
  getControls:Disable()

  local character2 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoidRootPart2 = character2:WaitForChild("HumanoidRootPart")
  local humanoid2 = character2:WaitForChild("Humanoid")
  local path

  if type(parameter4) == "table" then
    path = pathfindingService:CreatePath(parameter4)
  else
    path = pathfindingService:CreatePath()
  end

  pcall(function()
    path:ComputeAsync(humanoidRootPart2.Position, parameter3)
  end)

  if path.Status == Enum.PathStatus.Success then
    local localValue3 = next
    local localValue4, localValue5 = path:GetWaypoints()

    for localValue6, localValue7 in localValue3, localValue4, localValue5 do
      if not isFarming then
        break
      end

      humanoid2:MoveTo(localValue7.Position)

      if localValue7.Action == Enum.PathWaypointAction.Jump then
        humanoid2.Jump = true
      end

      humanoid2.MoveToFinished:Wait()
    end
  end

  getControls:Enable()
end

local function helperFunction3(parameter5, parameter6)
  local path2 = pathfindingService:CreatePath({
    AgentRadius = 2,
    AgentHeight = 5,
    AgentCanJump = false,
  })

  path2:ComputeAsync(
    humanoidRootPart.Position,
    parameter5.Position - (parameter5.Position - humanoidRootPart.Position).Unit * (parameter6 or 6)
  )

  if path2.Status ~= Enum.PathStatus.Success then
    return false
  end

  for index, value in ipairs(path2:GetWaypoints()) do
    humanoid:MoveTo(value.Position)

    if not humanoid.MoveToFinished:Wait() then
      return false
    elseif value.Action == Enum.PathWaypointAction.Jump then
      humanoid.Jump = true
    end
  end

  return true
end

local dataService = replicatedStorage.Modules.DataService
local localValue8 = {}
local localValue9 =
  getconnections(({ data_manager = dataService }).data_manager.DescendantAdded)[1].Function
local localValue10 = getupvalue(localValue9, 1)
local localValue11 = next
local localValue12, localValue13 = getupvalue(getupvalue(localValue9, 2), 1)

for localValue14, localValue15 in localValue11, localValue12, localValue13 do
  local sub = localValue15:sub(1, 2) == "F_" and localValue15:sub(3) or localValue15
  localValue8[sub] = localValue10[localValue14]
end

local function helperFunction4()
  pcall(function()
    firesignal(players.LocalPlayer.PlayerGui._interactUI.InteractIndicator.Activated)
  end)

  task.wait(1)

  pcall(function()
    firesignal(players.LocalPlayer.PlayerGui._interactUI.Center.Button.Activated)
  end)
end

local function helperFunction5(parameter7)
  local humanoidRootPart3 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )
  local localValue16 = Vector3.new(parameter7.X, humanoidRootPart3.Position.Y, parameter7.Z)
    - humanoidRootPart3.Position

  if localValue16.Magnitude > 0 then
    local unit = localValue16.Unit

    humanoidRootPart3.CFrame =
      CFrame.new(humanoidRootPart3.Position, humanoidRootPart3.Position + unit)

    task.wait()

    currentCamera.CFrame = CFrame.new(
      currentCamera.CFrame.Position,
      currentCamera.CFrame.Position + humanoidRootPart3.CFrame.LookVector
    )
  end
end

local localValue17 = false

function localValue1.stopArt()
  localValue17 = false
end

function localValue1.startArt()
  local pottersWheel4, localValue18, paintingEquipment1, main, textLabelLeft

  if localValue17 then
    return
  else
    localValue17 = true
    helperFunction3({ Position = Vector3.new(954.544921875, 27.305213928223, -252.47940063477) }, 0)
    task.wait(1)
    local gameplay = workspaceService
      :WaitForChild("Environment")
      :WaitForChild("Locations")
      :WaitForChild("SchoolArea")
      :WaitForChild("School")
      :WaitForChild("Interior")
      :WaitForChild("Floor1")
      :WaitForChild("Part1")
      :WaitForChild("Art")
      :WaitForChild("Interior")
      :WaitForChild("Gameplay")
    local pottersWheelParent = gameplay:WaitForChild("PottersWheelParent")
    local waitForChild = gameplay.WaitForChild
    pottersWheel4 = pottersWheelParent:WaitForChild("PottersWheel4")
    localValue18 = waitForChild(gameplay, "BrickKiln1")
    paintingEquipment1 = gameplay:WaitForChild("PaintingEquipment1")
    main = localValue18:FindFirstChild("Main")
    textLabelLeft = localPlayer
      :WaitForChild("PlayerGui")
      :WaitForChild("TopbarGui")
      :WaitForChild("Topbar")
      :WaitForChild("Header")
      :WaitForChild("SchoolHeader")
      :WaitForChild("SchoolFooter")
      :WaitForChild("FrameLeftBottom")
      :WaitForChild("TextLabelLeft")

    task.spawn(function()
      local localValue19, origin, kilnProgressUI, progressBar, localValue20, backgroundColor3, localValue21, localValue22, origin2, localValue23

      while localValue17 do
        localValue19 = helperFunction1(textLabelLeft)

        if localValue19 then
          origin = pottersWheel4:FindFirstChild("Origin")

          if not origin then
            print("potter don't have main part", origin)
          else
            helperFunction3(origin, 3)
            task.wait(2)

            localValue8.RequestAttachAndSculpt:FireServer({
              AttachOptions = {
                DetachCarried = true,
                LookStrength = 0.2,
                Animation = "CookApplianceIdle",
                NoEquipped = true,
              },
              TargetObject = pottersWheel4,
              SculptureType = localValue19,
              Duration = 3,
            })

            task.wait(4)
            helperFunction3(main, 4)
            task.wait(2)
            helperFunction5(main.Position)
            task.wait(1)
            helperFunction4()
            task.wait(1)
            kilnProgressUI =
              workspaceService.Environment.Locations.SchoolArea.School.Interior.Floor1.Part1.Art.Interior.Gameplay.BrickKiln1.KilnProgressUI
            progressBar = kilnProgressUI:WaitForChild("Background"):WaitForChild("ProgressBar")
            localValue20 = false

            for i = 1, 300 do
              if not localValue17 then
                return
              end

              if not progressBar or not progressBar.Parent then
                progressBar = kilnProgressUI.Background:WaitForChild("ProgressBar")
              end

              backgroundColor3 = progressBar.BackgroundColor3
              localValue22 = math.floor(backgroundColor3.R * 255)
              localValue21 = math.floor(backgroundColor3.G * 255)

              if localValue22 == 255 and localValue21 >= 100 and localValue21 <= 250 then
                print("Kiln ready → Taking sculpture...")
                helperFunction5(main.Position)
                localValue8.RequestInteractKiln:FireServer({ KilnInstance = localValue18 })
                task.wait(0.4)
                localValue20 = true
                break
              end

              task.wait(0.1)
            end

            if not localValue20 then
              warn("⚠️ Kiln timeout or color never reached → force Take")
              helperFunction5(localValue18.Position)
              localValue8.RequestInteractKiln:FireServer({ KilnInstance = localValue18 })
              task.wait(0.4)
            end

            task.wait(0.5)
            origin2 = paintingEquipment1:FindFirstChild("Origin")
            helperFunction3(origin2, 3)
            task.wait(1)
            local gsub
            local paintingDone = false

            while localValue17 and not paintingDone do
              localValue23 = helperFunction2(textLabelLeft)

              if textLabelLeft.Text:find("Paint the sculpture with ") then
                gsub = textLabelLeft.Text:gsub("Paint the sculpture with ", "")
              end

              task.wait(0.1)

              if localValue23 then
                helperFunction5(origin2.Position)
                task.wait(1)

                pcall(function()
                  firesignal(
                    localPlayer.PlayerGui:WaitForChild("_interactUI").InteractIndicator.Activated
                  )
                end)

                task.wait(0.8)

                pcall(function()
                  for index2, value2 in
                    ipairs(localPlayer.PlayerGui._interactUI.Center:GetChildren())
                  do
                    local textLabel = value2:FindFirstChildWhichIsA("TextLabel")

                    if textLabel and gsub then
                      local localValue24 = string.lower(textLabel.Text)
                      local localValue25 = string.lower(gsub)

                      if string.find(localValue24, localValue25) then
                        firesignal(value2.Activated)
                        firesignal(value2.MouseButton1Click)
                        break
                      end
                    end
                  end
                end)

                task.wait(4.5)

                humanoid:MoveTo(Vector3.new(931.79266357422, 27.305213928223, -248.25802612305))
                humanoid.MoveToFinished:Wait()

                helperFunction5(
                  workspaceService.Environment.Locations.SchoolArea.School.NPCs["Art Teacher"].HumanoidRootPart.Position
                )
                task.wait(1)
                helperFunction4()
                task.wait(0.5)
                paintingDone = true
              end
            end

            if not localValue17 then
              return
            end
          end
        end
      end
    end)

    return
  end
end

getgenv().ArtModule = localValue1
return localValue1
