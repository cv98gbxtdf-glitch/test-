-- PreviewBuild  (module23, goto-cleaned)
-- Real renderer: reads the same schema save_house emits, builds a
-- BuildPreviewer model in workspace with floors, paths, roofs, walls
-- (with door/window cutouts), fences, pools (with ground CSG), objects.

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local workspaceService = game:GetService("Workspace")

if not getgenv().BUILD_OPTION then
  getgenv().BUILD_OPTION = {}
end

if getgenv().BUILD_OPTION.ShowStructuralItems == nil then
  getgenv().BUILD_OPTION.ShowStructuralItems = true
end

local localPlayer = players.LocalPlayer
local localValue1 = {}
local localValue2
pcall(function()
  localValue2 = require(replicatedStorage.Modules._Utilities.Polygon)
end)
local localValue3
pcall(function()
  localValue3 = require(replicatedStorage.Modules.ResizeService)
end)
local localValue4
pcall(function()
  localValue4 = require(replicatedStorage.Modules._Utilities.UDim3DManager)
end)
pcall(function()
  require(replicatedStorage.Modules._Objects.ElevatorService)
end)

local localValue5 = require(replicatedStorage.Modules.ColorService)
require(replicatedStorage.Modules._Data.MaterialData)
local jobManager = require(localPlayer.PlayerScripts.Modules.JobHandler)
local dataManager = require(replicatedStorage.Modules.DataService)
local vehicleManager = require(replicatedStorage.Modules.VehicleService)
local notificationUi = require(localPlayer.PlayerScripts.Modules._UI.NotificationUI)
local guiHandler = require(localPlayer.PlayerScripts.Modules._Utilities.GUIHandler)
local skillData = require(replicatedStorage.Modules._Data.SkillData)
local itemData = require(replicatedStorage.Modules.ItemService.ItemData)()
local itemService = require(replicatedStorage.Modules.ItemService)
local foodService = require(replicatedStorage.Modules.FoodService)
local billService = require(replicatedStorage.Modules.BillService)
local equipService = require(replicatedStorage.Modules.EquipmentService)

local localValue6 = {
  job_manager = jobManager,
  data_manager = dataManager,
  vehicle_manager = vehicleManager,
  player_stats = replicatedStorage.Stats[localPlayer.Name],
  notification_ui = notificationUi,
  gui_handler = guiHandler,
  skill_data = skillData,
  item_data = itemData,
  item_service = itemService,
  food_service = foodService,
  bill_service = billService,
  equip_service = equipService,
}

local localValue7 = {}

local function helperFunction1(parameter1, parameter2, parameter3)
  local text = string.format("[PreviewBuild] %s: %s", tostring(parameter1), tostring(parameter2))
  if parameter1 == "Error" then
    warn(text)
  else
    print(text)
  end
end

local localValue8 = {
  Transparency = 0,
  WaterTransparency = 0.8,
  CastShadow = false,
  DefaultMaterial = Enum.Material.SmoothPlastic,
  DefaultColor = BrickColor.new("Institutional white"),
}

local localValue9 = os.clock()
local function helperFunction2()
  if os.clock() - localValue9 >= 0.012 then
    task.wait()
    localValue9 = os.clock()
  end
end

local localValue10 = syn and syn.request
  or http and http.request
  or http_request
  or fluxus and fluxus.request
  or request

local function helperFunction3(parameter4)
  if not parameter4 then
    return nil
  end
  if type(parameter4) == "table" then
    if #parameter4 == 3 then
      return Vector3.new(parameter4[1], parameter4[2], parameter4[3])
    end
    if #parameter4 == 12 then
      return CFrame.new(unpack(parameter4))
    end
    return nil
  end
  return nil
end

local localValue11 = {}

local function helperFunction4(parameter5)
  for key, value in pairs(parameter5:GetChildren()) do
    if value:IsA("Model") or value:IsA("BasePart") then
      localValue11[value.Name] = value
    elseif value:IsA("Folder") or value:IsA("ModuleScript") then
      helperFunction4(value)
    end
  end
end

local localValue12
local function helperFunction5(parameter6)
  if not parameter6 then
    return nil
  end
  local requestItemModel = localValue11[parameter6]
  if not requestItemModel and localValue12 then
    pcall(function()
      requestItemModel = localValue12:RequestItemModel(parameter6)
    end)
  end
  if
    requestItemModel
    and not requestItemModel:IsA("Model")
    and not requestItemModel:IsA("BasePart")
  then
    local findFirstChild = requestItemModel:FindFirstChild(parameter6, true)
    if findFirstChild and (findFirstChild:IsA("Model") or findFirstChild:IsA("BasePart")) then
      requestItemModel = findFirstChild
    else
      requestItemModel = nil
    end
  end
  if requestItemModel then
    localValue11[parameter6] = requestItemModel
  end
  return requestItemModel
end

if replicatedStorage:FindFirstChild("Items") then
  helperFunction4(replicatedStorage.Items)
else
  warn("[PreviewBuild] Items is null!")
end

local function helperFunction6(parameter7, parameter8)
  if not parameter7 or not parameter8 then
    return
  end
  local position = nil
  if parameter8.Size then
    position = helperFunction3(parameter8.Size)
  elseif parameter8.PreviewSize then
    position = helperFunction3(parameter8.PreviewSize)
  end
  if not position then
    return
  end
  if typeof(position) == "CFrame" then
    position = position.Position
  end

  local findFirstChild2 = parameter7:FindFirstChild("ResizeRoot1", true)
    or parameter7:FindFirstChild("ResizeRoot", true)
    or parameter7:FindFirstChild("PlaceAll", true)
    or parameter7:FindFirstChild("PlaceWall", true)
    or parameter7:FindFirstChild("Main", true)

  if not findFirstChild2 then
    if parameter7:IsA("BasePart") then
      findFirstChild2 = parameter7
    elseif parameter7:IsA("Model") then
      findFirstChild2 = parameter7.PrimaryPart
      if not findFirstChild2 then
        for key2, value2 in pairs(parameter7:GetDescendants()) do
          if value2:IsA("BasePart") then
            findFirstChild2 = value2
            break
          end
        end
      end
    end
  end

  if not findFirstChild2 then
    return
  end
  local localValue13 = false

  local function applyPlace(parameter9, size, parameter10)
    local parent = parameter9.Parent
    local placeAll = parent:FindFirstChild("PlaceAll") or parent:FindFirstChild("PlaceWall")
    if placeAll then
      placeAll.Size = size
      if parameter10 then
        placeAll.CFrame = parameter10
      end
      if parameter7.Name:lower():find("transparent") or placeAll.Name == "PlaceAll" then
        placeAll.Transparency = 0.75
        placeAll.Material = Enum.Material.Glass
      else
        placeAll.Transparency = 0
      end
    end
    parameter9.Transparency = 1
  end

  if localValue3 and findFirstChild2:GetAttribute("Resize_Axes") then
    pcall(function()
      local localValue14, localValue15 = localValue3:GetResizeRootSize(findFirstChild2, position)
      findFirstChild2.Size = localValue14
      findFirstChild2.CFrame = localValue15
      localValue13 = true
      if findFirstChild2.Name:find("ResizeRoot") then
        applyPlace(findFirstChild2, localValue14, localValue15)
      end
    end)
  end

  if not localValue13 then
    findFirstChild2.Size = position
    if findFirstChild2.Name:find("ResizeRoot") then
      applyPlace(findFirstChild2, position, nil)
    elseif findFirstChild2.Name == "PlaceAll" or findFirstChild2.Name == "PlaceWall" then
      if parameter7.Name:lower():find("transparent") then
        findFirstChild2.Transparency = 0.75
      else
        findFirstChild2.Transparency = 0
      end
    end
  end

  local udim3DRoot = findFirstChild2:FindFirstChild("UDim3DRoot")
    or findFirstChild2:FindFirstChildWhichIsA("ObjectValue")

  if udim3DRoot and localValue4 then
    pcall(function()
      local get
      if type(localValue4.Get) == "function" then
        get = localValue4:Get(udim3DRoot)
      end
      if not get and type(localValue4.new) == "function" then
        get = localValue4.new(udim3DRoot)
      end
      if get and type(get.Update) == "function" then
        get:Update()
      end
    end)
  elseif localValue3 then
    pcall(function()
      localValue3:ForceUpdateUDim3D(findFirstChild2)
    end)
  end
