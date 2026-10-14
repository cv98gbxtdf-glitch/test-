return function(ctx)
  local workspaceService = game:GetService("Workspace")
  local replicatedStorage = game:GetService("ReplicatedStorage")
  local httpService = game:GetService("HttpService")
  local players = game:GetService("Players")
  local userInputService = game:GetService("UserInputService")
  local tweenService = game:GetService("TweenService")
  local textService = game:GetService("TextService")
  local lighting = game:GetService("Lighting")
  local coreGui = game:GetService("CoreGui")
  local scriptContext = game:GetService("ScriptContext")
  local localPlayer = players.LocalPlayer
  local localValue1 = 0
  local localValue2
  local buildRequest = request or http_request
  if type(buildRequest) ~= "function" and type(syn) == "table" then
    buildRequest = syn.request
  end
  if type(buildRequest) ~= "function" and type(http) == "table" then
    buildRequest = http.request
  end
  if type(buildRequest) ~= "function" then
    buildRequest = nil
  end

  local function requestBuild(options)
    if buildRequest then
      return buildRequest(options)
    end
    if options.Method == "GET" then
      return { StatusCode = 200, Body = game:HttpGet(options.Url) }
    end
    error("No executor HTTP request function is available for " .. tostring(options.Method), 2)
  end

  local function helperFunction1()
    return localValue2
  end

  local localValue3

  local function helperFunction2()
    return localValue3
  end

  local localValue4 = {
    job_manager = require(localPlayer.PlayerScripts.Modules.JobHandler),
    data_manager = replicatedStorage.Modules.DataService,
    vehicle_manager = require(replicatedStorage.Modules.VehicleService),
    player_stats = replicatedStorage.Stats[localPlayer.Name],
    notification_ui = require(localPlayer.PlayerScripts.Modules._UI.NotificationUI),
    gui_handler = require(localPlayer.PlayerScripts.Modules._Utilities.GUIHandler),
    skill_data = require(replicatedStorage.Modules._Data.SkillData),
    item_data = require(replicatedStorage.Modules.ItemService.ItemData),
    item_service = require(replicatedStorage.Modules.ItemService),
    food_service = require(replicatedStorage.Modules.FoodService),
    bill_service = require(replicatedStorage.Modules.BillService),
    equip_service = require(replicatedStorage.Modules.EquipmentService),
  }

  local localValue5 = {}
  local localValue6 = getconnections(localValue4.data_manager.DescendantAdded)[1].Function
  local localValue7 = getupvalue(localValue6, 1)
  local localValue8 = next
  local localValue9, localValue10 = getupvalue(getupvalue(localValue6, 2), 1)

  for localValue11, localValue12 in localValue8, localValue9, localValue10 do
    local sub = localValue12:sub(1, 2) == "F_" and localValue12:sub(3) or localValue12
    localValue5[sub] = localValue7[localValue11]
  end

  local function helperFunction3(parameter1)
    local localValue13, localValue14 = getconnections(parameter1)
    for key, value in next, localValue13, localValue14 do
      value:Disable()
    end
  end

  local function helperFunction4(parameter2)
    return tostring(math.floor(parameter2))
      :reverse()
      :gsub("(%d%d%d)", "%1,")
      :gsub(",(%-?)$", "%1")
      :reverse()
  end

  if not LPH_OBFUSCATED then
    function LPH_NO_VIRTUALIZE(...)
      return ...
    end
  end

  local localValue15 = false

  local localValue16 = {
    Width = 360,
    BgColor = Color3.fromRGB(20, 20, 24),
    StrokeColor = Color3.fromRGB(55, 55, 60),
    TitleColor = Color3.fromRGB(250, 250, 250),
    BodyColor = Color3.fromRGB(170, 170, 180),
    PrimaryColor = Color3.fromRGB(56, 189, 248),
    SecondaryColor = Color3.fromRGB(40, 40, 45),
    CornerRadius = UDim.new(0, 12),
    FontTitle = Enum.Font.GothamBold,
    FontBody = Enum.Font.GothamMedium,
  }

  function create_modal(text, parameter3, parameter4, parameter5)
    local proModal, blurEffect, frame, canvasGroup, instance, instance2, frame2, localValue17, helperFunction5
    if localValue15 then
      return
    end
    localValue15 = true
    proModal = Instance.new("ScreenGui")
    proModal.Name = "ProModal"
    proModal.IgnoreGuiInset = true
    proModal.DisplayOrder = 10000
    pcall(function()
      proModal.Parent = coreGui
    end)
    if not proModal.Parent then
      proModal.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
    end
    blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 0
    blurEffect.Parent = lighting
    frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1, 1)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = proModal
    canvasGroup = Instance.new("CanvasGroup")
    canvasGroup.AnchorPoint = Vector2.new(0.5, 0.5)
    canvasGroup.Position = UDim2.fromScale(0.5, 0.5)
    canvasGroup.Size = UDim2.new(0, localValue16.Width, 0, 0)
    canvasGroup.BackgroundColor3 = localValue16.BgColor
    canvasGroup.GroupTransparency = 1
    canvasGroup.BorderSizePixel = 0
    canvasGroup.Parent = proModal
    Instance.new("UICorner", canvasGroup).CornerRadius = localValue16.CornerRadius
    local instance3 = Instance.new("UIStroke", canvasGroup)
    instance3.Color = localValue16.StrokeColor
    instance3.Thickness = 1.2
    instance = Instance.new("UIScale", canvasGroup)
    instance.Scale = 0.94
    instance2 = Instance.new("UIListLayout", canvasGroup)
    instance2.SortOrder = Enum.SortOrder.LayoutOrder
    instance2.Padding = UDim.new(0, 10)
    local instance4 = Instance.new("UIPadding", canvasGroup)
    instance4.PaddingTop = UDim.new(0, 20)
    instance4.PaddingBottom = UDim.new(0, 20)
    instance4.PaddingLeft = UDim.new(0, 20)
    instance4.PaddingRight = UDim.new(0, 20)
    local textLabel = Instance.new("TextLabel")
    textLabel.LayoutOrder = 1
    textLabel.Text = text
    textLabel.Font = localValue16.FontTitle
    textLabel.TextSize = 18
    textLabel.TextColor3 = localValue16.TitleColor
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 0, 20)
    textLabel.Parent = canvasGroup
    local textLabel2 = Instance.new("TextLabel")
    textLabel2.LayoutOrder = 2
    textLabel2.Text = parameter3
    textLabel2.Font = localValue16.FontBody
    textLabel2.TextSize = 14
    textLabel2.TextColor3 = localValue16.BodyColor
    textLabel2.TextWrapped = true
    textLabel2.TextXAlignment = Enum.TextXAlignment.Left
    textLabel2.BackgroundTransparency = 1
    textLabel2.Parent = canvasGroup
    local getTextSize = textService:GetTextSize(
      parameter3,
      14,
      localValue16.FontBody,
      Vector2.new(localValue16.Width - 40, 999)
    )
    textLabel2.Size = UDim2.new(1, 0, 0, getTextSize.Y)
    local frame3 = Instance.new("Frame")
    frame3.LayoutOrder = 3
    frame3.Size = UDim2.new(1, 0, 0, 5)
    frame3.BackgroundTransparency = 1
    frame3.Parent = canvasGroup
    frame2 = Instance.new("Frame")
    frame2.LayoutOrder = 4
    frame2.Size = UDim2.new(1, 0, 0, 36)
    frame2.BackgroundTransparency = 1
    frame2.Parent = canvasGroup
    local instance5 = Instance.new("UIListLayout", frame2)
    instance5.FillDirection = Enum.FillDirection.Horizontal
    instance5.HorizontalAlignment = Enum.HorizontalAlignment.Right
    instance5.Padding = UDim.new(0, 8)
    local function helperFunction6(text2, parameter6)
      local textButton = Instance.new("TextButton")
      textButton.Text = text2
      textButton.Font = Enum.Font.GothamBold
      textButton.TextSize = 13
      textButton.Size = UDim2.new(0, parameter6 and 90 or 80, 1, 0)
      textButton.BackgroundColor3 = parameter6 and localValue16.PrimaryColor
        or localValue16.SecondaryColor
      textButton.TextColor3 = parameter6 and Color3.new(0, 0, 0) or Color3.fromRGB(220, 220, 220)
      textButton.AutoButtonColor = false
      textButton.Parent = frame2
      Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)
      textButton.MouseEnter:Connect(function()
        tweenService
          :Create(textButton, TweenInfo.new(0.15), {
            BackgroundColor3 = parameter6
                and localValue16.PrimaryColor:Lerp(Color3.new(1, 1, 1), 0.2)
              or localValue16.SecondaryColor:Lerp(Color3.new(1, 1, 1), 0.1),
          })
          :Play()
      end)
      textButton.MouseLeave:Connect(function()
        tweenService
          :Create(textButton, TweenInfo.new(0.15), {
            BackgroundColor3 = parameter6 and localValue16.PrimaryColor
              or localValue16.SecondaryColor,
          })
          :Play()
      end)
      return textButton
    end
    local localValue18 = helperFunction6("Cancel", false)
    local localValue19 = helperFunction6("Confirm", true)
    task.defer(function()
      canvasGroup.Size = UDim2.new(0, localValue16.Width, 0, instance2.AbsoluteContentSize.Y + 40)
    end)
    tweenService:Create(blurEffect, TweenInfo.new(0.25), { Size = 14 }):Play()
    tweenService:Create(frame, TweenInfo.new(0.25), { BackgroundTransparency = 0.6 }):Play()
    tweenService
      :Create(
        instance,
        TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Scale = 1 }
      )
      :Play()
    tweenService:Create(canvasGroup, TweenInfo.new(0.25), { GroupTransparency = 0 }):Play()
    localValue17 = false
    local function helperFunction5_1(parameter7)
      if localValue17 then
        return
      end
      localValue17 = true
      localValue15 = false
      tweenService
        :Create(
          instance,
          TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
          { Scale = 0.96 }
        )
        :Play()
      tweenService:Create(canvasGroup, TweenInfo.new(0.2), { GroupTransparency = 1 }):Play()
      tweenService:Create(blurEffect, TweenInfo.new(0.2), { Size = 0 }):Play()
      tweenService:Create(frame, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
      task.wait(0.2)
      proModal:Destroy()
      blurEffect:Destroy()
      if parameter7 and parameter4 then
        parameter4()
      end
      if not parameter7 and parameter5 then
        parameter5()
      end
    end
    localValue19.MouseButton1Click:Connect(function()
      helperFunction5_1(true)
    end)
    localValue18.MouseButton1Click:Connect(function()
      helperFunction5_1(false)
    end)
    return
  end

  local function helperFunction7(parameter8, parameter9, parameter10)
    localValue4.notification_ui:CreateNotification(parameter8, parameter9, parameter10)
  end

  local localValue20 = {}
  for index, value2 in ipairs({
    "Players",
    "ReplicatedStorage",
    "Workspace",
    "TweenService",
    "HttpService",
    "RunService",
    "UserInputService",
    "Lighting",
    "TeleportService",
    "MarketplaceService",
  }) do
    localValue20[value2] = game:GetService(value2)
  end

  helperFunction3(scriptContext.Error)
  helperFunction3(localPlayer.Idled)

  local create
  function tween_to_pos(parameter11, parameter12)
    local gravity = workspaceService.Gravity
    workspaceService.Gravity = 0
    create = tweenService:Create(
      localPlayer.Character.HumanoidRootPart,
      TweenInfo.new(
        (localPlayer.Character.HumanoidRootPart.Position - parameter11.p).Magnitude / parameter12
          or 8,
        Enum.EasingStyle.Linear
      ),
      { CFrame = parameter11 }
    )
    create:Play()
    create.Completed:Wait()
    if create then
      create = nil
    end
    workspaceService.Gravity = gravity
  end

  local localValue21 = {
    material_data = require(replicatedStorage.Modules._Data.MaterialData),
    fence_service = require(replicatedStorage.Modules._Objects.FenceService),
    object_service = require(replicatedStorage.Modules.ObjectService),
    item_service = require(replicatedStorage.Modules.ItemService),
    plot_service = require(replicatedStorage.Modules.PlotService),
    resize_service = require(replicatedStorage.Modules.ResizeService),
    color_service = require(replicatedStorage.Modules.ColorService),
    item_data = require(replicatedStorage.Modules.ItemService.ItemData)(),
  }

  local localValue22 = {}

  function localValue22.encode_c(parameter13)
    return { parameter13:components() }
  end

  function localValue22.decode_c(parameter14)
    return CFrame.new(unpack(parameter14))
  end

  function localValue22.cframe_to_table(parameter15)
    local localValue23 = {}
    for key2, value3 in next, { parameter15:components() }, nil do
      localValue23[key2] = value3
    end
    return localValue23
  end

  function localValue22.table_to_cframe(parameter16)
    if not parameter16 or type(parameter16) ~= "table" then
      return CFrame.new()
    end
    return CFrame.new(unpack(parameter16))
  end

  function localValue22.vec3_to_table(parameter17)
    return { parameter17.x, parameter17.y, parameter17.z }
  end

  function localValue22.table_to_vec3(parameter18)
    if not parameter18 or type(parameter18) ~= "table" then
      return Vector3.new(0, 0, 0)
    end
    return Vector3.new(unpack(parameter18))
  end

  function localValue22.get_save_cframe(parameter19, parameter20)
    local roundToSaveResolution = localValue21.object_service:RoundToSaveResolution(parameter19)
    local cframe = parameter20.Ground.CFrame
    return localValue22.encode_c(cframe:ToObjectSpace(roundToSaveResolution))
  end

  function localValue22.get_load_cframe(parameter21, parameter22)
    return parameter22.Ground.CFrame:ToWorldSpace(localValue22.decode_c(parameter21))
  end

  ground_cf = nil

  function localValue22.get_object_space(parameter23)
    if type(parameter23) ~= "vector" then
      return ground_cf:ToObjectSpace(parameter23)
    end
    return ground_cf:PointToObjectSpace(parameter23)
  end

  function localValue22.get_world_space(parameter24)
    if type(parameter24) ~= "vector" then
      return ground_cf:ToWorldSpace(parameter24)
    end
    return ground_cf:PointToWorldSpace(parameter24)
  end

  function localValue22.set_settings(parameter25)
    if type(parameter25) ~= "table" then
      warn("set_settings: (table) expected.")
      return
    end
    warn("set_settings: vehicle and Blockbux purchasing are not supported by this build module.")
  end

  -- Whether we're allowed to try placing this item at all. Vehicles go through
  -- a different path; anything the item service recognises without a Blockbux
  -- price is fair game (whether the player owns it or not — Bloxburg lets you
  -- place items you don't own when loading a shared build, so we do too).
  local function helperFunction8(parameter26)
    local itemData = localValue21.item_data
    if itemData.Vehicles and itemData.Vehicles[parameter26] then
      return false
    end
    local getItem = localValue4.item_service:GetItem(parameter26)
    if not getItem then
      return false
    end
    if getItem.BSPrice then
      return false
    end
    return true
  end

  function localValue22.get_plot(parameter27)
    return workspaceService.Plots:FindFirstChild("Plot_" .. parameter27):FindFirstChild("House")
  end

  function localValue22.get_value(parameter28, parameter29)
    local houses = replicatedStorage.Stats[parameter29].Houses
    return houses:GetChildren()[houses.Value][parameter28].Value
  end

  local function helperFunction9(parameter30)
    local lookVector = parameter30.lookVector
    local localValue24 = -math.atan2(lookVector.Z, lookVector.X) - math.pi * 0.5
    return localValue24 < 0 and 2 * math.pi + localValue24 or localValue24
  end

  local localValue25 = 0
  local localValue26 = 0
  local helperFunction10

  local function helperFunction11(parameter31)
    local localValue27 = {}
    for index2, value5 in ipairs({ parameter31:components() }) do
      table.insert(localValue27, helperFunction10(value5))
    end
    return localValue27
  end

  function helperFunction10(parameter32)
    return tonumber(string.format("%.4f", parameter32))
  end

  local localValue28 =
    require(localPlayer.PlayerScripts.Modules._Build.BuildUI.PlacementHandler.ObjectsHandler)
  localValue21.line_service = localValue28.Shared.LineObjectService
  localValue21.type_service = localValue28.Shared.TypeService

  function localValue22.is_dynamic_line(parameter33)
    if typeof(parameter33) == "Instance" then
      return localValue21.type_service:ObjectIsType(parameter33, "DynamicLineObject")
    end
    return false
  end

  function localValue22.get_line_edges(parameter34)
    local primaryPart = parameter34:IsA("Model") and parameter34.PrimaryPart or parameter34
    local localValue29, localValue30, localValue31 = pcall(function()
      return localValue21.line_service:GetEdgeCFrames(primaryPart)
    end)
    if localValue29 and localValue30 and localValue31 then
      return localValue30.Position, localValue31.Position
    else
      local x = primaryPart.Size.X
      return (primaryPart.CFrame * CFrame.new(-x / 2, 0, 0)).Position,
        (primaryPart.CFrame * CFrame.new(x / 2, 0, 0)).Position
    end
  end

  function localValue22.serialize_object(parameter35)
    local getPivot = parameter35:IsA("Model") and parameter35:GetPivot() or parameter35.CFrame
    local groundCf = ground_cf
    local position = getPivot.Position
    local localValue32 = groundCf:Inverse() * getPivot
    local getItem2 = localValue21.item_service:GetItem(parameter35)
    localValue25 = localValue25 + (getItem2 and getItem2.BSPrice or 0)
    localValue26 = localValue26 + (localValue21.plot_service:GetObjectValue(parameter35) or 0)
    local localValue33 = helperFunction11(localValue32)
    local cfData = parameter35:GetAttribute("_cfData")
    local name = parameter35.Name
    local position2 = localValue22.vec3_to_table(localValue22.get_object_space(position))
    local localValue34 = {
      Name = name,
      Position = position2,
      CFrame = localValue22.cframe_to_table(localValue22.get_object_space(getPivot)),
      Offset = cfData and localValue33 or nil,
      PreviewSize = localValue22.vec3_to_table(
        parameter35:IsA("Model") and parameter35:GetExtentsSize() or parameter35.Size
      ),
      Color = localValue21.color_service:GetAppearanceData(parameter35),
      Size = parameter35:GetAttribute("_resizeRootSize1") and localValue22.vec3_to_table(
        parameter35:GetAttribute("_resizeRootSize1")
      ) or nil,
      Height = parameter35:FindFirstChild("ObjectData") and parameter35.ObjectData:FindFirstChild(
        "Height"
      ) and parameter35.ObjectData.Height.Value or nil,
      Image = parameter35:FindFirstChild("ObjectData") and parameter35.ObjectData:FindFirstChild(
        "Image"
      ) and parameter35.ObjectData.Image.Value or nil,
      Objects = nil,
    }
    local itemHolder = parameter35:FindFirstChild("ItemHolder")
    if itemHolder then
      localValue34.Objects = localValue22.serialize_items(itemHolder)
    end
    if localValue22.is_dynamic_line(parameter35) then
      local localValue35, localValue36 = localValue22.get_line_edges(parameter35)
      localValue34.StartPos =
        localValue22.vec3_to_table(localValue22.get_object_space(localValue35))
      localValue34.EndPos = localValue22.vec3_to_table(localValue22.get_object_space(localValue36))
      localValue34.CustomOffset = parameter35:GetAttribute("CustomOffset") or 0
    end
    return localValue34
  end

  function localValue22.serialize_items(parameter36)
    local localValue37 = {}
    if not parameter36 then
      return localValue37
    end
    local groundCf2 = ground_cf
    local parent = parameter36.Parent
    if parent and (parent:IsA("Model") or parent:IsA("BasePart")) then
      local name2 = parent.Name
      if
        name2 ~= "House"
        and name2 ~= "Objects"
        and name2 ~= "Plot"
        and name2 ~= "Walls"
        and name2 ~= "Floors"
      then
        if parent:IsA("Model") then
          groundCf2 = parent:GetPivot()
        else
          groundCf2 = parent.CFrame
        end
      end
    end
    for key4, value6 in pairs(parameter36:GetChildren()) do
      local getPivot2 = value6:IsA("Model") and value6:GetPivot() or value6.CFrame
      local position3 = getPivot2.Position
      local inverse = groundCf2:Inverse()
      localValue26 = localValue26 + (localValue21.plot_service:GetObjectValue(value6) or 0)
      local localValue38 = helperFunction11(inverse * getPivot2)
      local cfData2 = value6:GetAttribute("_cfData")
      local localValue39 = localValue22.get_object_space(position3)
      local name3 = value6.Name
      local position4 = localValue22.vec3_to_table(localValue39)
      local cframe2 = localValue22.cframe_to_table(localValue22.get_object_space(getPivot2))
      local localValue40 = {
        Name = name3,
        Position = position4,
        CFrame = cframe2,
        Offset = cfData2 and localValue38 or nil,
        Color = localValue21.color_service:GetAppearanceData(value6),
        Image = value6:FindFirstChild("ObjectData")
            and value6.ObjectData:FindFirstChild("Image")
            and value6.ObjectData.Image.Value
          or nil,
        PreviewSize = localValue22.vec3_to_table(
          value6:IsA("Model") and value6:GetExtentsSize() or value6.Size
        ),
        Size = value6:GetAttribute("_resizeRootSize1") and localValue22.vec3_to_table(
          value6:GetAttribute("_resizeRootSize1")
        ) or nil,
        Height = value6:FindFirstChild("ObjectData")
            and value6.ObjectData:FindFirstChild("Height")
            and value6.ObjectData.Height.Value
          or nil,
        Objects = nil,
      }
      local itemHolder2 = value6:FindFirstChild("ItemHolder")
      if itemHolder2 then
        localValue40.Objects = localValue22.serialize_items(itemHolder2)
      end
      local getItem3 = localValue21.item_service:GetItem(value6)
      localValue25 = localValue25 + (getItem3 and getItem3.BSPrice or 0)
      if localValue22.is_dynamic_line(value6) then
        local localValue41, localValue42 = localValue22.get_line_edges(value6)
        localValue40.StartPos =
          localValue22.vec3_to_table(localValue22.get_object_space(localValue41))
        localValue40.EndPos =
          localValue22.vec3_to_table(localValue22.get_object_space(localValue42))
        localValue40.CustomOffset = value6:GetAttribute("CustomOffset") or 0
      end
      table.insert(localValue37, localValue40)
    end
    return localValue37
  end

  local function helperFunction12(
    parameter37,
    completedKeys,
    parameter38,
    parameter39,
    current,
    total,
    parameter40,
    parameter41
  )
    local localValue43 = not parameter41
    local localValue44 = tick()
    local localValue45 = localValue43 and localValue44 - localValue1 < 3
    local localValue46
    if localValue45 then
      return
    end
    localValue1 = localValue44
    local localValue47 = {
      walls = parameter39.walls or {},
      roofs = parameter39.roofs or {},
      basements = parameter39.basements or {},
      floors = parameter39.floors or {},
      paths = parameter39.paths or {},
      counters = parameter39.counters or {},
      fences = parameter39.fences or {},
      pools = parameter39.pools or {},
      objects = {},
    }
    if parameter39.objects then
      for index3, value7 in ipairs(parameter39.objects) do
        table.insert(localValue47.objects, { data = value7.data })
      end
    end
    localValue46 = {
      completed_keys = completedKeys,
      color_queue = {},
      failed_items = localValue47,
      stats = { current = current, total = total, color_index = parameter40 or 0 },
    }
    for index4, value8 in ipairs(parameter38) do
      local localValue48 = {
        type = value8.type,
        color = value8.color,
        image = value8.image,
        name = value8.name,
        side = value8.side,
        category_hint = value8.category_hint,
      }
      if typeof(value8.object) == "Instance" then
        local object = value8.object
        local vector = Vector3.new(0, 0, 0)
        if object:IsA("Model") then
          vector = object:GetPivot().Position
        elseif object:IsA("BasePart") then
          vector = object.Position
        end
        if ground_cf then
          local pointToObjectSpace = ground_cf:PointToObjectSpace(vector)
          localValue48.object_pos = {
            tonumber(string.format("%.4f", pointToObjectSpace.X)),
            tonumber(string.format("%.4f", pointToObjectSpace.Y)),
            tonumber(string.format("%.4f", pointToObjectSpace.Z)),
          }
        else
          warn("[Save Error] Ground CFrame not found for task: " .. (value8.name or "Unknown"))
        end
        if object.Parent then
          localValue48.category_hint = object.Parent.Name
        end
        localValue48.object = nil
      elseif value8.object_pos then
        localValue48.object_pos = value8.object_pos
      end
      table.insert(localValue46.color_queue, localValue48)
    end
    pcall(function()
      writefile("build_progress.json", httpService:JSONEncode(localValue46))
      if parameter37 then
        writefile("build_data.json", httpService:JSONEncode(parameter37))
      end
    end)
    return
  end

  local function helperFunction13(parameter42, parameter43, parameter44)
    if not parameter44 then
      return nil
    end
    local pointToWorldSpace = nil
    if parameter43.From and parameter43.To then
      local vector2 = Vector3.new(unpack(parameter43.From))
      local vector3 = Vector3.new(unpack(parameter43.To))
      if parameter44:FindFirstChild("Ground") then
        vector2 = parameter44.Ground.CFrame:PointToWorldSpace(vector2)
        vector3 = parameter44.Ground.CFrame:PointToWorldSpace(vector3)
      end
      pointToWorldSpace = (vector2 + vector3) / 2
    elseif parameter43.object_pos then
      local vector4 = Vector3.new(unpack(parameter43.object_pos))
      if parameter44:FindFirstChild("Ground") then
        pointToWorldSpace = parameter44.Ground.CFrame:PointToWorldSpace(vector4)
      else
        pointToWorldSpace = vector4
      end
    elseif parameter43.Pos then
      local vector5 = Vector3.new(unpack(parameter43.Pos))
      if parameter44:FindFirstChild("Ground") then
        pointToWorldSpace = parameter44.Ground.CFrame:PointToWorldSpace(vector5)
      else
        pointToWorldSpace = vector5
      end
    elseif parameter43.Position then
      local vector6 = Vector3.new(unpack(parameter43.Position))
      if parameter44:FindFirstChild("Ground") then
        pointToWorldSpace = parameter44.Ground.CFrame:PointToWorldSpace(vector6)
      else
        pointToWorldSpace = vector6
      end
    elseif parameter43.CFrame then
      local cframe3 = CFrame.new(unpack(parameter43.CFrame))
      if parameter44:FindFirstChild("Ground") then
        pointToWorldSpace = parameter44.Ground.CFrame:ToWorldSpace(cframe3).Position
      else
        pointToWorldSpace = cframe3.Position
      end
    end
    if not pointToWorldSpace then
      return nil
    end
    local house = parameter44.House
    local localValue49 = false
    local localValue50 = 1.2
    if parameter42 == "walls" then
      house = parameter44.House:FindFirstChild("Walls")
      localValue50 = 2.5
      localValue49 = true
    elseif parameter42 == "fences" then
      local house2 = parameter44.House
      localValue50 = 2
      house = house2:FindFirstChild("Fences")
      localValue49 = true
    elseif parameter42 == "paths" then
      house = parameter44.House:FindFirstChild("Paths")
      localValue49 = true
    elseif parameter42 == "roofs" then
      house = parameter44.House:FindFirstChild("Roof")
      localValue49 = true
    elseif parameter42 == "floors" then
      house = parameter44.House:FindFirstChild("Floor")
      localValue49 = false
    elseif parameter42 == "pools" then
      local house3 = parameter44.House
      localValue49 = true
      house = house3:FindFirstChild("Pools")
    elseif parameter42 == "objects" then
      localValue49 = false
      house = parameter44.House
    end
    if not house then
      return nil
    end
    for index5, value9 in ipairs(localValue49 and house:GetChildren() or house:GetDescendants()) do
      if value9:IsA("BasePart") or value9:IsA("Model") then
        if localValue49 and not value9:IsA("Model") and parameter42 ~= "paths" then
        else
          local position5 = value9:IsA("Model") and value9:GetPivot().Position or value9.Position
          if parameter42 == "walls" or parameter42 == "fences" then
            if
              (Vector3.new(position5.X, 0, position5.Z) - Vector3.new(
                pointToWorldSpace.X,
                0,
                pointToWorldSpace.Z
              )).Magnitude < localValue50
            then
              return value9
            end
          elseif (position5 - pointToWorldSpace).Magnitude < localValue50 then
            if
              parameter42 == "objects"
              and value9:IsA("BasePart")
              and value9.Parent:IsA("Model")
            then
              return value9.Parent
            end
            return value9
          end
        end
      end
    end
    return nil
  end

  function localValue22.save_house(parameter45)
    localValue26 = 0
    localValue25 = 0
    if not parameter45 then
      return helperFunction7("Error", nil, "Target Not Selected, please select a player")
    end
    local localValue51 = localValue22.get_plot(parameter45)
    local helperFunction14, helperFunction15, helperFunction16, localValue52, localValue53, localValue54, helperFunction17, localValue55, localValue56, helperFunction18
    if not localValue51 or not localValue51.Parent:FindFirstChild("Ground") then
      return helperFunction7(
        "Build Save Error",
        nil,
        "You are not in view of the plot, go closely to " .. parameter45 .. " plot"
      )
    end
    ground_cf = localValue51.Parent.Ground.CFrame
    localValue52 = {
      player_name = localPlayer.Name,
      walls = {},
      floors = {},
      roofs = {},
      fences = {},
      counters = {},
      objects = {},
      basements = {},
      pools = {},
      paths = {},
      frontObjects = {
        Mailbox = { CFrame = nil, Name = nil, Color = nil },
        Trash = { CFrame = nil, Name = nil, Color = nil },
        Position = nil,
      },
      gamepasses = nil,
      skills = nil,
      real_value = nil,
      blockbux_value = nil,
      totalItems = nil,
    }
    localValue53 = {}
    localValue54 = 0
    local pendingSaveTasks = 0
    local serializationErrors = {}
    local function spawnSaveTask(callback)
      pendingSaveTasks = pendingSaveTasks + 1
      task.spawn(function()
        local ok, err = pcall(callback)
        if not ok then
          table.insert(serializationErrors, tostring(err))
          warn("[Build Save] Serialization task failed: " .. tostring(err))
        end
        pendingSaveTasks = pendingSaveTasks - 1
      end)
    end
    print("=== START SERIALIZATION ===")
    function helperFunction17_1(parameter46, parameter47)
      if localValue52[parameter46] then
        table.insert(localValue52[parameter46], parameter47)
      end
    end
    function save_walls()
      local localValue57, localValue58 = pcall(function()
        local walls = localValue51:FindFirstChild("Walls")
        if not walls then
          return
        end
        local count = 0
        local total2 = 0
        for index6, value10 in ipairs(walls:GetChildren()) do
          if value10.Name == "Wall" then
            local wallEntry = {
              From = localValue22.vec3_to_table(
                localValue22.get_object_space(value10.BPole.Value.Parent.Value)
              ),
              To = localValue22.vec3_to_table(
                localValue22.get_object_space(value10.FPole.Value.Parent.Value)
              ),
              Objects = localValue22.serialize_items(value10:FindFirstChild("ItemHolder")),
              id = localValue54 + count,
            }
            table.insert(localValue52.walls, wallEntry)
            count = count + 1
            total2 = total2 + (localValue21.plot_service:GetObjectValue(value10) or 0)
          end
        end
        localValue54 = localValue54 + count
        table.insert(localValue53, total2)
        return
      end)
      if not localValue57 then
        warn("Error saving walls:", localValue58)
      end
    end
    spawnSaveTask(save_walls)
    spawnSaveTask(function()
      local paths = localValue51:FindFirstChild("Paths")
      if not paths then
        return
      end
      local total3 = 0
      for index8, value12 in ipairs(paths:GetChildren()) do
        if value12.Name == "Path" then
          total3 = total3 + (localValue21.plot_service:GetObjectValue(value12) or 0)
          local pathPart = value12:IsA("BasePart") and value12
            or value12:IsA("Model")
              and (value12.PrimaryPart or value12:FindFirstChildWhichIsA("BasePart", true))
          if pathPart then
            local okEdges, from, to = pcall(function()
              return localValue22.get_line_edges(pathPart)
            end)
            if okEdges and from and to then
              helperFunction17_1("paths", {
                Name = value12.Name,
                From = localValue22.vec3_to_table(localValue22.get_object_space(from)),
                To = localValue22.vec3_to_table(localValue22.get_object_space(to)),
                Color = localValue21.color_service:GetAppearanceData(value12),
                Objects = value12:FindFirstChild("ItemHolder") and localValue22.serialize_items(
                  value12.ItemHolder
                ) or nil,
              })
            else
              warn("Error saving path: unable to read its endpoints")
            end
          end
        end
      end
      table.insert(localValue53, total3)
    end)
    spawnSaveTask(function()
      local searchRoots = { localValue51, localValue51.Parent }
      local frontFolder
      for _, root in ipairs(searchRoots) do
        if root then
          frontFolder = root:FindFirstChild("FrontObjects")
          if frontFolder then
            break
          end
        end
      end
      for _, objectName in ipairs({ "Trash", "Mailbox" }) do
        local object = frontFolder and frontFolder:FindFirstChild(objectName, true)
        if not object then
          for _, root in ipairs(searchRoots) do
            if root then
              object = root:FindFirstChild(objectName)
              if object then
                break
              end
            end
          end
        end
        if object and (object:IsA("Model") or object:IsA("BasePart")) then
          local objectCF = object:IsA("Model") and object:GetPivot() or object.CFrame
          localValue52.frontObjects[objectName] = {
            Name = object.Name,
            CFrame = localValue22.cframe_to_table(localValue22.get_object_space(objectCF)),
            Color = localValue21.color_service:GetAppearanceData(object),
          }
        end
      end
    end)
    spawnSaveTask(function()
      pcall(function()
        local fences = localValue51:FindFirstChild("Fences")
        if not fences then
          return
        end
        local total4 = 0
        for index9, value13 in ipairs(fences:GetChildren()) do
          if value13.Name ~= "Poles" then
            local localValue59, localValue60 = localValue21.fence_service:GetEdgePositions(value13)
            local from = localValue22.vec3_to_table(localValue22.get_object_space(localValue59))
            local to = localValue22.vec3_to_table(localValue22.get_object_space(localValue60))
            local getAppearanceData = localValue21.color_service:GetAppearanceData(value13)
            local objects = localValue22.serialize_items(value13:FindFirstChild("ItemHolder"))
            total4 = total4 + localValue21.plot_service:GetObjectValue(value13)
            helperFunction17_1("fences", {
              Name = value13.Name,
              From = from,
              To = to,
              Color = getAppearanceData,
              Objects = objects,
            })
          end
        end
        table.insert(localValue53, total4)
        return
      end)
    end)
    spawnSaveTask(function()
      pcall(function()
        local basements = localValue51:FindFirstChild("Basements")
        if not basements then
          return
        end
        local total5 = 0
        for index10, value14 in ipairs(basements:GetChildren()) do
          local center =
            localValue22.get_save_cframe(value14.PrimaryPart.CFrame, localValue51.Parent)
          total5 = total5 + localValue21.plot_service:GetObjectValue(value14)
          helperFunction17_1(
            "basements",
            { Center = center, Size = { value14.PrimaryPart.Size.X, value14.PrimaryPart.Size.Z } }
          )
        end
        table.insert(localValue53, total5)
        return
      end)
    end)
    spawnSaveTask(function()
      pcall(function()
        local floor = localValue51:FindFirstChild("Floor")
        if not floor then
          return
        end
        local total6 = 0
        for index11, value15 in ipairs(floor:GetChildren()) do
          if value15.Name == "FloorModel" then
            local localValue61 = {}
            local localValue62 = {}
            for index12, value16 in ipairs(value15.PointData:GetChildren()) do
              if value16.Name:match("^Point_%d+") then
                local localValue63 = tonumber(value16.Name:match("%d+"))
                if localValue63 then
                  localValue62[localValue63] = localValue22.vec3_to_table(value16.Value)
                end
              end
            end
            for i = 1, #localValue62 do
              if localValue62[i] then
                table.insert(localValue61, localValue62[i])
              end
            end
            local getAppearanceData2 = localValue21.color_service:GetAppearanceData(value15)
            total6 = total6 + localValue21.plot_service:GetObjectValue(value15)
            helperFunction17_1("floors", { Points = localValue61, Color = getAppearanceData2 })
          end
        end
        table.insert(localValue53, total6)
        return
      end)
    end)
    spawnSaveTask(function()
      pcall(function()
        local roof = localValue51:FindFirstChild("Roof")
        if not roof then
          return
        end
        local total7 = 0
        for index13, value17 in ipairs(roof:GetChildren()) do
          local localValue64 = {}
          local localValue65 = {}
          if value17:FindFirstChild("PointData") then
            for index14, value18 in ipairs(value17.PointData:GetChildren()) do
              if value18.Name:match("^Point_%d+") then
                local localValue66 = tonumber(value18.Name:match("%d+"))
                if localValue66 then
                  localValue65[localValue66] = localValue22.vec3_to_table(value18.Value)
                end
              end
            end
            for j = 1, #localValue65 do
              if localValue65[j] then
                table.insert(localValue64, localValue65[j])
              end
            end
          end
          local colorService = localValue21.color_service
          local localValue67 = {
            Points = localValue64,
            Type = value17.Name,
            Color = colorService:GetAppearanceData(value17),
            Objects = {},
          }
          for index15, value19 in ipairs(value17:GetDescendants()) do
            if value19.Name == "ItemHolder" then
              local localValue68 = localValue22.serialize_items(value19)
              if localValue68 and #localValue68 > 0 then
                for index16, value20 in ipairs(localValue68) do
                  table.insert(localValue67.Objects, value20)
                end
              end
            end
          end
          if #localValue67.Objects == 0 then
            localValue67.Objects = nil
          end
          if value17:FindFirstChild("PropertyData") then
            for index17, value21 in ipairs(value17.PropertyData:GetChildren()) do
              if value21:IsA("NumberValue") or value21:IsA("IntValue") then
                localValue67[value21.Name] = value21.Value
              end
            end
          else
            localValue67.Height = 0
          end
          total7 = total7 + localValue21.plot_service:GetObjectValue(value17)
          helperFunction17_1("roofs", localValue67)
        end
        table.insert(localValue53, total7)
        return
      end)
    end)
    spawnSaveTask(function()
      local objects2 = localValue51:FindFirstChild("Objects")
      if objects2 then
        for index18, value22 in ipairs(objects2:GetChildren()) do
          localValue22.serialize_object(value22)
        end
      end
      local counters = localValue51:FindFirstChild("Counters")
      if counters then
        for index19, value23 in ipairs(counters:GetChildren()) do
          localValue22.serialize_object(value23)
        end
      end
      table.insert(localValue53, 0)
    end)
    spawnSaveTask(function()
      pcall(function()
        local pools = localValue51:FindFirstChild("Pools")
        if not pools then
          return
        end
        local total8 = 0
        for index20, value24 in ipairs(pools:GetChildren()) do
          local center2 =
            localValue22.cframe_to_table(localValue22.get_object_space(value24.HitBox.CFrame))
          local getAppearanceData3 = localValue21.color_service:GetAppearanceData(value24)
          local objects3 = localValue22.serialize_items(value24:FindFirstChild("ItemHolder"))
          total8 = total8 + localValue21.plot_service:GetObjectValue(value24)
          helperFunction17_1("pools", {
            Name = value24.Name,
            Center = center2,
            Size = { X = value24.HitBox.Size.X, Y = value24.HitBox.Size.Z },
            Color = getAppearanceData3,
            Objects = objects3,
          })
        end
        table.insert(localValue53, total8)
        return
      end)
    end)
    while pendingSaveTasks > 0 do
      task.wait(0.05)
    end
    if #serializationErrors > 0 then
      helperFunction7(
        "Build Save Error",
        nil,
        "Could not serialize the build: " .. table.concat(serializationErrors, "; ")
      )
      return false
    end
    local total9 = 0
    for index21, value25 in ipairs(localValue53) do
      total9 = total9 + value25
    end
    localValue52.real_value = total9 + localValue26
    localValue52.blockbux_value = localValue25
    print("Analyzing Gamepasses & Skills...")
    localValue55 = {}
    localValue56 = {}
    function helperFunction16_1(parameter48)
      if not parameter48 then
        return
      end
      local localValue69 = parameter48[1]
      local localValue70 = parameter48[2]
      local localValue71 = parameter48[3]
      if
        (localValue69 <= -75 or localValue69 >= 75 or localValue71 >= 25)
        and not table.find(localValue55, "Large Plot")
      then
        table.insert(localValue55, "Large Plot")
      end
      if localValue70 >= 15.85 and not table.find(localValue55, "Multiple Floors") then
        table.insert(localValue55, "Multiple Floors")
      end
    end
    function helperFunction14_1(parameter49)
      if not parameter49 then
        return
      end
      for key5, value26 in pairs(parameter49) do
        if type(value26) == "table" and value26[1] then
          local localValue72 = tonumber(value26[1])
          if
            localValue72
            and localValue72 < 0
            and not table.find(localValue55, "Custom Colors")
          then
            table.insert(localValue55, "Custom Colors")
          end
        end
      end
    end
    function helperFunction15_1(parameter50)
      if not parameter50 then
        return
      end
      local localValue73, localValue74 = pcall(function()
        return localValue21.item_service:GetItem(parameter50)
      end)
      if localValue73 and localValue74 and localValue74.Locked then
        for key6, value27 in pairs(localValue74.Locked) do
          if
            type(key6) == "string"
            and string.find(key6, "Skill_")
            and type(value27) == "number"
          then
            local localValue75 = string.gsub(key6, "Skill_", "")
            if not localValue56[localValue75] or value27 > localValue56[localValue75] then
              localValue56[localValue75] = value27
            end
          end
        end
      end
    end
    function helperFunction18_1(parameter51)
      if not parameter51 then
        return
      end
      for key7, value28 in pairs(parameter51) do
        helperFunction14_1(value28.Color)
        if value28.Position then
          helperFunction16_1(value28.Position)
        end
        if value28.CFrame then
          helperFunction16_1({ value28.CFrame[1], value28.CFrame[2], value28.CFrame[3] })
        end
        if value28.Name then
          helperFunction15_1(value28.Name)
        end
        if value28.Objects then
          helperFunction18_1(value28.Objects)
        end
      end
    end
    helperFunction18_1(localValue52.objects)
    helperFunction18_1(localValue52.walls)
    helperFunction18_1(localValue52.floors)
    helperFunction18_1(localValue52.roofs)
    helperFunction18_1(localValue52.fences)
    helperFunction18_1(localValue52.counters)
    localValue52.gamepasses = localValue55
    local localValue76 = {}
    for key8, value29 in pairs(localValue56) do
      table.insert(localValue76, key8 .. " " .. value29)
    end
    localValue52.skills = localValue76
    print("Detected Gamepasses:", table.concat(localValue55, ", "))
    print("Detected Skills:", table.concat(localValue52.skills, ", "))
    local jsonEncode = httpService:JSONEncode(localValue52)
    print("JSON Length:", #jsonEncode)
    if ctx.pub.Debug then
      local localValue77 = "WereTools_DebugSave_" .. tostring(math.floor(os.time())) .. ".json"
      writefile(localValue77, jsonEncode)
      helperFunction7(
        "[Debug] Save Successful!",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "Cost: "
          .. helperFunction4(localValue52.real_value)
          .. "\nBlockbux: "
          .. helperFunction4(localValue52.blockbux_value)
          .. "\nSaved as: "
          .. localValue77
      )
      setclipboard(localValue77)
      print("=== DEBUG SAVE COMPLETE ===")
      return true
    end
    local wereToolsSessionToken = ctx.auth:sessionToken()
    local res, usedBase
    for _, base in ipairs(ctx.config.backends) do
      local okReq, r = pcall(function()
        return requestBuild({
          Url = base .. "/api/upload?token=" .. tostring(wereToolsSessionToken or ""),
          Method = "POST",
          Headers = { ["Content-Type"] = "application/json" },
          Body = jsonEncode,
        })
      end)
      if okReq and r and r.Body and r.Body ~= "" and r.StatusCode == 200 then
        res = r
        usedBase = base
        break
      end
    end
    if not res or not res.Body then
      localValue4.notification_ui:CreateNotification(
        "Error",
        nil,
        "Failed to upload data | Rate Limit"
      )
      return nil
    end
    local okUpload, uploadData = pcall(function()
      return httpService:JSONDecode(res.Body)
    end)
    local id = okUpload and type(uploadData) == "table" and uploadData.id
    if not id then
      localValue4.notification_ui:CreateNotification("Error", nil, "Failed to get ID from api")
      return nil
    end
    local okFetch, response = pcall(function()
      return requestBuild({
        Url = usedBase .. "/api/upload/" .. id .. "?token=" .. tostring(
          wereToolsSessionToken or ""
        ),
        Method = "GET",
      })
    end)
    if not okFetch or not response or response.StatusCode ~= 200 or not response.Body then
      localValue4.notification_ui:CreateNotification(
        "Error",
        nil,
        "Upload succeeded but build details could not be verified"
      )
      return nil
    end
    local okDecode, responseData = pcall(function()
      return httpService:JSONDecode(response.Body)
    end)
    local data = okDecode and type(responseData) == "table" and responseData.data
    if type(data) ~= "table" then
      localValue4.notification_ui:CreateNotification(
        "Error",
        nil,
        "Upload succeeded but returned build data is invalid"
      )
      return nil
    end
    local gsub2 = id:gsub("[%s\n\r]+", "")
    helperFunction7(
      "Build Uploaded Successfully!",
      "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
      "Cost: "
        .. helperFunction4(data.real_value)
        .. "\nBlockbux: "
        .. helperFunction4(data.blockbux_value)
        .. "\nID: "
        .. gsub2
    )
    setclipboard(gsub2)
    print("=== UPLOAD COMPLETE ===")
    return true
  end

  function localValue22.set_paused(parameter52)
    localValue3 = parameter52
  end

  local localPlayer2 = players.LocalPlayer
  local playerGui = localPlayer2:WaitForChild("PlayerGui")
  local current2 = 0
  local localValue80 = 0
  local localValue81 = 0

  local localValue82 = {
    Walls = true,
    Floors = true,
    Roofs = true,
    Basements = true,
    Paths = true,
    Counters = true,
    Fences = true,
    Pools = true,
    Objects = true,
  }

  local failedItems = {
    walls = {},
    roofs = {},
    basements = {},
    floors = {},
    paths = {},
    counters = {},
    fences = {},
    pools = {},
    objects = {},
  }

  function localValue22.setObjectPlacement(parameter53, parameter54)
    if localValue82[parameter53] ~= nil then
      localValue82[parameter53] = parameter54
      print("Updated Setting:", parameter53, "=", parameter54)
      -- Publish to the shared filter so PreviewBuild can see the same config.
      ctx.pub.WereTools_BuildFilter = localValue82
    elseif type(parameter53) == "number" and type(parameter54) == "string" then
    else
      warn("Error: Setting '" .. tostring(parameter53) .. "' is nil!")
    end
  end

  ctx.pub.WereTools_UpdateBuild = localValue22.setObjectPlacement
  ctx.pub.WereTools_BuildFilter = localValue82
  local localValue83 = 2
  local localValue84 = 0.7
  local localValue85 = true
  local localValue86 = 0
  local localValue87 = 0
  local localValue88 = 2

  local function readNumericSetting(value, name, minimum, maximum, integer)
    local number = tonumber(value)
    if not number or number ~= number or number == math.huge or number == -math.huge then
      warn("[BuildModule] " .. name .. " must be a finite number")
      return nil
    end
    number = math.max(minimum, math.min(maximum, number))
    if integer then
      number = math.floor(number)
    end
    return number
  end

  function localValue22.setMaxRetries(parameter55)
    local retries = readNumericSetting(parameter55, "Max retries", 0, 20, true)
    if retries ~= nil then
      localValue88 = retries
    end
  end

  function localValue22.setPlacementTime(parameter56)
    local waitTime = readNumericSetting(parameter56, "Placement wait", 0, 30, false)
    if waitTime ~= nil then
      localValue83 = waitTime
    end
  end

  function localValue22.setColorTime(parameter57)
    local waitTime = readNumericSetting(parameter57, "Color wait", 0, 30, false)
    if waitTime ~= nil then
      localValue84 = waitTime
    end
  end

  function localValue22.load_house(parameter58, parameter59)
    local localValue89 = tick()
    local stats = replicatedStorage:FindFirstChild("Stats")
    local playerStats = stats and stats:FindFirstChild(localPlayer2.Name)
    local isBuilding = playerStats and playerStats:FindFirstChild("IsBuilding")
    local plots = workspaceService:FindFirstChild("Plots")
    local activePlot = isBuilding and plots and plots:FindFirstChild(tostring(isBuilding.Value))
    if not activePlot or not activePlot:FindFirstChild("Ground") then
      helperFunction7(
        "Error",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "Please enter Build Mode and wait for your plot to load."
      )
      return
    end

    local function helperFunction19(parameter60)
      if parameter60 <= 0 then
        return "00:00"
      else
        local localValue90 = math.floor(parameter60 / 60)
        local localValue91 = math.floor(parameter60 % 60)
        return string.format("%02d:%02d", localValue90, localValue91)
      end
    end

    local completedKeys2 = {}
    local localValue92 = {}
    localValue2 = false
    localValue3 = false
    local wereBuildUI = playerGui:FindFirstChild("WereBuildUI")

    if wereBuildUI then
      wereBuildUI:Destroy()
    end

    local localValue93 = {
      Background = Color3.fromRGB(25, 25, 30),
      Container = Color3.fromRGB(35, 35, 40),
      TextLight = Color3.fromRGB(240, 240, 240),
      TextDim = Color3.fromRGB(150, 150, 160),
      Accent = Color3.fromRGB(0, 170, 255),
      AccentGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255)),
      }),
      Error = Color3.fromRGB(255, 80, 80),
      Warning = Color3.fromRGB(255, 180, 50),
    }

    local wereBuildUI2 = Instance.new("ScreenGui")
    wereBuildUI2.Name = "WereBuildUI"
    wereBuildUI2.ResetOnSpawn = false
    wereBuildUI2.IgnoreGuiInset = true
    wereBuildUI2.DisplayOrder = 10
    wereBuildUI2.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 240, 0, 400)
    mainFrame.Position = UDim2.new(0, 20, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0, 0.5)
    mainFrame.BackgroundColor3 = localValue93.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Parent = wereBuildUI2

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

    local uiStroke = Instance.new("UIStroke", mainFrame)
    uiStroke.Color = Color3.fromRGB(50, 50, 60)
    uiStroke.Thickness = 1
    uiStroke.Transparency = 0.5

    local uiGradient = Instance.new("UIGradient", mainFrame)
    uiGradient.Rotation = 45
    uiGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)),
    })

    local position6, position7
    local function helperFunction20(parameter61)
      local localValue94 = parameter61.Position - position6
      tweenService
        :Create(mainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
          Position = UDim2.new(
            position7.X.Scale,
            position7.X.Offset + localValue94.X,
            position7.Y.Scale,
            position7.Y.Offset + localValue94.Y
          ),
        })
        :Play()
    end

    local localValue95
    mainFrame.InputBegan:Connect(function(input)
      if
        input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
      then
        localValue95 = true
        position6 = input.Position
        position7 = mainFrame.Position
        input.Changed:Connect(function()
          if input.UserInputState == Enum.UserInputState.End then
            localValue95 = false
          end
        end)
      end
    end)
    local localValue96
    mainFrame.InputChanged:Connect(function(input2)
      if
        input2.UserInputType == Enum.UserInputType.MouseMovement
        or input2.UserInputType == Enum.UserInputType.Touch
      then
        localValue96 = input2
      end
    end)
    userInputService.InputChanged:Connect(function(input3)
      if input3 == localValue96 and localValue95 then
        helperFunction20(input3)
      end
    end)

    local frame4 = Instance.new("Frame")
    frame4.Size = UDim2.new(1, 0, 0, 40)
    frame4.BackgroundTransparency = 1
    frame4.Parent = mainFrame

    local textLabel3 = Instance.new("TextLabel")
    textLabel3.Text = "WERETOOLS AUTO BUILD"
    textLabel3.Font = Enum.Font.GothamBlack
    textLabel3.TextSize = 12
    textLabel3.TextColor3 = localValue93.TextLight
    textLabel3.Position = UDim2.new(0, 16, 0, 0)
    textLabel3.Size = UDim2.new(1, -32, 1, 0)
    textLabel3.BackgroundTransparency = 1
    textLabel3.TextXAlignment = Enum.TextXAlignment.Left
    textLabel3.Parent = frame4

    local frame5 = Instance.new("Frame")
    frame5.Size = UDim2.new(1, -32, 0, 60)
    frame5.Position = UDim2.new(0, 16, 0, 50)
    frame5.BackgroundTransparency = 1
    frame5.Parent = mainFrame

    local textLabel4 = Instance.new("TextLabel")
    textLabel4.Size = UDim2.new(1, 0, 0, 30)
    textLabel4.BackgroundTransparency = 1
    textLabel4.Text = "0%"
    textLabel4.Font = Enum.Font.GothamBold
    textLabel4.TextSize = 32
    textLabel4.TextColor3 = localValue93.TextLight
    textLabel4.TextXAlignment = Enum.TextXAlignment.Left
    textLabel4.Parent = frame5

    local textLabel5 = Instance.new("TextLabel")
    textLabel5.Size = UDim2.new(1, 0, 0, 15)
    textLabel5.Position = UDim2.new(0, 0, 0, 32)
    textLabel5.BackgroundTransparency = 1
    textLabel5.Text = "Initializing..."
    textLabel5.Font = Enum.Font.GothamMedium
    textLabel5.TextSize = 11
    textLabel5.TextColor3 = localValue93.TextDim
    textLabel5.TextXAlignment = Enum.TextXAlignment.Left
    textLabel5.Parent = frame5

    local frame6 = Instance.new("Frame")
    frame6.Size = UDim2.new(1, 0, 0, 6)
    frame6.Position = UDim2.new(0, 0, 1, -6)
    frame6.BackgroundColor3 = localValue93.Container
    frame6.Parent = frame5
    Instance.new("UICorner", frame6).CornerRadius = UDim.new(1, 0)

    local frame7 = Instance.new("Frame")
    frame7.Size = UDim2.new(0, 0, 1, 0)
    frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame7.Parent = frame6
    Instance.new("UICorner", frame7).CornerRadius = UDim.new(1, 0)
    Instance.new("UIGradient", frame7).Color = localValue93.AccentGradient

    local frame8 = Instance.new("Frame")
    frame8.Size = UDim2.new(1, -32, 0, 150)
    frame8.Position = UDim2.new(0, 16, 0, 125)
    frame8.BackgroundColor3 = localValue93.Container
    frame8.Parent = mainFrame
    Instance.new("UICorner", frame8).CornerRadius = UDim.new(0, 8)
    local uiPadding = Instance.new("UIPadding", frame8)
    uiPadding.PaddingTop = UDim.new(0, 10)
    uiPadding.PaddingBottom = UDim.new(0, 10)
    uiPadding.PaddingLeft = UDim.new(0, 12)
    uiPadding.PaddingRight = UDim.new(0, 12)
    local uiListLayout = Instance.new("UIListLayout", frame8)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 6)

    local function helperFunction21(text3, text4)
      local frame9 = Instance.new("Frame")
      frame9.Size = UDim2.new(1, 0, 0, 15)
      frame9.BackgroundTransparency = 1
      frame9.Parent = frame8
      local textLabel6 = Instance.new("TextLabel")
      textLabel6.Text = text3
      textLabel6.Font = Enum.Font.GothamMedium
      textLabel6.TextSize = 10
      textLabel6.TextColor3 = localValue93.TextDim
      textLabel6.Size = UDim2.new(0.4, 0, 1, 0)
      textLabel6.BackgroundTransparency = 1
      textLabel6.TextXAlignment = Enum.TextXAlignment.Left
      textLabel6.Parent = frame9
      local textLabel7 = Instance.new("TextLabel")
      textLabel7.Text = text4
      textLabel7.Font = Enum.Font.GothamBold
      textLabel7.TextSize = 11
      textLabel7.TextColor3 = localValue93.TextLight
      textLabel7.Size = UDim2.new(0.6, 0, 1, 0)
      textLabel7.Position = UDim2.new(0.4, 0, 0, 0)
      textLabel7.BackgroundTransparency = 1
      textLabel7.TextXAlignment = Enum.TextXAlignment.Right
      textLabel7.TextTruncate = Enum.TextTruncate.AtEnd
      textLabel7.Parent = frame9
      return textLabel7
    end

    local localValue97 = helperFunction21("STATUS", "Idle")
    local localValue98 = helperFunction21("ACTION", "--")
    local localValue99 = helperFunction21("OBJECT", "--")
    local localValue100 = helperFunction21("PROGRESS", "0 / 0")
    local localValue101 = helperFunction21("ELAPSED", "00:00")
    local localValue102 = helperFunction21("TIME LEFT", "--:--")

    local frame10 = Instance.new("Frame")
    frame10.Size = UDim2.new(1, -32, 0, 28)
    frame10.Position = UDim2.new(0, 16, 1, -16)
    frame10.AnchorPoint = Vector2.new(0, 1)
    frame10.BackgroundTransparency = 1
    frame10.Parent = mainFrame
    local uiListLayout2 = Instance.new("UIListLayout", frame10)
    uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout2.Padding = UDim.new(0, 10)

    local function helperFunction22(text5, parameter62, fn)
      local textButton2 = Instance.new("TextButton")
      textButton2.Size = UDim2.new(0.5, -5, 1, 0)
      textButton2.BackgroundColor3 = parameter62
      textButton2.BackgroundTransparency = 0.85
      textButton2.Text = text5
      textButton2.Font = Enum.Font.GothamBold
      textButton2.TextSize = 11
      textButton2.TextColor3 = parameter62
      textButton2.AutoButtonColor = false
      textButton2.Parent = frame10
      Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 6)
      local uiStroke2 = Instance.new("UIStroke", textButton2)
      uiStroke2.Color = parameter62
      uiStroke2.Thickness = 1.5
      uiStroke2.Transparency = 0.6
      uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
      textButton2.MouseEnter:Connect(function()
        tweenService
          :Create(textButton2, TweenInfo.new(0.2), { BackgroundTransparency = 0.7 })
          :Play()
        tweenService:Create(uiStroke2, TweenInfo.new(0.2), { Transparency = 0.2 }):Play()
      end)
      textButton2.MouseLeave:Connect(function()
        tweenService
          :Create(textButton2, TweenInfo.new(0.2), { BackgroundTransparency = 0.85 })
          :Play()
        tweenService:Create(uiStroke2, TweenInfo.new(0.2), { Transparency = 0.6 }):Play()
      end)
      textButton2.MouseButton1Click:Connect(function()
        local frame11 = Instance.new("Frame")
        frame11.BackgroundColor3 = parameter62
        frame11.BackgroundTransparency = 0.6
        frame11.Size = UDim2.new(0, 0, 0, 0)
        frame11.Position = UDim2.new(0.5, 0, 0.5, 0)
        frame11.AnchorPoint = Vector2.new(0.5, 0.5)
        frame11.Parent = textButton2
        Instance.new("UICorner", frame11).CornerRadius = UDim.new(1, 0)
        local create2 = tweenService:Create(frame11, TweenInfo.new(0.4), {
          Size = UDim2.new(1.2, 0, 2.5, 0),
          BackgroundTransparency = 1,
        })
        create2:Play()
        create2.Completed:Connect(function()
          frame11:Destroy()
        end)
        fn()
      end)
      return textButton2
    end

    helperFunction22("PAUSE", localValue93.Warning, function()
      localValue3 = not localValue3
    end)
    helperFunction22("CANCEL", localValue93.Error, function()
      localValue2 = true
      localValue97.Text = "CANCELLING..."
      localValue97.TextColor3 = localValue93.Error
      tweenService
        :Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
          Size = UDim2.new(0, 0, 0, 0),
          BackgroundTransparency = 1,
        })
        :Play()
      task.wait(0.35)
      if wereBuildUI2 then
        wereBuildUI2:Destroy()
      end
    end)

    mainFrame.Size = UDim2.new(0, 200, 0, 250)
    mainFrame.BackgroundTransparency = 1
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    tweenService
      :Create(
        mainFrame,
        tweenInfo,
        { Size = UDim2.new(0, 240, 0, 340), BackgroundTransparency = 0 }
      )
      :Play()

    local localValue103 = 0
    local function helperFunction23(parameter63, ...)
      if localValue2 then
        return nil
      end
      while localValue3 do
        task.wait(0.1)
      end
      localValue87 = localValue87 + 1
      if localValue87 > 1 then
        task.wait(localValue84)
        localValue87 = 1
      end
      local localValue103b = { pcall(parameter63, ...) }
      return localValue103b[2]
    end

    local localValue104 = 0
    local function helperFunction24(parameter64, parameter65)
      if localValue3 then
        localValue97.Text = "PAUSED"
        localValue97.TextColor3 = localValue93.Warning
        return
      end
      localValue97.Text = "ACTIVE"
      localValue97.TextColor3 = localValue93.Accent
      local now = tick()
      if now - localValue104 < 0.1 then
        return
      end
      localValue104 = now
      if parameter64 then
        localValue98.Text = string.upper(parameter64)
      end
      if parameter65 then
        localValue99.Text = parameter65
        textLabel5.Text = "Processing: " .. parameter65
      end
      local current = current2
      local total = localValue80
      localValue100.Text = string.format("%d / %d", current, total)
      local frac = 0
      if total > 0 then
        frac = math.clamp(current / total, 0, 1)
      end
      frame7:TweenSize(
        UDim2.new(frac, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.3,
        true
      )
      textLabel4.Text = string.format("%.2f%%", frac * 100)
      local elapsed = now - localValue89
      localValue101.Text = helperFunction19(elapsed)
      if localValue81 > 5 and elapsed > 5 then
        localValue102.Text =
          helperFunction19(math.max(0, total - current) * (elapsed / localValue81 * 1.1))
      elseif localValue81 == 0 then
        localValue102.Text = "--:--"
      else
        localValue102.Text = "Calculating..."
      end
    end

    local function helperFunction25(parameter66)
      return { { parameter66.ColorNumber, parameter66.MaterialNumber }, {}, {}, {} }
    end

    local function helperFunction26(parameter67, ...)
      local count2 = 0
      while true do
        if localValue2 then
          return nil
        end
        while localValue3 do
          task.wait(0.1)
        end
        localValue86 = localValue86 + 1
        if localValue86 > (localValue85 and 6 or 8) then
          task.wait(localValue83)
          localValue86 = 1
          if localValue85 then
            localValue85 = false
          end
        end
        local ok, result = pcall(parameter67, ...)
        if ok and result then
          return result
        end
        count2 = count2 + 1
        if count2 >= 3 then
          return nil
        end
        task.wait(0.2)
      end
    end

    local function helperFunction27(parameter68)
      current2 = current2 + 1
      localValue81 = localValue81 + 1
      helperFunction24(nil, parameter68)
    end

    local function helperFunction28(parameter69, ...)
      local count3 = 0
      while true do
        if localValue2 then
          return nil
        end
        while localValue3 do
          task.wait(0.1)
        end
        localValue87 = localValue87 + 1
        if localValue87 > 1 then
          task.wait(localValue84)
          localValue87 = 1
        end
        local ok, result = pcall(parameter69, ...)
        if ok then
          return result
        end
        count3 = count3 + 1
        if count3 >= 3 then
          return nil
        end
        task.wait(0.2)
      end
    end

    local function helperFunction29(parameter70, parameter71, parameter72)
      if parameter70 == parameter71 then
        return true
      end
      if type(parameter70) ~= type(parameter71) then
        return false
      end
      if type(parameter70) ~= "table" then
        return parameter70 == parameter71
      end
      local localValue114 = parameter72 or {}
      localValue114[parameter70] = localValue114[parameter70] or {}
      if localValue114[parameter70][parameter71] then
        return true
      end
      localValue114[parameter70][parameter71] = true
      local count4 = 0
      local count5 = 0
      for key10, value31 in pairs(parameter70) do
        count5 = count5 + 1
        if
          parameter71[key10] == nil
          or not helperFunction29(value31, parameter71[key10], localValue114)
        then
          return false
        end
      end
      for key11 in pairs(parameter71) do
        count4 = count4 + 1
      end
      return count5 == count4
    end

    local function helperFunction30(parameter73)
      local total10 = 0
      if parameter73 then
        for index22, value32 in ipairs(parameter73) do
          total10 = total10 + 1
          if value32.Objects then
            total10 = total10 + helperFunction30(value32.Objects)
          end
        end
      end
      return total10
    end

    local function validateBuildData(data)
      if type(data) ~= "table" then
        return false, "Build data must be a JSON object"
      end

      local function validateItems(items, category)
        for index, item in pairs(items) do
          if type(item) ~= "table" then
            return false, string.format("Invalid item in %s at index %s", category, tostring(index))
          end
          if item.Objects ~= nil then
            if type(item.Objects) ~= "table" then
              return false,
                string.format("Invalid nested objects in %s at index %s", category, tostring(index))
            end
            local valid, message = validateItems(item.Objects, category .. ".Objects")
            if not valid then
              return false, message
            end
          end
        end
        return true
      end

      local keys = {
        "walls",
        "floors",
        "roofs",
        "basements",
        "paths",
        "counters",
        "fences",
        "pools",
        "objects",
      }
      local foundCategory = false
      for _, key in ipairs(keys) do
        if data[key] ~= nil then
          foundCategory = true
          if type(data[key]) ~= "table" then
            return false, "Build data category '" .. key .. "' is not a list"
          end
          local valid, message = validateItems(data[key], key)
          if not valid then
            return false, message
          end
        else
          data[key] = {}
        end
      end
      if not foundCategory then
        return false, "Build data has no recognized build categories"
      end
      return true
    end

    local colorIndex = 0
    local data2, localValue115

    failedItems = {
      walls = {},
      roofs = {},
      basements = {},
      floors = {},
      paths = {},
      counters = {},
      fences = {},
      pools = {},
      objects = {},
    }

    if parameter59 then
      if not isfile("build_data.json") or not isfile("build_progress.json") then
        helperFunction7("Error", nil, "No save data found to resume!")
        return
      end
      local ok1, val1 = pcall(function()
        return httpService:JSONDecode(readfile("build_data.json"))
      end)
      if not ok1 or type(val1) ~= "table" then
        helperFunction7("Error", nil, "Saved build data is missing or corrupted!")
        if wereBuildUI2.Parent then
          wereBuildUI2:Destroy()
        end
        return
      end
      data2 = val1
      local ok2, val2 = pcall(function()
        return httpService:JSONDecode(readfile("build_progress.json"))
      end)
      if not ok2 or type(val2) ~= "table" or type(val2.stats) ~= "table" then
        helperFunction7("Error", nil, "Saved build progress is missing or corrupted!")
        if wereBuildUI2.Parent then
          wereBuildUI2:Destroy()
        end
        return
      end
      local plotName = tostring(replicatedStorage.Stats[localPlayer2.Name].IsBuilding.Value)
      local findFirstChild = workspaceService.Plots:FindFirstChild(plotName)
      if not findFirstChild or not findFirstChild:FindFirstChild("Ground") then
        helperFunction7("Error", nil, "Could not find Plot Ground!")
        return
      end
      ground_cf = findFirstChild.Ground.CFrame
      if type(val2.completed_keys) == "table" then
        completedKeys2 = val2.completed_keys
      end
      current2 = tonumber(val2.stats.current) or 0
      colorIndex = tonumber(val2.stats.color_index) or 0
      if type(val2.failed_items) == "table" then
        failedItems = val2.failed_items
      end
      if type(val2.color_queue) == "table" then
        print("Resuming " .. #val2.color_queue .. " color tasks...")
        helperFunction24("Resuming...", "Scanning all objects instantly...")
        for index23, value33 in ipairs(val2.color_queue) do
          local found =
            helperFunction13(value33.category_hint or "objects", value33, findFirstChild)
          if found then
            value33.object = found
            value33.object_pos = nil
            value33.category_hint = nil
            table.insert(localValue92, value33)
          end
        end
      end
      helperFunction24("Resuming...", "Restoring state")
    else
      pcall(function()
        delfile("build_progress.json")
        delfile("build_data.json")
      end)
      if ctx.pub.Debug then
        helperFunction24("Setup data...", "Reading Local File")
        localValue115 = "WereTools_DebugSave.json"
        if not string.find(localValue115, "%.json$") then
          localValue115 = localValue115 .. ".json"
        end
        if isfile(localValue115) then
          local ok3, val3 = pcall(function()
            return httpService:JSONDecode(readfile(localValue115))
          end)
          if ok3 and val3 then
            data2 = val3.data or val3
          else
            helperFunction24("Error", "Failed to parse local build data")
            helperFunction7("Error", nil, "File error: " .. localValue115)
            return
          end
        else
          helperFunction24("Error", "Local file not found")
          helperFunction7("Error", nil, "File does not exist: " .. localValue115)
          return
        end
      else
        helperFunction24("Setup data...", "Connecting to Server")
        local fetchRes, usedBase
        local bases = ctx.config.backends
        for _, base in ipairs(bases) do
          local okFetch, res = pcall(function()
            return requestBuild({
              Url = base .. "/api/upload/" .. httpService:UrlEncode(tostring(parameter58)),
              Method = "GET",
            })
          end)
          if okFetch and res and res.Body and res.Body ~= "" then
            local okDecode, decoded = pcall(function()
              return httpService:JSONDecode(res.Body)
            end)
            if okDecode and type(decoded) == "table" and (decoded.data or decoded.success) then
              fetchRes = decoded
              usedBase = base
              break
            end
          end
        end
        if not fetchRes then
          helperFunction24("Error", "Failed to load build data")
          return
        end
        data2 = fetchRes.data or fetchRes
        print("[BuildModule] loaded build data via " .. tostring(usedBase))
        pcall(function()
          writefile("build_data.json", httpService:JSONEncode(data2))
          print("Build Data Saved Initial File")
        end)
      end
    end

    local validData, dataError = validateBuildData(data2)
    if not validData then
      helperFunction24("Error", dataError)
      helperFunction7("Error", "rbxthumb://type=Asset&id=119978200516532&w=420&h=420", dataError)
      if wereBuildUI2.Parent then
        wereBuildUI2:Destroy()
      end
      return
    end
    for _, key in ipairs({
      "walls",
      "roofs",
      "basements",
      "floors",
      "paths",
      "counters",
      "fences",
      "pools",
      "objects",
    }) do
      if type(failedItems[key]) ~= "table" then
        failedItems[key] = {}
      end
    end

    local localValue126 = activePlot
    local helperFunction31
    function helperFunction31(parameter74, parameter75)
      completedKeys2[parameter74 .. "_" .. parameter75] = true
      helperFunction12(nil, completedKeys2, localValue92, failedItems, current2, localValue80)
    end
    ground_cf = localValue126.Ground.CFrame
    local helperFunction32
    function helperFunction32(parameter76, parameter77)
      return completedKeys2[parameter76 .. "_" .. parameter77] == true
    end
    local function helperFunction33(parameter78)
      local total11 = 0
      for key12, value34 in pairs({
        walls = "Walls",
        floors = "Floors",
        roofs = "Roofs",
        basements = "Basements",
        paths = "Paths",
        counters = "Counters",
        fences = "Fences",
        pools = "Pools",
        objects = "Objects",
      }) do
        if localValue82[value34] and parameter78[key12] and type(parameter78[key12]) == "table" then
          local list = parameter78[key12]
          total11 = total11 + #list
          for index24, value35 in ipairs(list) do
            if value35.Objects then
              total11 = total11 + helperFunction30(value35.Objects)
            end
          end
        end
      end
      return total11
    end

    -- Honor Multi Build Config: if a category is disabled, blank it out so the
    -- loops below skip it entirely (rather than just reporting a smaller total).
    do
      local CATEGORY_DATA_KEYS = {
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

      -- Count how many categories the user has left enabled. If the dropdown
      -- sits at "nothing selected" (the default), every value reads false and
      -- we'd blank the whole build. Treat that as "no filter" instead.
      local enabledCount, totalCount = 0, 0
      for uiName, _ in pairs(CATEGORY_DATA_KEYS) do
        totalCount = totalCount + 1
        if localValue82[uiName] ~= false then
          enabledCount = enabledCount + 1
        end
      end

      if enabledCount == 0 then
        print("[BuildModule] No categories selected -- loading everything")
        for uiName, _ in pairs(CATEGORY_DATA_KEYS) do
          localValue82[uiName] = true
        end
        ctx.pub.WereTools_BuildFilter = localValue82
      else
        local skippedCats = {}
        for uiName, dataKey in pairs(CATEGORY_DATA_KEYS) do
          if
            localValue82[uiName] == false
            and type(data2[dataKey]) == "table"
            and #data2[dataKey] > 0
          then
            table.insert(skippedCats, uiName .. "(" .. #data2[dataKey] .. ")")
            data2[dataKey] = {}
          end
        end
        if #skippedCats > 0 then
          print("[BuildModule] Skipping disabled categories: " .. table.concat(skippedCats, ", "))
        end
      end
    end

    localValue80 = helperFunction33(data2)
    current2 = 0
    local localValue128 = {}
    local walls2 = data2.walls

    local function helperFunction34(parameter79)
      if localValue2 then
        return
      end
      while localValue3 do
        task.wait(0.1)
      end
      task.wait(0.5)
      local paintLabel = "Painting"
      if parameter79.type == "image" then
        paintLabel = "Image"
      elseif parameter79.name and parameter79.name:find("Wall") then
        paintLabel = "Wall Paint"
      end
      helperFunction24(paintLabel, parameter79.name or "Item")
      if parameter79.type == "wall_color" then
        helperFunction28(function(...)
          return localValue5.ColorObject:InvokeServer(...)
        end, {
          Object = parameter79.object,
          UseMaterials = true,
          Side = parameter79.side,
          Data = helperFunction25(parameter79.color),
        })
      elseif parameter79.type == "color" then
        helperFunction28(function(...)
          return localValue5.ColorObject:InvokeServer(...)
        end, {
          Object = parameter79.object,
          UseMaterials = true,
          Data = parameter79.color,
        })
      elseif parameter79.type == "image" then
        task.wait(1)
        helperFunction23(function(...)
          return localValue5.SetPicture:FireServer(...)
        end, {
          Object = parameter79.object,
          ID = parameter79.image,
        })
      end
      helperFunction12(
        nil,
        completedKeys2,
        localValue92,
        failedItems,
        current2,
        localValue80,
        colorIndex
      )
      return
    end

    local function helperFunction35(parameter80, parameter81)
      local rot = helperFunction9(
        (localValue22.get_world_space(localValue22.table_to_cframe(parameter80.CFrame)))
      )
      local side
      if parameter80.Side == 1 then
        side = false
      elseif parameter80.Side == -1 then
        side = true
      end
      local placement = {
        Name = parameter80.Name,
        Pos = localValue22.get_world_space(localValue22.table_to_vec3(parameter80.Position)),
        Rot = rot,
        TargetModel = parameter81,
        Side = side,
        CustomOffset = parameter80.CustomOffset or 0,
        Moved = localValue4.player_stats.Inventory:FindFirstChild(parameter80.Name) and "Inventory"
          or false,
      }
      if parameter80.StartPos and parameter80.EndPos then
        placement.StartPos =
          localValue22.get_world_space(localValue22.table_to_vec3(parameter80.StartPos))
        placement.EndPos =
          localValue22.get_world_space(localValue22.table_to_vec3(parameter80.EndPos))
        placement.StartTargetModel = parameter81
        placement.Pos = (placement.StartPos + placement.EndPos) * 0.5
      end
      if parameter80.Height then
        placement.TypeData = { Height = parameter80.Height }
      end
      local result = helperFunction26(function(...)
        return localValue5.PlaceObject:InvokeServer(...)
      end, placement)
      return result and result.Value, parameter80
    end

    local function helperFunction36(parameter82)
      task.wait(1)
      local result = helperFunction26(function(...)
        return localValue5.PlaceWall:InvokeServer(...)
      end, {
        From = localValue22.get_world_space(localValue22.table_to_vec3(parameter82.From)),
        To = localValue22.get_world_space(localValue22.table_to_vec3(parameter82.To)),
      })
      return result and result.Value, parameter82
    end

    local function helperFunction37(parameter83, parameter84, parameter85, parameter86)
      local localValue134 = parameter84
      local placed = false
      local placedObj = nil
      local canPlace = helperFunction8(parameter83.Name)
        or localValue4.player_stats.Inventory:FindFirstChild(parameter83.Name)

      if canPlace then
        local newObj, _ = helperFunction35(parameter83, parameter84)
        if newObj then
          localValue134 = newObj
          placedObj = newObj
          placed = true
          parameter85[1] = parameter85[1] + 1
          helperFunction27(parameter83.Name or "Object")
        else
          helperFunction27((parameter83.Name or "Item") .. " (Item)")
          table.insert(failedItems.objects, { data = parameter83, parent = parameter84 })
        end
      end

      if placed then
        if parameter83.Size then
          for k = 1, 4 do
            if localValue2 then
              return
            end
            while localValue3 do
              task.wait(0.1)
            end
            if
              helperFunction28(function(...)
                return localValue5.ResizeObject:InvokeServer(...)
              end, {
                Object = placedObj,
                Data = { [1] = localValue22.table_to_vec3(parameter83.Size) },
              })
            then
              break
            end
            task.wait(0.5)
          end
        end
        if parameter83.Offset then
          for m = 1, 4 do
            if localValue2 then
              return
            end
            while localValue3 do
              task.wait(0.1)
            end
            if
              helperFunction28(function(...)
                return localValue5.TransformObject:InvokeServer(...)
              end, {
                Object = placedObj,
                Offset = localValue22.table_to_cframe(parameter83.Offset),
              })
            then
              break
            end
            task.wait(0.5)
          end
        end
        if
          parameter83.Color
          and not helperFunction29(
            localValue21.color_service:GetDefaultColors(placedObj),
            parameter83.Color
          )
        then
          helperFunction34({
            type = "color",
            object = placedObj,
            color = parameter83.Color,
            name = placedObj.Name,
          })
        end
        if parameter83.Image then
          helperFunction34({
            type = "image",
            object = placedObj,
            image = parameter83.Image,
            name = placedObj.Name,
          })
        end
      end

      if parameter83.Objects then
        for index25, value36 in ipairs(parameter83.Objects) do
          helperFunction37(value36, localValue134, parameter85, parameter86)
        end
      end
      return placed
    end

    local function helperFunction38(parameter87, parameter88, parameter89, parameter90)
      if localValue2 then
        return
      end
      while localValue3 do
        task.wait(0.1)
      end
      local rot2 = helperFunction9(
        (localValue22.get_world_space(localValue22.table_to_cframe(parameter87.CFrame)))
      )
      local placement = {
        Name = parameter87.Name,
        Pos = localValue22.get_world_space(localValue22.table_to_vec3(parameter87.Position)),
        Rot = rot2,
        TargetModel = parameter88,
        Height = parameter87.Height,
        CustomOffset = parameter87.CustomOffset or 0,
        Moved = localValue4.player_stats.Inventory:FindFirstChild(parameter87.Name) and "Inventory"
          or false,
      }
      if parameter87.id then
        placement.TargetModel = localValue128[parameter87.id]
      end
      if parameter87.StartPos and parameter87.EndPos then
        placement.StartPos =
          localValue22.get_world_space(localValue22.table_to_vec3(parameter87.StartPos))
        placement.EndPos =
          localValue22.get_world_space(localValue22.table_to_vec3(parameter87.EndPos))
        placement.StartTargetModel = placement.TargetModel
        placement.Pos = (placement.StartPos + placement.EndPos) * 0.5
      end
      local localValue138 = parameter88
      if
        helperFunction8(parameter87.Name)
        or localValue4.player_stats.Inventory:FindFirstChild(parameter87.Name)
      then
        local result = helperFunction26(function(...)
          return localValue5.PlaceObject:InvokeServer(...)
        end, placement)
        if result and result.Value then
          local placedObj = result.Value
          localValue138 = placedObj
          parameter89[1] = parameter89[1] + 1
          helperFunction27(parameter87.Name or "Object")
          if parameter87.Size then
            for n = 1, 4 do
              if localValue2 then
                return
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.ResizeObject:InvokeServer(...)
                end, {
                  Object = placedObj,
                  Data = { [1] = localValue22.table_to_vec3(parameter87.Size) },
                })
              then
                break
              end
              task.wait(0.5)
            end
          end
          if parameter87.Offset then
            for i6 = 1, 4 do
              if localValue2 then
                return
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.TransformObject:InvokeServer(...)
                end, {
                  Object = placedObj,
                  Offset = localValue22.table_to_cframe(parameter87.Offset),
                })
              then
                break
              end
              task.wait(0.5)
            end
          end
          if
            parameter87.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(placedObj),
              parameter87.Color
            )
          then
            helperFunction34({
              type = "color",
              object = placedObj,
              color = parameter87.Color,
              name = parameter87.Name,
            })
          end
          if parameter87.Image then
            helperFunction34({
              type = "image",
              object = placedObj,
              image = parameter87.Image,
              name = parameter87.Name,
            })
          end
        else
          parameter89[1] = parameter89[1] + 1
          helperFunction27("(Objects)")
          table.insert(failedItems.objects, { data = parameter87, parent = parameter88 })
        end
        if parameter87.Objects then
          for index26, value38 in ipairs(parameter87.Objects) do
            helperFunction38(value38, localValue138, parameter89, parameter90)
          end
        end
        return
      end
      if parameter87.Objects then
        for index27, value39 in ipairs(parameter87.Objects) do
          helperFunction38(value39, localValue138, parameter89, parameter90)
        end
      end
    end

    helperFunction24("Building Walls...", "Placing wall segments")

    for key13, value40 in pairs(data2.walls) do
      if localValue2 then
        break
      end
      if helperFunction32("walls", key13) then
        local found = helperFunction13("walls", value40, localValue126)
        if found then
          localValue128[value40.id] = found
        end
      else
        while localValue3 do
          task.wait(0.1)
        end
        local wallObj, _ = helperFunction36(value40)
        if wallObj then
          localValue128[value40.id] = wallObj
          helperFunction27("Wall")
          if
            value40.LeftColor
            and not (
              value40.LeftColor.ColorNumber == 194 and value40.LeftColor.MaterialNumber == 15
            )
          then
            helperFunction34({
              type = "wall_color",
              object = wallObj,
              side = "L",
              color = value40.LeftColor,
            })
          end
          if
            value40.RightColor
            and not (
              value40.RightColor.ColorNumber == 194 and value40.RightColor.MaterialNumber == 15
            )
          then
            helperFunction34({
              type = "wall_color",
              object = wallObj,
              side = "R",
              color = value40.RightColor,
            })
          end
          helperFunction31("walls", key13)
          if value40.Objects then
            local counter = { 0 }
            for _, obj in ipairs(value40.Objects) do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              helperFunction37(obj, wallObj, counter, #value40.Objects)
            end
          end
        else
          table.insert(failedItems.walls, value40)
          helperFunction27("Wall #" .. tostring(value40.id) .. " (Wall)")
        end
      end
    end

    if localValue2 then
      helperFunction24("Aborted!", "Cancelled")
      task.wait(2)
      wereBuildUI2:Destroy()
      return
    end
    helperFunction24("Building Roofs...", "Placing roofs")

    for key14, value42 in pairs(data2.roofs) do
      if localValue2 then
        break
      end
      if not helperFunction32("roofs", key14) then
        while localValue3 do
          task.wait(0.1)
        end
        local points = {}
        for _, pt in pairs(value42.Points) do
          table.insert(points, localValue22.get_world_space(localValue22.table_to_vec3(pt)))
        end
        local settings = { Type = value42.Type or "Flat Roof", IsPreview = false, RotateNum = 0 }
        for k, v in pairs(value42) do
          if type(v) == "number" then
            settings[k] = v
          end
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceRoof:InvokeServer(...)
        end, {
          Points = points,
          Start = points[#points],
          Settings = settings,
        })
        if result and result.Value then
          helperFunction27(value42.Type)
          if value42.Color then
            helperFunction34({ type = "color", object = result.Value, color = value42.Color })
          end
          helperFunction31("roofs", key14)
          if value42.Objects then
            local counter = { 0 }
            for _, obj in ipairs(value42.Objects) do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              helperFunction37(obj, result.Value, counter, #value42.Objects)
            end
          end
        else
          table.insert(failedItems.roofs, value42)
          helperFunction27((value42.Type or "Roof") .. " (Roofs)")
        end
      end
    end

    helperFunction24("Building Basements...", "Placing basements")
    for key17, value46 in pairs(data2.basements) do
      if localValue2 then
        break
      end
      while localValue3 do
        task.wait(0.1)
      end
      if not helperFunction32("basements", key17) then
        local center = {
          ground_cf
            :ToObjectSpace(localValue22.get_load_cframe(value46.Center, localValue126))
            :components(),
        }
        center[2] = 1e-7
        if
          helperFunction26(function(...)
            return localValue5.PlaceBasement:InvokeServer(...)
          end, {
            ItemType = "Basements",
            Center = CFrame.new(unpack(center)),
            Size = Vector2.new(unpack(value46.Size)),
          })
        then
          helperFunction27("Basement")
          helperFunction31("basements", key17)
        else
          table.insert(failedItems.basements, value46)
          helperFunction27("Basement")
        end
      end
    end

    helperFunction24("Building Floors...", "Placing floors")
    for key18, value47 in pairs(data2.floors) do
      if localValue2 then
        break
      end
      while localValue3 do
        task.wait(0.1)
      end
      if not helperFunction32("floors", key18) then
        local points = {}
        for _, pt in pairs(value47.Points) do
          table.insert(points, localValue22.get_world_space(localValue22.table_to_vec3(pt)))
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceFloor:InvokeServer(...)
        end, { Points = points })
        if result and result.Value then
          helperFunction27("Floor")
          if
            value47.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(result.Value),
              value47.Color
            )
          then
            helperFunction34({ type = "color", object = result.Value, color = value47.Color })
          end
          helperFunction31("floors", key18)
          if value47.Objects then
            local counter = { 0 }
            for _, obj in ipairs(value47.Objects) do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              helperFunction37(obj, result.Value, counter, #value47.Objects)
            end
          end
        else
          table.insert(failedItems.floors, value47)
          helperFunction27("Floor")
        end
      end
    end

    helperFunction24("Building Paths...", "Placing paths")
    for key20, value50 in pairs(data2.paths) do
      if localValue2 then
        break
      end
      if not helperFunction32("paths", key20) then
        while localValue3 do
          task.wait(0.1)
        end
        local result = helperFunction26(function(...)
          return localValue5.PlacePath:InvokeServer(...)
        end, {
          From = localValue22.get_world_space(localValue22.table_to_vec3(value50.From)),
          To = localValue22.get_world_space(localValue22.table_to_vec3(value50.To)),
        })
        if result and result.Value then
          helperFunction27("Path")
          if
            value50.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(result.Value),
              value50.Color
            )
          then
            helperFunction34({ type = "color", object = result.Value, color = value50.Color })
          end
          helperFunction31("paths", key20)
          if value50.Objects then
            local counter = { 0 }
            for _, obj in ipairs(value50.Objects) do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              helperFunction37(obj, result.Value, counter, #value50.Objects)
            end
          end
        else
          table.insert(failedItems.paths, value50)
          helperFunction27("(Path)")
        end
      end
    end

    helperFunction24("Building Counters...", "Placing counters")
    for key21, value52 in pairs(data2.counters) do
      if localValue2 then
        break
      end
      if not helperFunction32("counters", key21) then
        while localValue3 do
          task.wait(0.1)
        end
        local rot3 = helperFunction9(
          (localValue22.get_world_space(localValue22.table_to_cframe(value52.CFrame)))
        )
        local placement = {
          Name = value52.Name,
          Pos = localValue22.get_world_space(localValue22.table_to_vec3(value52.Position)),
          Rot = rot3,
          TargetModel = localValue126.Ground,
        }
        if value52.id and localValue128[value52.id] then
          placement.TargetModel = localValue128[value52.id]
        end
        if value52.Height then
          placement.Height = value52.Height
        end
        if value52.StartPos and value52.EndPos then
          placement.StartPos =
            localValue22.get_world_space(localValue22.table_to_vec3(value52.StartPos))
          placement.EndPos =
            localValue22.get_world_space(localValue22.table_to_vec3(value52.EndPos))
          placement.StartTargetModel = placement.TargetModel
          placement.Pos = (placement.StartPos + placement.EndPos) * 0.5
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceObject:InvokeServer(...)
        end, placement)
        if result and result.Value then
          local obj = result.Value
          helperFunction27(value52.Name or "Counter")
          helperFunction31("counters", key21)
          if value52.Size then
            for i7 = 1, 4 do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.ResizeObject:InvokeServer(...)
                end, {
                  Object = obj,
                  Data = { [1] = localValue22.table_to_vec3(value52.Size) },
                })
              then
                break
              end
              task.wait(1.5)
            end
          end
          if value52.Offset then
            for i8 = 1, 4 do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.TransformObject:InvokeServer(...)
                end, {
                  Object = obj,
                  Offset = localValue22.table_to_cframe(value52.Offset),
                })
              then
                break
              end
              task.wait(1.5)
            end
          end
          if
            value52.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(obj),
              value52.Color
            )
          then
            helperFunction34({
              type = "color",
              object = obj,
              color = value52.Color,
              name = value52.Name,
            })
          end
          if value52.Objects then
            local counter = { 0 }
            for _, sub in ipairs(value52.Objects) do
              helperFunction37(sub, obj, counter, #value52.Objects)
            end
          end
        else
          helperFunction27("(Counter)")
          table.insert(failedItems.counters, value52)
          task.wait(0.5)
        end
      end
    end

    helperFunction24("Building Fences...", "Placing fences")
    for key22, value55 in pairs(data2.fences) do
      if localValue2 then
        break
      end
      if not helperFunction32("fences", key22) then
        while localValue3 do
          task.wait(0.1)
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceObject:InvokeServer(...)
        end, {
          StartPos = localValue22.get_world_space(localValue22.table_to_vec3(value55.From)),
          Name = value55.Name,
          Pos = localValue22.get_world_space(localValue22.table_to_vec3(value55.To)),
        })
        if result and result.Value then
          local obj = result.Value
          helperFunction27(value55.Name or "Fence")
          helperFunction31("fences", key22)
          if
            value55.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(obj),
              value55.Color
            )
          then
            helperFunction34({
              type = "color",
              object = obj,
              color = value55.Color,
              name = value55.Name,
            })
          end
          if value55.Objects then
            local counter = { 0 }
            for _, sub in ipairs(value55.Objects) do
              helperFunction37(sub, obj, counter, #value55.Objects)
            end
          end
        else
          table.insert(failedItems.fences, value55)
          helperFunction27("(Fence)")
        end
      end
    end

    helperFunction24("Building Pools...", "Placing pools")
    for key23, value58 in pairs(data2.pools) do
      if localValue2 then
        break
      end
      while localValue3 do
        task.wait(0.1)
      end
      if not helperFunction32("pools", key23) then
        local result = helperFunction26(function(...)
          return localValue5.PlacePool:InvokeServer(...)
        end, {
          ItemType = value58.Name,
          Center = localValue22.table_to_cframe(value58.Center),
          Size = Vector2.new(value58.Size.X, value58.Size.Y),
        })
        if result and result.Value then
          local obj = result.Value
          helperFunction27(value58.Name or "Pools")
          helperFunction31("pools", key23)
          if
            value58.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(obj),
              value58.Color
            )
          then
            helperFunction34({
              type = "color",
              object = obj,
              color = value58.Color,
              name = value58.Name,
            })
          end
          if value58.Objects then
            local counter = { 0 }
            for _, sub in ipairs(value58.Objects) do
              helperFunction37(sub, obj, counter, #value58.Objects)
            end
          end
        else
          table.insert(failedItems.pools, value58)
          helperFunction27("(Pools)")
        end
      end
    end

    helperFunction24("Building Objects...", "Placing objects")
    local objTotal = helperFunction30(data2.objects)
    local objCounter = { 0 }
    for index35, value61 in ipairs(data2.objects) do
      if not helperFunction32("objects", index35) then
        helperFunction38(value61, localValue126.Ground, objCounter, objTotal)
        helperFunction31("objects", index35)
      end
    end

    -- Retry phase: rebuild anything in failedItems
    local function retryFailed()
      local total = 0
      for _, v in pairs(failedItems) do
        total = total + #v
      end
      if total == 0 then
        return false
      end

      helperFunction24("RETRYING", "Fixing " .. total .. " items...")
      task.wait(1)

      -- walls
      local wallRetry = failedItems.walls
      failedItems.walls = {}
      for _, value63 in ipairs(wallRetry) do
        if localValue2 then
          break
        end
        local wallObj = helperFunction36(value63)
        if wallObj then
          localValue128[value63.id] = wallObj
          helperFunction27("Fixed Wall")
          if
            value63.LeftColor
            and not (
              value63.LeftColor.ColorNumber == 194 and value63.LeftColor.MaterialNumber == 15
            )
          then
            helperFunction34({
              type = "wall_color",
              object = wallObj,
              side = "L",
              color = value63.LeftColor,
              name = "Wall",
            })
          end
          if
            value63.RightColor
            and not (
              value63.RightColor.ColorNumber == 194 and value63.RightColor.MaterialNumber == 15
            )
          then
            helperFunction34({
              type = "wall_color",
              object = wallObj,
              side = "R",
              color = value63.RightColor,
              name = "Wall",
            })
          end
          if value63.Objects then
            local c = { 0 }
            for _, obj in ipairs(value63.Objects) do
              helperFunction37(obj, wallObj, c, #value63.Objects)
            end
          end
        else
          table.insert(failedItems.walls, value63)
        end
      end

      -- roofs
      local roofRetry = failedItems.roofs
      failedItems.roofs = {}
      for _, value66 in ipairs(roofRetry) do
        if localValue2 then
          break
        end
        local points = {}
        for _, pt in pairs(value66.Points) do
          table.insert(points, localValue22.get_world_space(localValue22.table_to_vec3(pt)))
        end
        local settings = { Type = value66.Type or "Flat Roof", IsPreview = true, RotateNum = 0 }
        for k, v in pairs(value66) do
          if type(v) == "number" then
            settings[k] = v
          end
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceRoof:InvokeServer(...)
        end, {
          Points = points,
          Start = points[#points],
          Settings = settings,
        })
        if result and result.Value then
          helperFunction27("Fixed Roof")
          if value66.Color then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value66.Color,
              name = value66.Type,
            })
          end
          if value66.Objects then
            local c = { 0 }
            for _, obj in ipairs(value66.Objects) do
              helperFunction37(obj, result.Value, c, #value66.Objects)
            end
          end
        else
          table.insert(failedItems.roofs, value66)
        end
      end

      -- floors
      local floorRetry = failedItems.floors
      failedItems.floors = {}
      for _, value70 in ipairs(floorRetry) do
        if localValue2 then
          break
        end
        local points = {}
        for _, pt in pairs(value70.Points) do
          table.insert(points, localValue22.get_world_space(localValue22.table_to_vec3(pt)))
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceFloor:InvokeServer(...)
        end, { Points = points })
        if result and result.Value then
          helperFunction27("Fixed Floor")
          if value70.Color then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value70.Color,
              name = "Floor",
            })
          end
          if value70.Objects then
            local c = { 0 }
            for _, obj in ipairs(value70.Objects) do
              helperFunction37(obj, result.Value, c, #value70.Objects)
            end
          end
        else
          table.insert(failedItems.floors, value70)
        end
      end

      -- basements
      local baseRetry = failedItems.basements
      failedItems.basements = {}
      for _, value73 in ipairs(baseRetry) do
        if localValue2 then
          break
        end
        local center = {
          ground_cf
            :ToObjectSpace(localValue22.get_load_cframe(value73.Center, localValue126))
            :components(),
        }
        center[2] = 1e-7
        if
          helperFunction26(function(...)
            return localValue5.PlaceBasement:InvokeServer(...)
          end, {
            ItemType = "Basements",
            Center = CFrame.new(unpack(center)),
            Size = Vector2.new(unpack(value73.Size)),
          })
        then
          helperFunction27("Fixed Basement")
        end
      end

      -- fences
      local fenceRetry = failedItems.fences
      failedItems.fences = {}
      for _, value74 in ipairs(fenceRetry) do
        if localValue2 then
          break
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceObject:InvokeServer(...)
        end, {
          StartPos = localValue22.get_world_space(localValue22.table_to_vec3(value74.From)),
          Name = value74.Name,
          Pos = localValue22.get_world_space(localValue22.table_to_vec3(value74.To)),
        })
        if result and result.Value then
          helperFunction27("Fixed Fence")
          if value74.Color then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value74.Color,
              name = value74.Name,
            })
          end
          if value74.Objects then
            local c = { 0 }
            for _, obj in ipairs(value74.Objects) do
              helperFunction37(obj, result.Value, c, #value74.Objects)
            end
          end
        else
          table.insert(failedItems.fences, value74)
        end
      end

      -- pools
      local poolRetry = failedItems.pools
      failedItems.pools = {}
      for _, value76 in ipairs(poolRetry) do
        if localValue2 then
          break
        end
        local result = helperFunction26(function(...)
          return localValue5.PlacePool:InvokeServer(...)
        end, {
          ItemType = value76.Name,
          Center = localValue22.table_to_cframe(value76.Center),
          Size = Vector2.new(value76.Size.X, value76.Size.Y),
        })
        if result and result.Value then
          helperFunction27("Fixed Pool")
          if value76.Color then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value76.Color,
              name = value76.Name,
            })
          end
          if value76.Objects then
            local c = { 0 }
            for _, obj in ipairs(value76.Objects) do
              helperFunction37(obj, result.Value, c, #value76.Objects)
            end
          end
        else
          table.insert(failedItems.pools, value76)
        end
      end

      -- counters
      local counterRetry = failedItems.counters
      failedItems.counters = {}
      for _, value81 in ipairs(counterRetry) do
        if localValue2 then
          break
        end
        local rot4 = helperFunction9(
          (localValue22.get_world_space(localValue22.table_to_cframe(value81.CFrame)))
        )
        local placement = {
          Name = value81.Name,
          Pos = localValue22.get_world_space(localValue22.table_to_vec3(value81.Position)),
          Rot = rot4,
          TargetModel = localValue126.Ground,
        }
        if value81.id and localValue128[value81.id] then
          placement.TargetModel = localValue128[value81.id]
        end
        if value81.Height then
          placement.Height = value81.Height
        end
        local result = helperFunction26(function(...)
          return localValue5.PlaceObject:InvokeServer(...)
        end, placement)
        if result and result.Value then
          helperFunction27("Fixed " .. value81.Name)
          if value81.Size then
            for i9 = 1, 4 do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.ResizeObject:InvokeServer(...)
                end, {
                  Object = result.Value,
                  Data = { [1] = localValue22.table_to_vec3(value81.Size) },
                })
              then
                break
              end
              task.wait(1.5)
            end
          end
          if value81.Offset then
            for i10 = 1, 4 do
              if localValue2 then
                break
              end
              while localValue3 do
                task.wait(0.1)
              end
              if
                helperFunction28(function(...)
                  return localValue5.TransformObject:InvokeServer(...)
                end, {
                  Object = result.Value,
                  Offset = localValue22.table_to_cframe(value81.Offset),
                })
              then
                break
              end
              task.wait(1.5)
            end
          end
          if
            value81.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(result.Value),
              value81.Color
            )
          then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value81.Color,
              name = value81.Name,
            })
          end
          if value81.Objects then
            local c = { 0 }
            for _, obj in ipairs(value81.Objects) do
              helperFunction37(obj, result.Value, c, #value81.Objects)
            end
          end
        else
          table.insert(failedItems.counters, value81)
        end
      end

      -- paths
      local pathRetry = failedItems.paths
      failedItems.paths = {}
      for _, value79 in ipairs(pathRetry) do
        if localValue2 then
          break
        end
        local result = helperFunction26(function(...)
          return localValue5.PlacePath:InvokeServer(...)
        end, {
          From = localValue22.get_world_space(localValue22.table_to_vec3(value79.From)),
          To = localValue22.get_world_space(localValue22.table_to_vec3(value79.To)),
        })
        if result and result.Value then
          helperFunction27("Fixed Path")
          if
            value79.Color
            and not helperFunction29(
              localValue21.color_service:GetDefaultColors(result.Value),
              value79.Color
            )
          then
            helperFunction34({
              type = "color",
              object = result.Value,
              color = value79.Color,
              name = "Path",
            })
          end
          if value79.Objects then
            local c = { 0 }
            for _, obj in ipairs(value79.Objects) do
              helperFunction37(obj, result.Value, c, #value79.Objects)
            end
          end
        else
          table.insert(failedItems.paths, value79)
        end
      end

      -- objects
      local objRetry = failedItems.objects
      failedItems.objects = {}
      local objC = { 0 }
      for _, value78 in ipairs(objRetry) do
        if localValue2 then
          break
        end
        local data3 = value78.data
        local parent2 = value78.parent
        if not parent2 or not parent2.Parent then
          parent2 = localValue126.Ground
        end
        helperFunction38(data3, parent2, objC, 1)
      end

      return true
    end

    for i11 = 1, localValue88 do
      if localValue2 then
        break
      end
      local hasFailed = false
      for _, list in pairs(failedItems) do
        if #list > 0 then
          hasFailed = true
          break
        end
      end
      if not hasFailed then
        helperFunction24(nil, "All failures resolved!")
        break
      end
      helperFunction24("RETRY PHASE " .. i11, "Fixing missing items...")
      retryFailed()
      task.wait(1)
    end

    -- Color / image queue
    local colorCount = #localValue92
    if colorCount > 0 then
      current2 = colorIndex
      localValue80 = colorCount
      localValue81 = 0
      localValue89 = tick()
      helperFunction24("SWITCHING", "Preparing Paint Phase...")
      task.wait(1.5)
    else
      helperFunction24("Painting...", "No colors to apply.")
    end

    if colorIndex >= colorCount then
      helperFunction24("Painting...", "All colors already applied.")
    else
      helperFunction24("PAINTING START", string.format("Queue: %d items", colorCount))
    end

    for i12 = colorIndex + 1, colorCount do
      if localValue2 then
        break
      end
      local task_ = localValue92[i12]
      while localValue3 do
        helperFunction24("PAUSED", "Waiting to resume painting...")
        task.wait(0.1)
      end
      current2 = i12
      localValue81 = localValue81 + 1
      local label = "Painting"
      if task_.type == "image" then
        label = "Image"
      elseif task_.name and task_.name:find("Wall") then
        label = "Wall Paint"
      end
      helperFunction24(nil, string.format("%s: %s", label, task_.name or "Item"))
      if task_.type == "wall_color" then
        helperFunction28(function(...)
          return localValue5.ColorObject:InvokeServer(...)
        end, {
          Object = task_.object,
          UseMaterials = true,
          Side = task_.side,
          Data = helperFunction25(task_.color),
        })
      elseif task_.type == "color" then
        helperFunction28(function(...)
          return localValue5.ColorObject:InvokeServer(...)
        end, {
          Object = task_.object,
          UseMaterials = true,
          Data = task_.color,
        })
      elseif task_.type == "image" then
        task.wait(1)
        helperFunction23(function(...)
          return localValue5.SetPicture:FireServer(...)
        end, {
          Object = task_.object,
          ID = task_.image,
        })
      end
      helperFunction12(nil, completedKeys2, localValue92, failedItems, current2, localValue80, i12)
    end

    local remainingFailures = 0
    for _, failures in pairs(failedItems) do
      remainingFailures = remainingFailures + #failures
    end

    if localValue2 or remainingFailures > 0 then
      helperFunction12(
        data2,
        completedKeys2,
        localValue92,
        failedItems,
        current2,
        localValue80,
        colorIndex,
        true
      )
      if localValue2 then
        helperFunction24("Cancelled", "Progress saved. Use Continue Build to resume.")
        helperFunction7(
          "Build Cancelled",
          "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
          "Progress saved. Use Continue Build to resume."
        )
      else
        local message = string.format(
          "%d items could not be placed. Progress saved for retry.",
          remainingFailures
        )
        helperFunction24("Finished with failures", message)
        helperFunction7(
          "Build Incomplete",
          "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
          message
        )
      end
    else
      helperFunction24("Complete!", "Build finished successfully")
      local okDelete, deleteError = pcall(function()
        delfile("build_progress.json")
        delfile("build_data.json")
      end)
      if not okDelete then
        warn("[BuildModule] Failed to remove completed build files: " .. tostring(deleteError))
      end
    end
    task.wait(3)
    if wereBuildUI2.Parent then
      wereBuildUI2:Destroy()
    end
    localValue2 = false
    localValue3 = false

    return
  end

  function localValue22.continue_build()
    if not isfile("build_progress.json") or not isfile("build_data.json") then
      helperFunction7(
        "Error",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "No saved build found!"
      )
      return
    end
    local localValue193 = replicatedStorage.Stats[localPlayer.Name]
    if not localValue193 or not localValue193.IsBuilding or localValue193.IsBuilding.Value == 0 then
      helperFunction7(
        "Error",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "Please enter Build Mode first!"
      )
      return
    end
    local localValue194 = tostring(localValue193.IsBuilding.Value)
    local findFirstChild2 = workspaceService.Plots:FindFirstChild(localValue194)
    if not findFirstChild2 or not findFirstChild2:FindFirstChild("Ground") then
      helperFunction7(
        "Error",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "Waiting for plot to load..."
      )
      return
    end
    local localValue195, localValue196 = pcall(function()
      return httpService:JSONDecode(readfile("build_progress.json"))
    end)
    if not localValue195 or not localValue196 then
      helperFunction7(
        "Error",
        "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
        "Save file is corrupted!"
      )
      return
    end
    helperFunction7(
      "Resume",
      "rbxthumb://type=Asset&id=119978200516532&w=420&h=420",
      "Restoring build session..."
    )
    localValue22.load_house(nil, true)
  end

  return localValue22
end
