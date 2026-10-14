---@source Dеobfuѕcаted Ԝіtһ LeаκD
---@see https://discord.gg/AwGHNh7Z7T

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local localValue1 = false
local vector = Vector3.new(0, 0, 0)
local localValue2 = 40
local localValue3 = localValue2
local localValue4 = 0
local localValue5 = 0
local localValue6 = false
local localValue7 = false
local connect, connect2, connect3, connect4

local function helperFunction1()
  humanoidRootPart.Anchored = true

  local currentCamera = workspace.CurrentCamera
  currentCamera.CameraType = Enum.CameraType.Scriptable
  currentCamera.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, 5, 0))

  vector = Vector3.new(0, 0, 0)
  localValue3 = localValue2
  localValue4 = 0
  localValue5 = 0
  localValue6 = false
  localValue7 = false
  humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

  connect = userInputService.InputBegan:Connect(function(input, parameter1)
    if parameter1 then
      return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard then
      local keyCode = input.KeyCode

      if keyCode == Enum.KeyCode.W then
        vector = vector + Vector3.new(0, 0, 1)
      end

      if keyCode == Enum.KeyCode.S then
        vector = vector + Vector3.new(0, 0, -1)
      end

      if keyCode == Enum.KeyCode.A then
        vector = vector + Vector3.new(-1, 0, 0)
      end

      if keyCode == Enum.KeyCode.D then
        vector = vector + Vector3.new(1, 0, 0)
      end

      if keyCode == Enum.KeyCode.E or keyCode == Enum.KeyCode.Space then
        vector = vector + Vector3.new(0, 1, 0)
      end

      if keyCode == Enum.KeyCode.Q then
        vector = vector + Vector3.new(0, -1, 0)
      end

      if keyCode == Enum.KeyCode.LeftShift or keyCode == Enum.KeyCode.RightShift then
        localValue7 = true
        localValue3 = localValue2 * 2
      end
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
      localValue6 = true
      userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
      userInputService.MouseIconEnabled = false
    end
  end)

  connect2 = userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.Keyboard then
      local keyCode2 = input2.KeyCode

      if keyCode2 == Enum.KeyCode.W then
        vector = vector - Vector3.new(0, 0, 1)
      end

      if keyCode2 == Enum.KeyCode.S then
        vector = vector - Vector3.new(0, 0, -1)
      end

      if keyCode2 == Enum.KeyCode.A then
        vector = vector - Vector3.new(-1, 0, 0)
      end

      if keyCode2 == Enum.KeyCode.D then
        vector = vector - Vector3.new(1, 0, 0)
      end

      if keyCode2 == Enum.KeyCode.E or keyCode2 == Enum.KeyCode.Space then
        vector = vector - Vector3.new(0, 1, 0)
      end

      if keyCode2 == Enum.KeyCode.Q then
        vector = vector - Vector3.new(0, -1, 0)
      end

      if keyCode2 == Enum.KeyCode.LeftShift or keyCode2 == Enum.KeyCode.RightShift then
        localValue7 = false
        localValue3 = localValue2
      end
    elseif input2.UserInputType == Enum.UserInputType.MouseButton2 then
      localValue6 = false
      userInputService.MouseBehavior = Enum.MouseBehavior.Default
      userInputService.MouseIconEnabled = true
    end
  end)

  connect3 = userInputService.InputChanged:Connect(function(input3)
    if input3.UserInputType == Enum.UserInputType.MouseMovement and localValue6 then
      localValue4 = localValue4 - input3.Delta.X * 0.8
      localValue5 = localValue5 - input3.Delta.Y * 0.8
    elseif input3.UserInputType == Enum.UserInputType.MouseWheel then
      localValue2 = math.clamp(localValue2 + input3.Position.Z * 2, 2, 200)
      localValue3 = localValue7 and localValue2 * 2 or localValue2
    end
  end)

  connect4 = runService.RenderStepped:Connect(function(delta)
    local currentCamera2 = workspace.CurrentCamera
    local localValue8 = CFrame.Angles(0, math.rad(localValue4), 0)
      * CFrame.Angles(math.rad(localValue5), 0, 0)
    local lookVector = localValue8.LookVector
    local vector2 = Vector3.new(lookVector.X, 0, lookVector.Z)
    local rightVector = localValue8.RightVector
    local vector3 = Vector3.new(rightVector.X, 0, rightVector.Z)
    local vector4 = Vector3.new(0, 1, 0)
    local unit = vector2.Unit * vector.Z + vector3.Unit * vector.X + vector4 * vector.Y

    if unit.Magnitude > 0 then
      unit = unit.Unit
    end

    currentCamera2.CFrame = CFrame.new(currentCamera2.CFrame.Position + unit * localValue3 * delta)
      * localValue8
  end)
end

local localValue9 = {}

local function helperFunction2()
  if connect then
    connect:Disconnect()
    connect = nil
  end

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  humanoidRootPart.Anchored = false

  local currentCamera3 = workspace.CurrentCamera
  currentCamera3.CameraType = Enum.CameraType.Custom
  currentCamera3.CameraSubject = humanoid

  userInputService.MouseBehavior = Enum.MouseBehavior.Default
  userInputService.MouseIconEnabled = true

  vector = Vector3.new(0, 0, 0)
  humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
end

function localValue9.Set(parameter2)
  if parameter2 and not localValue1 then
    helperFunction1()
    localValue1 = true
  elseif not parameter2 and localValue1 then
    helperFunction2()
    localValue1 = false
  end
end

function localValue9.Toggle()
  localValue9.Set(not localValue1)
end

function localValue9.IsFlying()
  return localValue1
end

return localValue9