end

local function helperFunction8(parameter11, parameter12)
  local instance = Instance.new("Part", parameter12)
  instance.Anchored = true
  instance.CanCollide = false
  instance.CanCollide = (getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide) ~= false
  instance.CastShadow = localValue8.CastShadow
  instance.Transparency = parameter11.Transparency or localValue8.Transparency
  instance.Material = parameter11.Material or localValue8.DefaultMaterial
  for key3, value3 in next, parameter11, nil do
    if key3 ~= "Transparency" and key3 ~= "Material" then
      instance[key3] = value3
    end
  end
  return instance
end

local function helperFunction9(parameter13, parameter14)
  if not parameter13 or not parameter14 then
    return
  end
  local localValue16 = nil
  local localValue17 = nil
  if type(parameter14) == "table" then
    if type(parameter14[1]) == "number" then
      localValue16 = parameter14[1]
      localValue17 = parameter14[2]
    elseif type(parameter14[1]) == "table" then
      if parameter14[1][1] then
        localValue16 = parameter14[1][1]
      end
      if parameter14[1][2] then
        localValue17 = parameter14[1][2]
      end
    end
  elseif type(parameter14) == "number" then
    localValue16 = parameter14
  end

  if localValue5 and localValue5.SetPartAppearance then
    pcall(function()
      localValue5:SetPartAppearance(parameter13, localValue16, localValue17, true)
    end)
  elseif localValue16 and tonumber(localValue16) and localValue16 > 0 then
    pcall(function()
      parameter13.BrickColor = BrickColor.new(localValue16)
    end)
  end
end

local function helperFunction10(parameter15, parameter16)
  for key4, value4 in pairs(parameter15:GetDescendants()) do
    if value4:IsA("BasePart") then
      value4.Anchored = true
      value4.CanCollide = false
      value4.CastShadow = localValue8.CastShadow
      value4.CanCollide = (getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide) ~= false
      if value4.Transparency < 1 then
        value4.Transparency = localValue8.Transparency
      end
      local localValue18 = parameter16
      if type(parameter16) == "table" and type(parameter16[1]) == "table" then
        localValue18 = parameter16[1]
      end
      helperFunction9(value4, localValue18)
    end
  end
end

local function helperFunction11(parameter17, parameter18, parameter19)
  local localValue19 = parameter19.Y / 2
  local localValue20 = parameter19.X / 2
  local vector = Vector3.new(localValue20, localValue19, 0)
  local vector2 = Vector3.new(-localValue20, localValue19, 0)
  local vector3 = Vector3.new(localValue20, -localValue19, 0)
  local vector4 = Vector3.new(-localValue20, -localValue19, 0)
  local x = -math.huge
  local huge = math.huge
  local huge2 = math.huge
  local y = -math.huge
  for index, value5 in ipairs({
    parameter18 * vector,
    parameter18 * vector2,
    parameter18 * vector3,
    parameter18 * vector4,
  }) do
    local pointToObjectSpace = parameter17:PointToObjectSpace(value5)
    if pointToObjectSpace.X < huge then
      huge = pointToObjectSpace.X
    end
    if pointToObjectSpace.X > x then
      x = pointToObjectSpace.X
    end
    if pointToObjectSpace.Y < huge2 then
      huge2 = pointToObjectSpace.Y
    end
    if pointToObjectSpace.Y > y then
      y = pointToObjectSpace.Y
    end
  end
  return huge, x, huge2, y
end

-- Fence segment builder
local function helperFunction12(parameter20, parameter21, parameter22, parameter23)
  local name = parameter21.Name
  local localValue21 = helperFunction5(name)
  local segment, localValue22, localValue23, localValue24, helperFunction13, helperFunction14, helperFunction15, cframe, localValue25

  if not localValue21 then
    local cframe2 = CFrame.lookAt((parameter22 + parameter23) / 2, parameter23)
    helperFunction8({
      Name = name,
      Size = Vector3.new(0.2, 3, (parameter22 - parameter23).Magnitude),
      CFrame = cframe2,
      Material = Enum.Material.Wood,
      BrickColor = BrickColor.new("Bronze"),
      Transparency = 0.1,
      CanCollide = false,
    }, parameter20)
    return
  end

  local localValue26 = false
  local localValue27 = 0
  if parameter21.Objects then
    for key5, value6 in pairs(parameter21.Objects) do
      if value6.Name:find("Gate") or value6.Name:find("Driveway") then
        localValue26 = true
        local localValue28 = helperFunction5(value6.Name)
        if localValue28 then
          local getExtentsSize = localValue28:IsA("Model") and localValue28:GetExtentsSize()
            or localValue28.Size
          localValue27 = math.max(getExtentsSize.X, getExtentsSize.Z)
        else
          localValue27 = (value6.Name:find("Double") or value6.Name:find("Driveway")) and 10 or 4
        end
        break
      end
    end
  end

  local edgePole = localValue21:FindFirstChild("EdgePole")
    or localValue21:FindFirstChild("GatePole")
    or localValue21:FindFirstChild("Post")
    or localValue21:FindFirstChild("StartPole")
  local midPole = localValue21:FindFirstChild("MidPole") or edgePole
  segment = localValue21:FindFirstChild("Segment")
  local spindle = localValue21:FindFirstChild("Spindle")
  local rotation = (localValue21:IsA("Model") and localValue21:GetPivot() or localValue21.CFrame).Rotation
  local vector5 = Vector3.new()
  local localValue29 = 0

  if edgePole then
    if edgePole:IsA("Model") then
      vector5 = edgePole:GetPivot().Position
      local localValue30 = { edgePole:GetBoundingBox() }
      localValue29 = localValue30[2].Y / 2
    else
      vector5 = edgePole.Position
      localValue29 = edgePole.Size.Y / 2
    end
  end

  local inverse = (rotation + vector5):Inverse()
  localValue22 = {}

  if not segment then
    for key6, value7 in pairs(localValue21:GetChildren()) do
      if
        value7:IsA("BasePart")
        and value7.Name ~= "SizeBox"
        and value7.Name ~= "Flower"
        and value7 ~= edgePole
        and value7 ~= midPole
        and value7 ~= spindle
      then
        table.insert(localValue22, {
          part = value7,
          relCF = inverse * value7.CFrame,
          origSize = value7.Size,
        })
      end
    end
  end

  localValue23 = {}
  localValue24 = {}

  local function tagColorGroup(parameter24, parameter25)
    local parent2 = parameter25
    while parent2 and parent2 ~= localValue21 do
      if parent2.Name:find("ColorGroup") then
        if not localValue24[parent2.Name] then
          localValue24[parent2.Name] = {}
        end
        table.insert(localValue24[parent2.Name], parameter24)
        break
      end
      parent2 = parent2.Parent
    end
  end

  local function applyPart(parameter26, parameter27)
    if parameter26:IsA("BasePart") then
      parameter26.Anchored = true
      parameter26.CanCollide = (getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide)
        ~= false
      parameter26.CastShadow = localValue8.CastShadow
      if parameter26.Transparency < 1 then
        parameter26.Transparency = localValue8.Transparency
      end
      if parameter27 then
        tagColorGroup(parameter26, parameter27)
      end
    end
  end

  local function cloneAt(parameter28, parameter29, parameter30, parameter31)
    if not parameter28 then
      return nil
    end
    local clone = parameter28:Clone()

    if parameter31 then
      local stretchList = {}
      if clone:IsA("BasePart") then
        table.insert(stretchList, clone)
      elseif clone:IsA("Model") then
        if clone.PrimaryPart then
          table.insert(stretchList, clone.PrimaryPart)
        end
        local _, boxSize = clone:GetBoundingBox()
        for _, value8 in pairs(clone:GetDescendants()) do
          if value8:IsA("BasePart") and value8 ~= clone.PrimaryPart then
            if name == "Roundpole Fence" then
              if value8.Size.X >= boxSize.X * 0.5 then
                table.insert(stretchList, value8)
              end
            elseif value8.Size.Z >= boxSize.Z * 0.5 then
              table.insert(stretchList, value8)
            end
          end
        end
      end
      for _, value9 in pairs(stretchList) do
        if name == "Roundpole Fence" then
          value9.Size = Vector3.new(parameter31, value9.Size.Y, value9.Size.Z)
        else
          value9.Size = Vector3.new(value9.Size.X, value9.Size.Y, parameter31)
        end
      end
    end

    local localValue34 = parameter30 + parameter29
    local localValue35 = 0
    if clone:IsA("BasePart") then
      localValue35 = clone.Size.Y / 2
    elseif clone:IsA("Model") then
      local boxSize2 = { clone:GetBoundingBox() }
      localValue35 = boxSize2[2].Y / 2
    end
    if name == "Roundpole Fence" and parameter31 then
      localValue34 = localValue34 * CFrame.Angles(0, math.rad(-90), 0)
    end
    local localValue37 = localValue34 * CFrame.new(0, localValue35, 0)
    if clone:IsA("Model") then
      clone:PivotTo(localValue37)
    else
      clone.CFrame = localValue37
    end

    if clone:IsA("BasePart") then
      applyPart(clone, parameter28)
    end
    for _, value10 in pairs(clone:GetDescendants()) do
      applyPart(value10, localValue21:FindFirstChild(value10.Name, true))
    end
    return clone
  end

  local magnitude = (parameter23 - parameter22).Magnitude
  cframe = CFrame.lookAt(parameter22, parameter23)
  local startPole = cloneAt(edgePole, Vector3.new(0, 0, 0), cframe)
  if startPole then
    startPole.Name = "StartPole"
    table.insert(localValue23, startPole)
  end
  local cframe3 = CFrame.new(0, 0, -magnitude)
  local endPole = cloneAt(edgePole, Vector3.new(0, 0, 0), cframe * cframe3)
  if endPole then
    endPole.Name = "EndPole"
    table.insert(localValue23, endPole)
  end
  localValue25 = cframe * CFrame.new(0, localValue29, 0)

  local function buildSegment(parameter32, parameter33)
    if segment then
      local cframe4 = CFrame.new(0, 0, parameter32 - parameter33 * 0.5)
      local result = cloneAt(segment, Vector3.new(0, 0, 0), cframe * cframe4, parameter33)
      if result then
        table.insert(localValue23, result)
      end
    else
      local localValue39 = localValue25 * CFrame.new(0, 0, parameter32)
      for _, value11 in pairs(localValue22) do
        local clone2 = value11.part:Clone()
        clone2.Size = Vector3.new(
          value11.origSize.X,
          value11.origSize.Y,
          parameter33 + (value11.origSize.Z - 10)
        )
        clone2.CFrame = localValue39
          * (
            CFrame.new(value11.relCF.Position.X, value11.relCF.Position.Y, -parameter33 * 0.5)
            * value11.relCF.Rotation
          )
        applyPart(clone2, value11.part)
        table.insert(localValue23, clone2)
      end
    end
  end

  if localValue26 then
    local localValue40 = math.max(0, (magnitude - localValue27) / 2 - 0.1)
    if localValue40 > 0.1 then
      buildSegment(0, localValue40)
      buildSegment(-magnitude + localValue40, localValue40)
    end
  else
    local poleDistance = localValue21:GetAttribute("PoleDistance") or 8
    local localValue41 = poleDistance > 0 and math.floor(magnitude / poleDistance) or 0
    local localValue42 = magnitude / (localValue41 + 1)
    local spindleDistance = localValue21:GetAttribute("SpindleDistance") or 1.2
    local localValue43 = spindle and math.floor(localValue42 / spindleDistance) or 0
    local localValue44 = localValue43 > 0 and localValue42 / localValue43 or 0

    for i = 0, localValue41 do
      local localValue45 = -(localValue42 * i)
      if i > 0 and midPole then
        local midPole2 =
          cloneAt(midPole, Vector3.new(0, 0, 0), cframe * CFrame.new(0, 0, localValue45))
        if midPole2 then
          midPole2.Name = "MidPole"
          table.insert(localValue23, midPole2)
        end
      end
      if spindle then
        for j = 1, math.max(localValue43 - 1, 1) do
          local spindle2 = cloneAt(
            spindle,
            Vector3.new(0, 0, 0),
            cframe * CFrame.new(0, 0, localValue45 - localValue44 * j)
          )
          if spindle2 then
            spindle2.Name = "Spindle"
            table.insert(localValue23, spindle2)
          end
        end
      end

      if magnitude > 0 then
        if name == "Velvet Ropes" or name == "Rope Fence" then
          local localValue46 = name == "Rope Fence" and 0.2 or 0.1
          local position2 = (cframe * CFrame.new(0, 2.5, localValue45)).Position
          local position3 = (cframe * CFrame.new(0, 2.5, localValue45 - localValue42)).Position
          local magnitude2 = (position3 - position2).Magnitude
          local cframe7 = CFrame.lookAt(position2, position3) * CFrame.new(0, 0, -magnitude2 / 2)
          local rope = helperFunction8({
            Name = "RopeCurve",
            Size = Vector3.new(localValue46, localValue46, magnitude2),
            CFrame = cframe7,
            Material = Enum.Material.Sand,
            BrickColor = name == "Velvet Ropes" and BrickColor.new("Bright red")
              or BrickColor.new("Sand"),
          }, nil)
          table.insert(localValue23, rope)
        elseif name == "Classic Hanging Lights" then
          local position4 = (cframe * CFrame.new(0, 3, localValue45)).Position
          local position5 = (cframe * CFrame.new(0, 3, localValue45 - localValue42)).Position
          local magnitude3 = (position5 - position4).Magnitude
          local localValue48 = CFrame.lookAt(position4, position5)
            * CFrame.new(0, 0, -magnitude3 / 2)
          local wire = helperFunction8({
            Name = "LightWire",
            Size = Vector3.new(0.05, 0.05, magnitude3),
            CFrame = localValue48,
            Material = Enum.Material.SmoothPlastic,
            BrickColor = BrickColor.new("Black"),
          }, nil)
          table.insert(localValue23, wire)
          if localValue21:FindFirstChild("BulbBase") then
            local clone3 = localValue21.BulbBase:Clone()
            clone3.CFrame = localValue48 * CFrame.new(0, -0.2, 0)
            table.insert(localValue23, clone3)
          end
        elseif name == "Festive Railing" then
          local cframe8 = cframe * CFrame.new(0, 2.6, localValue45 - localValue42 * 0.5)
          if localValue21:FindFirstChild("Garland") then
            local clone4 = localValue21.Garland:Clone()
            clone4.Size = Vector3.new(0.776, 0.806, localValue42)
            clone4.CFrame = cframe8
            table.insert(localValue23, clone4)
          end
          if localValue21:FindFirstChild("Lights") then
            local clone5 = localValue21.Lights:Clone()
            clone5.Size = Vector3.new(0.806, 0.806, localValue42)
            clone5.CFrame = cframe8
            table.insert(localValue23, clone5)
          end
        elseif name == "Roundpole Fence" then
          buildSegment(localValue45, localValue42)
          if i == 0 and not localValue26 and localValue21:FindFirstChild("StartPiece") then
            local clone6 = localValue21.StartPiece:Clone()
            clone6.Size = Vector3.new(localValue42 / poleDistance * 1.472, 3.404, 0.27)
            clone6.CFrame = cframe * CFrame.new(0, 1.5, 0) * CFrame.Angles(0, 1.5707, 0)
            table.insert(localValue23, clone6)
          end
          if i == localValue41 and not localValue26 and localValue21:FindFirstChild("EndPiece") then
            local clone7 = localValue21.EndPiece:Clone()
            clone7.Size = Vector3.new(localValue42 / poleDistance * 2.102, 3.467, 0.264)
            clone7.CFrame = cframe * CFrame.new(0, 1.5, -magnitude) * CFrame.Angles(0, 1.5707, 0)
            table.insert(localValue23, clone7)
          end
        elseif name == "Stacked Stone Fence" then
          if localValue21:FindFirstChild("Fill") then
            local clone8 = localValue21.Fill:Clone()
            clone8.Size = Vector3.new(0.42, 3.6, localValue42)
            clone8.CFrame = cframe
              * CFrame.new(0, clone8.Size.Y * 0.5, localValue45 - localValue42 * 0.5)
            table.insert(localValue23, clone8)
          end
          local poleDistance2 = localValue21:GetAttribute("PoleDistance")
          local localValue50 = math.max(1, math.round(localValue42 / (poleDistance2 or 8)))
          local localValue51 = localValue42 / localValue50
          for k = 1, localValue50 do
            local cframe9 = CFrame.new(0, 0, localValue45 - localValue51 * (k - 0.5))
            local result = cloneAt(segment, Vector3.new(0, 0, 0), cframe * cframe9, localValue51)
            if result then
              table.insert(localValue23, result)
            end
          end
        else
          buildSegment(localValue45, localValue42)
        end
      end
    end
  end

  local objectModel = Instance.new("Model")
  objectModel.Name = "ObjectModel"

  for key11, value12 in pairs(localValue24) do
    local configuration = Instance.new("Configuration")
    configuration.Name = key11
    configuration.Parent = objectModel
    for _, value13 in pairs(value12) do
      local object = Instance.new("ObjectValue")
      object.Name = "Object"
      object.Value = value13
      object.Parent = configuration
    end
  end
  for _, value14 in pairs(localValue23) do
    value14.Parent = objectModel
  end

  if parameter21.Color and type(parameter21.Color) == "table" and next(localValue24) then
    local color = parameter21.Color[1] or parameter21.Color
    for _, value16 in pairs(objectModel:GetDescendants()) do
      if value16:IsA("BasePart") then
        local inGroup = false
        for _, group in pairs(localValue24) do
          if table.find(group, value16) then
            inGroup = true
            break
          end
        end
        if not inGroup then
          helperFunction9(value16, color)
        end
      end
    end
  else
    helperFunction10(objectModel, parameter21.Color)
  end

  objectModel.Parent = parameter20
end

local function helperFunction17(parameter34)
  if not parameter34 then
    return nil
  end
  local localValue54 = tonumber(parameter34)
  if not localValue54 then
    return nil
  elseif localValue54 > 0 then
    return BrickColor.new(localValue54).Color
  elseif localValue54 < 0 then
    local localValue55 = -localValue54 - 1
    local bit = bit32.rshift(localValue55, 16)
    local bit2 = bit32.band(bit, 255)
    local bit3 = bit32.rshift(localValue55, 8)
    local bit4 = bit32.band(bit3, 255)
    local bit5 = bit32.band(localValue55, 255)
    return Color3.fromRGB(bit2, bit4, bit5)
  end
  return nil
end

local localValue56 = {}
local function helperFunction18(parameter35)
  if localValue56[parameter35] then
    return localValue56[parameter35]
  end
  return Enum.Material.Plastic
end

local function helperFunction19(parameter36)
  if not parameter36 then
    return nil, nil
  end
  local localValue57 = nil
  local localValue58 = nil
  if type(parameter36) == "table" then
    if parameter36[1] and type(parameter36[1]) == "number" then
      localValue57 = helperFunction17(parameter36[1])
      localValue58 = helperFunction18(parameter36[2])
      return localValue57, localValue58
    end
    if parameter36[1] and type(parameter36[1]) == "table" then
      return helperFunction19(parameter36[1])
    end
    return localValue57, localValue58
  elseif type(parameter36) == "number" then
    localValue57 = helperFunction17(parameter36)
  end
  return localValue57, localValue58
end

local localValue59
local previewGroundState
local previewGeneration = 0

local function restorePreviewGround()
  local state = previewGroundState
  previewGroundState = nil
  if state and state.Ground and state.Ground.Parent then
    state.Ground.Transparency = state.Transparency
    state.Ground.CanCollide = state.CanCollide
  end
end

function localValue1.load_preview(parameter37)
  if type(parameter37) ~= "string" or parameter37:match("^%s*$") then
    helperFunction1("Error", "No building ID provided", 3)
    return
  end

  parameter37 = parameter37:match("^%s*(.-)%s*$")

  print("[PreviewBuild] Loading data...")
  local data = nil
  local helperFunction20, helperFunction21, localValue61, findFirstChild3, ground, helperFunction22

  local function processData(data)
    if type(data) ~= "table" then
      helperFunction1("Error", "Empty Data", 3)
      return false
    end
    if data.FrontObjects == nil and type(data.frontObjects) == "table" then
      data.FrontObjects = data.frontObjects
    end
    local function validateItems(items, category)
      for index, item in pairs(items) do
        if type(item) ~= "table" then
          helperFunction1(
            "Error",
            string.format("Invalid item in %s at index %s", category, tostring(index)),
            3
          )
          return false
        end
        if item.Objects ~= nil then
          if
            type(item.Objects) ~= "table" or not validateItems(item.Objects, category .. ".Objects")
          then
            return false
          end
        end
      end
      return true
    end

    local recognizedCategory = false
    for _, dataKey in ipairs({
      "walls",
      "floors",
      "roofs",
      "basements",
      "paths",
      "counters",
      "fences",
      "pools",
      "objects",
    }) do
      if data[dataKey] ~= nil then
        recognizedCategory = true
        if type(data[dataKey]) ~= "table" then
          helperFunction1("Error", "Invalid build data category: " .. dataKey, 3)
          return false
        elseif not validateItems(data[dataKey], dataKey) then
          return false
        end
      else
        data[dataKey] = {}
      end
    end
    if not recognizedCategory then
      helperFunction1("Error", "Build data has no recognized categories", 3)
      return false
    end

    -- Respect Multi Build Config: blank disabled categories before rendering,
    -- same as load_house does. Set via getgenv().WereTools_BuildFilter which
    -- BuildModule exposes when the Auto Build dropdown changes.
    do
      local filter = getgenv().WereTools_BuildFilter
      if type(filter) == "table" then
        local KEYMAP = {
          Walls = "walls",
          Floors = "floors",
          Roofs = "roofs",
          Basements = "basements",
          Paths = "paths",
          Counters = "counters",
          Fences = "fences",
          Pools = "pools",
          Objects = "objects",
        }

        local enabledCount = 0
        for uiName, _ in pairs(KEYMAP) do
          if filter[uiName] ~= false then
            enabledCount = enabledCount + 1
          end
        end

        if enabledCount == 0 then
          print("[PreviewBuild] No categories selected -- rendering everything")
        else
          local skipped = {}
          for uiName, dataKey in pairs(KEYMAP) do
            if
              filter[uiName] == false
              and type(data[dataKey]) == "table"
              and #data[dataKey] > 0
            then
              table.insert(skipped, uiName)
              data[dataKey] = {}
            end
          end
          if #skipped > 0 then
            print("[PreviewBuild] Skipping disabled categories: " .. table.concat(skipped, ", "))
          end
        end
      end
    end

    local stats = replicatedStorage:FindFirstChild("Stats")
    local playerStats = stats and stats:FindFirstChild(localPlayer.Name)
    local isBuilding = playerStats and playerStats:FindFirstChild("IsBuilding")
    local plots = workspaceService:FindFirstChild("Plots")
    findFirstChild3 = isBuilding and plots and plots:FindFirstChild(tostring(isBuilding.Value))
    if not findFirstChild3 then
      helperFunction1("Error", "Please enter Build Mode", 3)
      return false
    end

    ground = findFirstChild3:FindFirstChild("Ground") or findFirstChild3:WaitForChild("Ground", 10)
    if not ground or not ground:IsA("BasePart") then
      helperFunction1("Error", "Plot ground is not available", 3)
      return false
    end

    restorePreviewGround()
    for _, existingPreview in ipairs(workspaceService:GetChildren()) do
      if existingPreview.Name == "BuildPreviewer" then
        existingPreview:Destroy()
      end
    end

    local buildPreviewer = Instance.new("Model")
    buildPreviewer.Name = "BuildPreviewer"
    local localValue60 = {}
    for _, folderName in ipairs({
      "Walls",
      "Floors",
      "Roofs",
      "Fences",
      "Pools",
      "Paths",
      "Basements",
      "Counters",
      "Objects",
      "FrontObjects",
    }) do
      localValue60[folderName] = Instance.new("Folder")
      localValue60[folderName].Name = folderName
      localValue60[folderName].Parent = buildPreviewer
    end
    buildPreviewer.Parent = workspaceService
    previewGeneration = previewGeneration + 1
    local generation = previewGeneration
    local function isPreviewCurrent()
      return generation == previewGeneration and buildPreviewer.Parent == workspaceService
    end

    local function toWorld(parameter38)
      return ground.CFrame:PointToWorldSpace(helperFunction3(parameter38))
    end
    local function toCF(parameter39)
      return ground.CFrame:ToWorldSpace(CFrame.new(unpack(parameter39)))
    end

    localValue9 = os.clock()

    local function paintOne(parameter42, parameter43)
      if not parameter42 or not parameter43 then
        return
      end
      local localValue70, localValue71
      if type(parameter43) == "table" then
        if type(parameter43[1]) == "number" then
          localValue70 = parameter43[1]
          localValue71 = parameter43[2]
        elseif type(parameter43[1]) == "table" then
          if parameter43[1][1] then
            localValue70 = parameter43[1][1]
          end
          if parameter43[1][2] then
            localValue71 = parameter43[1][2]
          end
        end
      elseif type(parameter43) == "number" then
        localValue70 = parameter43
      end
      local applied = false
      if localValue5 and localValue5.SetPartAppearance then
        applied = pcall(function()
          localValue5:SetPartAppearance(parameter42, localValue70, localValue71, true)
        end)
      end
      if not applied or not localValue5 then
        local c, m = helperFunction19(parameter43)
        if c then
          parameter42.Color = c
        end
        if m then
          parameter42.Material = m
        end
      end
    end

    local function recurse(parent3, parameter40)
      if not parameter40 or not isPreviewCurrent() then
        return
      end
      for _, value20 in pairs(parameter40) do
        if not isPreviewCurrent() then
          return
        end
        local localValue65 = value20
        helperFunction2()

        local skipItem = false
        if not getgenv().BUILD_OPTION.ShowStructuralItems then
          if localValue65.Name and localValue7[localValue65.Name] then
            skipItem = true
          end
        end

        if not skipItem then
          local localValue64 = helperFunction5(localValue65.Name)
          if localValue64 then
            local clone9 = localValue64:Clone()

            if not clone9:IsA("Model") and not clone9:IsA("BasePart") then
              clone9:Destroy()
            else
              helperFunction6(clone9, localValue65)

              if localValue65.PreviewSize and localValue7[localValue65.Name] then
                local localValue66 = helperFunction3(localValue65.PreviewSize)
                if localValue66 then
                  if clone9:IsA("BasePart") then
                    clone9.Size = localValue66
                  elseif clone9:IsA("Model") then
                    local primaryPart = clone9.PrimaryPart
                      or clone9:FindFirstChild("Main", true)
                      or clone9:FindFirstChild("PlaceAll", true)
                    if primaryPart then
                      primaryPart.Size = localValue66
                    end
                  end
                end
              end

              local cframe10 = nil
              if localValue65.CFrame then
                cframe10 = helperFunction3(localValue65.CFrame)
                if typeof(cframe10) == "Vector3" then
                  cframe10 = CFrame.new(cframe10)
                end
              elseif localValue65.Position then
                cframe10 = CFrame.new(toWorld(localValue65.Position))
              end
              if cframe10 then
                if type(localValue65.CFrame) == "table" then
                  cframe10 = toCF(localValue65.CFrame)
                end
                if clone9:IsA("Model") then
                  clone9:PivotTo(cframe10)
                else
                  clone9.CFrame = cframe10
                end
              end

              local localValue67 = localValue7[localValue65.Name]
              local previewParts = clone9:GetDescendants()
              if clone9:IsA("BasePart") then
                table.insert(previewParts, clone9)
              end
              for _, value21 in pairs(previewParts) do
                if value21:IsA("BasePart") then
                  value21.Anchored = true
                  value21.CanCollide = false
                  value21.CastShadow = false
                  value21.CanCollide = (
                    getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide
                  ) ~= false
                  local lower = clone9.Name:lower()
                  if localValue67 then
                    if value21.Name == "PlaceWall" or value21.Name == "PlaceAll" then
                      value21.Transparency = 1
                    elseif value21.Name == "Origin" then
                      value21.Transparency = 0
                    elseif value21.Transparency < 1 then
                      value21.Transparency = localValue8.Transparency
                    end
                  elseif value21.Name == "Origin" then
                    value21.Transparency = 0.7
                  elseif value21.Name == "PlaceAll" then
                    if lower:find("transparent") then
                      value21.Transparency = 0.75
                      value21.Material = Enum.Material.Glass
                    else
                      value21.Transparency = 0
                    end
                  else
                    local lower2 = value21.Name:lower()
                    if
                      lower2:find("window")
                      or lower2:find("glass")
                      or lower2:find("transparent")
                      or value21.Material == Enum.Material.Glass
                    then
                      value21.Transparency = 0.95
                      value21.Material = Enum.Material.Glass
                    elseif value21.Transparency < 1 then
                      value21.Transparency = localValue8.Transparency
                    end
                  end
                elseif value21:IsA("Script") or value21:IsA("LocalScript") then
                  value21:Destroy()
                end
              end

              if clone9:IsA("BasePart") then
                clone9.Anchored = true
                clone9.CanCollide = false
                clone9.CastShadow = false
                clone9.CanCollide = (getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide)
                  ~= false
              end

              if localValue65.Image then
                local texture = "rbxassetid://" .. tostring(localValue65.Image)
                local function applyDecal(parameter41)
                  if parameter41 and parameter41:IsA("Decal") then
                    parameter41.Texture = texture
                    parameter41.Transparency = 0
                  end
                end
                for _, value22 in pairs(clone9:GetDescendants()) do
                  if value22.Name:find("Canvas") then
                    local decal2 = value22:FindFirstChild("Decal")
                      or value22:FindFirstChildWhichIsA("Decal")
                    if decal2 then
                      applyDecal(decal2)
                    end
                  elseif value22:IsA("Decal") then
                    if
                      value22.Parent.Name:find("Canvas")
                      or value22.Parent.Name:find("Photo")
                      or value22.Parent.Name:find("Mesh")
                    then
                      applyDecal(value22)
                    end
                  end
                end
              end

              if
                localValue65.Height
                and type(localValue65.Height) == "number"
                and localValue65.Height > 1
              then
                local handled = false
                if clone9.Name:find("Elevator") then
                  pcall(function()
                    stack_elevator_floors(clone9, localValue65.Height)
                    handled = true
                  end)
                end
                if not handled then
                  local y2 = clone9:GetExtentsSize().Y
                  local getPivot = clone9:GetPivot()
                  for m = 1, localValue65.Height - 1 do
                    local clone10 = clone9:Clone()
                    clone10:PivotTo(getPivot * CFrame.new(0, y2 * m, 0))
                    clone10.Parent = parent3
                    helperFunction2()
                  end
                end
              end

              if localValue65.Color and type(localValue65.Color) == "table" then
                local localValue75 = localValue7[localValue65.Name]
                for n = 1, 4 do
                  local localValue76 = localValue65.Color[n]
                  if localValue76 and #localValue76 > 0 then
                    local matched = false
                    if not localValue75 then
                      local findFirstChild4 = clone9:FindFirstChild("ColorGroup" .. n)
                      if findFirstChild4 then
                        for _, value23 in pairs(findFirstChild4:GetChildren()) do
                          if value23:IsA("ObjectValue") and value23.Value then
                            paintOne(value23.Value, localValue76)
                            matched = true
                          end
                        end
                      end
                    end
                    if not matched then
                      local localValue78 = {}
                      if n == 1 then
                        localValue78 = { "Leaf", "Leaves", "Main", "Meshes/TreeLeaves", "Origin" }
                      end
                      if n == 2 then
                        localValue78 = { "Trunk", "Wood", "Bark" }
                      end
                      for _, value24 in pairs(clone9:GetDescendants()) do
                        if value24:IsA("BasePart") then
                          if localValue75 then
                            if value24.Name == "Origin" then
                              paintOne(value24, localValue76)
                            end
                          else
                            for _, value25 in ipairs(localValue78) do
                              if value24.Name:find(value25) then
                                paintOne(value24, localValue76)
                              end
                            end
                            if
                              n == 1 and (value24 == clone9.PrimaryPart or value24.Name == "Main")
                            then
                              paintOne(value24, localValue76)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end

              clone9.Parent = parent3
              if localValue65.Objects then
                recurse(clone9, localValue65.Objects)
              end
            end
          end
        end
      end
    end

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.floors and localValue2 then
        for _, value26 in pairs(data.floors) do
          if not isPreviewCurrent() then
            return
          end
          helperFunction2()
          if value26.Points and #value26.Points > 0 then
            local localValue79 = {}
            for _, value27 in pairs(value26.Points) do
              table.insert(localValue79, toWorld(value27))
            end
            local fromPoints = localValue2:fromPoints(localValue79)
            if not fromPoints then
              local reversed = {}
              for i6 = #localValue79, 1, -1 do
                table.insert(reversed, localValue79[i6])
              end
              fromPoints = localValue2:fromPoints(reversed)
            end
            if fromPoints then
              local floor = Instance.new("Model", localValue60.Floors)
              floor.Name = "Floor"
              fromPoints:Fill(function(floorPart, parent4)
                floorPart.Name = "FloorPart"
                floorPart.Parent = parent4
              end, floor)
              helperFunction10(floor, value26.Color)
              if value26.Objects then
                recurse(floor, value26.Objects)
              end
            else
              warn("[PreviewBuild] Floor generation failed, shape too complex.")
            end
          end
        end
      end

      if data.paths and localValue2 then
        for _, value28 in pairs(data.paths) do
          if not isPreviewCurrent() then
            return
          end
          helperFunction2()
          local points = {}
          if type(value28.Points) == "table" then
            for _, value29 in pairs(value28.Points) do
              local point = helperFunction3(value29)
              if point then
                table.insert(points, toWorld(value29))
              end
            end
          elseif value28.From and value28.To then
            local from = helperFunction3(value28.From)
            local to = helperFunction3(value28.To)
            if from and to then
              table.insert(points, toWorld(value28.From))
              table.insert(points, toWorld(value28.To))
            end
          end

          if #points >= 3 then
            local fromPoints2 = localValue2:fromPoints(points)
            if not fromPoints2 then
              local reversed2 = {}
              for i7 = #points, 1, -1 do
                table.insert(reversed2, points[i7])
              end
              fromPoints2 = localValue2:fromPoints(reversed2)
            end
            if fromPoints2 then
              local path = Instance.new("Model", localValue60.Paths)
              path.Name = "Path"
              fromPoints2:Fill(function(pathPart, parent5)
                pathPart.Name = "PathPart"
                pathPart.Parent = parent5
                pathPart.Size = Vector3.new(pathPart.Size.X, 0.05, pathPart.Size.Z)
              end, path)
              path:PivotTo(path:GetPivot() + Vector3.new(0, 0.02, 0))
              helperFunction10(path, value28.Color)
              if value28.Objects then
                recurse(path, value28.Objects)
              end
            end
          elseif #points == 2 and (points[1] - points[2]).Magnitude > 0.1 then
            local path = Instance.new("Model", localValue60.Paths)
            path.Name = "Path"
            helperFunction8({
              Name = "PathPart",
              Size = Vector3.new(
                tonumber(value28.Width) or 4,
                0.05,
                (points[1] - points[2]).Magnitude
              ),
              CFrame = CFrame.lookAt((points[1] + points[2]) * 0.5, points[2]),
              Anchored = true,
              CanCollide = false,
            }, path)
            path:PivotTo(path:GetPivot() + Vector3.new(0, 0.02, 0))
            helperFunction10(path, value28.Color)
            if value28.Objects then
              recurse(path, value28.Objects)
            end
          end
        end
      end
    end)

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.roofs and localValue59 then
        for _, value30 in pairs(data.roofs) do
          if not isPreviewCurrent() then
            return
          end
          if value30.Points and #value30.Points > 0 then
            local pts = {}
            for _, value31 in pairs(value30.Points) do
              table.insert(pts, toWorld(value31))
            end
            local settings = { Type = value30.Type or "Flat Roof" }
            for k, v in pairs(value30) do
              if type(v) == "number" then
                settings[k] = v
              end
            end
            local ok, result = pcall(function()
              return localValue59:CreateRoof(findFirstChild3, pts, settings)
            end)
            if ok and type(result) == "table" and result.Succeded == true and result.Model then
              local model = result.Model
              model.Parent = localValue60.Roofs
              for _, value33 in pairs(model:GetDescendants()) do
                if value33:IsA("BasePart") then
                  value33.Anchored = true
                  value33.CanCollide = (
                    getgenv().BUILD_OPTION and getgenv().BUILD_OPTION.CanCollide
                  ) ~= false
                  value33.CastShadow = localValue8.CastShadow
                end
              end
              helperFunction10(model, value30.Color)
              if value30.Objects then
                recurse(model, value30.Objects)
              end
            else
              warn("[PreviewBuild] Roof generation failed.")
            end
          end
        end
      end

      if not isPreviewCurrent() then
        return
      end
      if data.walls then
        for _, value34 in pairs(data.walls) do
          if not isPreviewCurrent() then
            return
          end
          local localValue88 = toWorld(value34.From)
          local localValue89 = toWorld(value34.To)
          local magnitude4 = (localValue88 - localValue89).Magnitude
          if magnitude4 > 0.1 then
            local wallCF = CFrame.lookAt((localValue88 + localValue89) / 2, localValue89)
              * CFrame.Angles(0, math.rad(-90), 0)
            local wallGroup = Instance.new("Model", localValue60.Walls)
            wallGroup.Name = "WallGroup"
            local cutouts = {}

            if value34.Objects then
              for _, value35 in pairs(value34.Objects) do
                local skipWallObj = false
                if not getgenv().BUILD_OPTION.ShowStructuralItems then
                  if value35.Name and localValue7[value35.Name] then
                    skipWallObj = true
                  end
                end
                if not skipWallObj then
                  local obj = helperFunction5(value35.Name)
                  if obj then
                    local lower3 = obj.Name:lower()
                    if lower3:find("door") or lower3:find("window") then
                      local localValue92 = nil
                      if value35.CFrame then
                        localValue92 = toCF(value35.CFrame)
                      elseif value35.Position then
                        localValue92 = CFrame.new(toWorld(value35.Position)) * wallCF.Rotation
                      end
                      local boxSize = obj:IsA("Model") and obj:GetExtentsSize() or obj.Size
                      if localValue92 and boxSize then
                        local minX, maxX, minY, maxY =
                          helperFunction11(wallCF, localValue92, boxSize)
                        table.insert(cutouts, {
                          MinX = minX - 0.05,
                          MaxX = maxX + 0.05,
                          MinY = minY - 0.05,
                          MaxY = maxY + 0.05,
                        })
                      end
                    end
                  end
                end
              end
            end

            local localValue98 = { { -magnitude4 / 2, magnitude4 / 2, -6.5, 6.5 } }
            for _, value36 in ipairs(cutouts) do
              local nextRects = {}
              for _, value37 in ipairs(localValue98) do
                local x1, x2, y1, y2 = unpack(value37)
                if
                  x2 < value36.MinX
                  or x1 > value36.MaxX
                  or y2 < value36.MinY
                  or y1 > value36.MaxY
                then
                  table.insert(nextRects, value37)
                else
                  if x1 < value36.MinX then
                    table.insert(nextRects, { x1, value36.MinX, y1, y2 })
                  end
                  if x2 > value36.MaxX then
                    table.insert(nextRects, { value36.MaxX, x2, y1, y2 })
                  end
                  local cx1 = math.max(x1, value36.MinX)
                  local cx2 = math.min(x2, value36.MaxX)
                  if cx1 < cx2 then
                    if y1 < value36.MinY then
                      table.insert(nextRects, { cx1, cx2, y1, value36.MinY })
                    end
                    if y2 > value36.MaxY then
                      table.insert(nextRects, { cx1, cx2, value36.MaxY, y2 })
                    end
                  end
                end
              end
              localValue98 = nextRects
            end

            local leftColor, leftMat, rightColor, rightMat
            if value34.LeftColor then
              leftColor, leftMat = helperFunction19(value34.LeftColor)
            end
            if value34.RightColor then
              rightColor, rightMat = helperFunction19(value34.RightColor)
            end

            for _, rect in ipairs(localValue98) do
              helperFunction2()
              local x1, x2, y1, y2 = unpack(rect)
              local w = x2 - x1
              local h = y2 - y1
              if w > 0.01 and h > 0.01 then
                local localCF = CFrame.new((x1 + x2) / 2, (y1 + y2) / 2, 0)
                local frag = helperFunction8({
                  Name = "WallFrag",
                  Size = Vector3.new(w, h, 0.4),
                  CFrame = wallCF * localCF,
                  Anchored = true,
                  CanCollide = true,
                  TopSurface = Enum.SurfaceType.Smooth,
                  BottomSurface = Enum.SurfaceType.Smooth,
                }, wallGroup)
                local c = leftColor or rightColor
                local m = leftMat or rightMat
                if c then
                  frag.Color = c
                  if m then
                    frag.Material = m
                  end
                else
                  frag.BrickColor = localValue8.DefaultColor
                  frag.Material = Enum.Material.Plastic
                end
              end
            end

            if value34.Objects then
              recurse(wallGroup, value34.Objects)
            end
          end
        end
      end
    end)

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.fences then
        for _, value39 in ipairs(data.fences) do
          if not isPreviewCurrent() then
            return
          end
          local localValue119 = toWorld(value39.From)
          local localValue120 = toWorld(value39.To)
          if (localValue119 - localValue120).Magnitude > 0.1 then
            local model = Instance.new("Model", localValue60.Fences)
            model.Name = value39.Name or "Fence"
            helperFunction12(model, value39, localValue119, localValue120)
            if value39.Objects then
              recurse(model, value39.Objects)
            end
          end
        end
      end
    end)

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.pools then
        local cutters = {}
        for _, value40 in pairs(data.pools) do
          if not isPreviewCurrent() then
            return
          end
          local localValue122 = toCF(value40.Center)
          local y3 = 10
          local x2 = 10
          if value40.Size then
            if value40.Size.X then
              x2 = value40.Size.X
            end
            if value40.Size.Y then
              y3 = value40.Size.Y
            end
            if value40.Size[1] then
              x2 = value40.Size[1]
            end
            if value40.Size[2] then
              y3 = value40.Size[2]
            end
          end
          local poolModel = Instance.new("Model", localValue60.Pools)
          poolModel.Name = value40.Name or "Pool"
          helperFunction8({
            Name = "Water",
            Size = Vector3.new(x2, 0.4, y3),
            CFrame = localValue122 * CFrame.new(0, 0.05, 0),
            BrickColor = BrickColor.new("Deep blue"),
            Material = Enum.Material.SmoothPlastic,
            Transparency = localValue8.WaterTransparency or 0.6,
            Reflectance = 0.2,
            CanCollide = false,
          }, poolModel)
          helperFunction8({
            Name = "PoolBase",
            Size = Vector3.new(x2 + 1, 0.2, y3 + 1),
            CFrame = localValue122 * CFrame.new(0, -0.1, 0),
            Material = Enum.Material.Concrete,
            BrickColor = BrickColor.new("Institutional white"),
          }, poolModel)
          local cutter = Instance.new("Part")
          cutter.Name = "Cutter"
          cutter.Size = Vector3.new(x2, 10, y3)
          cutter.CFrame = localValue122
          cutter.Anchored = true
          cutter.CanCollide = false
          cutter.Transparency = 1
          table.insert(cutters, cutter)
          if value40.Objects then
            recurse(poolModel, value40.Objects)
          end
        end
        if #cutters > 0 and ground and ground:IsA("BasePart") then
          task.spawn(function()
            pcall(function()
              local previewGroundCut = ground:Clone()
              previewGroundCut.Name = "PreviewGround_Cut"
              local ok, cut = pcall(function()
                return previewGroundCut:SubtractAsync(cutters)
              end)
              if ok and cut and buildPreviewer.Parent == workspaceService and ground.Parent then
                cut.Parent = buildPreviewer
                cut.Anchored = true
                cut.CanCollide = true
                cut.CFrame = ground.CFrame
                cut.Color = ground.Color
                cut.Material = ground.Material
                cut.Transparency = ground.Transparency
                previewGroundState = {
                  Ground = ground,
                  Transparency = ground.Transparency,
                  CanCollide = ground.CanCollide,
                }
                ground.Transparency = 1
                ground.CanCollide = false
                previewGroundCut:Destroy()
              else
                warn("[PreviewBuild] CSG Error: pool ground cut failed.")
                if previewGroundCut.Parent then
                  previewGroundCut:Destroy()
                end
                if cut and cut.Parent then
                  cut:Destroy()
                end
              end
            end)
          end)
        end
      end
    end)

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.objects then
        recurse(localValue60.Objects, data.objects)
      end
    end)

    task.defer(function()
      if not isPreviewCurrent() then
        return
      end
      if data.counters then
        recurse(localValue60.Counters, data.counters)
      end
      if data.basements then
        recurse(localValue60.Basements, data.basements)
      end
      if data.FrontObjects then
        if data.FrontObjects.Trash then
          local trash = data.FrontObjects.Trash
          recurse(localValue60.FrontObjects, trash.Name and { trash } or trash)
        end
        if data.FrontObjects.Mailbox then
          local mailbox = data.FrontObjects.Mailbox
          recurse(localValue60.FrontObjects, mailbox.Name and { mailbox } or mailbox)
        end
      end
    end)

    print("[PreviewBuild] PREVIEW LOADED")
    return true
  end

  if type(getgenv) == "function" and getgenv().Debug then
    print("[PreviewBuild] Debug mode: loading WereTools_DebugSave.json...")
    if type(isfile) == "function" and isfile("WereTools_DebugSave.json") then
      local ok1, val1 = pcall(function()
        return httpService:JSONDecode(readfile("WereTools_DebugSave.json"))
      end)
      if ok1 and val1 then
        data = val1.data or val1
        return processData(data)
      else
        helperFunction1("Error", "Failed to parse DebugSave.json", 3)
        return false
      end
    else
      helperFunction1("Error", "Cannot find WereTools_DebugSave.json", 3)
      return false
    end
  else
    local spec, usedBase
    local encodedID = httpService:UrlEncode(parameter37)
    for _, base in ipairs(BACKENDS or { "https://weretools.xyz" }) do
      local res
      pcall(function()
        if localValue10 then
          res = localValue10({ Url = base .. "/api/upload/" .. encodedID, Method = "GET" })
        else
          local b = game:HttpGet(base .. "/api/upload/" .. encodedID)
          if b then
            res = { StatusCode = 200, Body = b }
          end
        end
      end)
      if
        res
        and (res.StatusCode == nil or res.StatusCode == 200)
        and res.Body
        and res.Body ~= ""
      then
        local ok, parsed = pcall(function()
          return httpService:JSONDecode(res.Body)
        end)
        if ok and type(parsed) == "table" and parsed.success ~= false then
          spec = parsed
          usedBase = base
          break
        end
      end
    end
    if not spec then
      helperFunction1("Error", "Preview fetch failed - id not found on any backend", 3)
      return false
    end
    data = spec.data or spec
    return processData(data)
  end
end

function localValue1.destroy_previewBuild(parameter44)
  local found = false
  previewGeneration = previewGeneration + 1
  restorePreviewGround()
  for _, value42 in pairs(workspaceService:GetChildren()) do
    if value42.Name == "BuildPreviewer" then
      value42:Destroy()
      found = true
    end
  end
  if not found then
    helperFunction1("Error", "No Preview Build loaded.", 3)
  end
end

function localValue1.set_settings(parameter45)
  if type(parameter45) ~= "table" then
    return
  end
  for key36, value43 in pairs(parameter45) do
    localValue8[key36] = value43
  end

  local buildPreviewer2 = workspaceService:FindFirstChild("BuildPreviewer")
  if buildPreviewer2 then
    local min, max = buildPreviewer2:GetBoundingBox()
    local transparency = localValue8.Transparency
    local castShadow = localValue8.CastShadow
    for _, value44 in ipairs(buildPreviewer2:GetDescendants()) do
      if value44:IsA("BasePart") then
        value44.CastShadow = castShadow
        local lower4 = value44.Name:lower()
        if value44.Name == "Origin" then
          value44.Transparency = 0.7
        elseif value44.Name == "PlaceAll" then
          value44.Transparency = 0.35
        elseif
          value44.Material == Enum.Material.Glass
          or lower4:find("window")
          or lower4:find("glass")
          or lower4:find("transparent")
        then
          value44.Transparency = 0.95
        elseif value44.Name == "Water" then
          value44.Transparency = localValue8.WaterTransparency or 0.6
        elseif value44.Transparency < 0.99 then
          value44.Transparency = transparency
        end
      end
    end
    buildPreviewer2.WorldPivot = CFrame.new(min.Position.X, 0, min.Position.Z)
  end
end

return localValue1
