---@source Тһіѕ Fіlе Wаѕ Dеobfuѕcаtеd Ву LеаκD
---@see https://discord.gg/AwGHNh7Z7T

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
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

local function helperFunction1(parameter1, parameter2)
  local localValue9 = parameter2 or 10
  humanoid:MoveTo(parameter1)
  local localValue10 = tick()

  while tick() - localValue10 < localValue9 do
    if (humanoidRootPart.Position - parameter1).Magnitude < 6 then
      return true
    end

    task.wait(0.1)
  end

  humanoid:MoveTo(humanoidRootPart.Position)
  return false
end

local function helperFunction2(parameter3, parameter4, parameter5)
  if not parameter3 or not parameter4 then
    return
  else
    parameter3:SetAttribute("TaskID", -1)
    local localValue11 = ""

    if parameter5 == 1 then
      localValue11 = "_resetDisciplineNPC"
    elseif parameter5 == 2 then
      localValue11 = "_resetHallPassNPC"
    elseif parameter5 == 3 then
      localValue11 = "_resetLectureNPC"
    end

    if localValue11 ~= "" then
      for key, value in pairs(getgc()) do
        local localValue12 = value

        if type(localValue12) == "function" and islclosure(localValue12) then
          local localValue13 = debug.getinfo(localValue12)

          if localValue13.name == localValue11 then
            if localValue13.source and not string.find(localValue13.source, "StarterPlayer") then
              pcall(function()
                localValue12(parameter4, true)
              end)
              break
            end
          end
        end
      end
    end

    task.delay(1.5, function()
      if parameter4 then
        local thoughtBubble = parameter4:FindFirstChild("ThoughtBubble")

        if thoughtBubble then
          thoughtBubble:Destroy()
        end

        local highlight = parameter4:FindFirstChild("Highlight")

        if highlight then
          highlight:Destroy()
        end
      end
    end)

    return
  end
end

local localValue14 = false
local desks, hallPassStation

local function helperFunction3()
  while localValue14 do
    local localValue15 = false

    for index, value2 in ipairs(desks:GetChildren()) do
      if not localValue14 then
        break
      else
        local npc = value2:FindFirstChild("NPC")

        if npc and npc:IsA("Model") then
          local thoughtBubble2 = npc:FindFirstChild("ThoughtBubble")

          if thoughtBubble2 then
            local frame = thoughtBubble2:FindFirstChild("Frame")

            local bubbleContent = frame
            bubbleContent = frame and frame:FindFirstChild("BubbleContent")

            local icon = bubbleContent
            icon = bubbleContent and bubbleContent:FindFirstChild("Icon")

            local gsub = (icon and icon:IsA("ImageLabel") and icon.Image or "No icon"):gsub(
              "%s",
              ""
            )

            local id = value2:GetAttribute("ID")

            if gsub == "rbxassetid://92657801962714" then
              local humanoidRootPart2 = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart

              if humanoidRootPart2 then
                local vector = Vector3.new(0, 0, 3)
                local localValue16 = helperFunction1(humanoidRootPart2.Position + vector, 5)
                task.wait(0.8)

                if localValue16 then
                  if
                    localValue1.TeacherJob_TaskComplete:InvokeServer({
                      Type = "TeacherJob_TaskComplete",
                      TaskID = 1,
                      DeskID = id,
                    })
                  then
                    print("    [+] Discipline task succeeded with Desk " .. value2.Name)
                    helperFunction2(value2, npc, 1)
                  else
                    print("    [-] Discipline task failed.")
                  end
                end
              end

              localValue15 = true
              break
            elseif gsub == "rbxassetid://136049495033846" then
              if
                helperFunction1(
                  hallPassStation.PrimaryPart and hallPassStation.PrimaryPart.Position
                    or Vector3.new(1005.96, 47.45, -254.51),
                  5
                )
              then
                print("    [!] Getting Hall Pass...")

                localValue1.TeacherJob_GetHallPass:InvokeServer({
                  Type = "TeacherJob_GetHallPass",
                  StationID = hallPassStation:GetAttribute("ID"),
                })

                task.wait(1)

                local humanoidRootPart3 = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart

                if humanoidRootPart3 then
                  if helperFunction1(humanoidRootPart3.Position + Vector3.new(0, 0, 3), 5) then
                    if
                      localValue1.TeacherJob_TaskComplete:InvokeServer({
                        Type = "TeacherJob_TaskComplete",
                        TaskID = 2,
                        DeskID = id,
                      })
                    then
                      print("    [+] Hall Pass given successfully!")
                      helperFunction2(value2, npc, 2)
                    else
                      print("    [-] Failed to complete Hall Pass task.")
                    end
                  end
                end
              end

              localValue15 = true
              task.wait(0.5)
              break
            elseif gsub == "rbxassetid://108171987503150" then
              local humanoidRootPart4 = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart

              if humanoidRootPart4 then
                if helperFunction1(humanoidRootPart4.Position + Vector3.new(0, 0, 3), 5) then
                  print("    [!] Starting Lecture...")

                  if
                    localValue1.TeacherJob_StartLectureStudent:InvokeServer({
                      Type = "TeacherJob_StartLectureStudent",
                      DeskID = id,
                      TaskID = 3,
                    })
                  then
                    if
                      helperFunction1(
                        Vector3.new(996.55584716797, 47.305213928223, -237.47451782227)
                          + Vector3.new(0, 0, 3.5),
                        5
                      )
                    then
                      print("    [!] Using Board...")

                      localValue1.TeacherJob_UseBoard:InvokeServer({
                        Type = "TeacherJob_UseBoard",
                        DeskID = id,
                        TaskID = 3,
                      })

                      task.wait(2)

                      local invokeServer = localValue1.TeacherJob_TaskComplete:InvokeServer({
                        Type = "TeacherJob_TaskComplete",
                        DeskID = id,
                        TaskID = 3,
                      })

                      humanoid.Jump = true

                      if invokeServer then
                        print("    [+] Lecture task succeeded!")
                        helperFunction2(value2, npc, 3)
                      else
                        print("    [-] Lecture task failed at completion.")
                      end
                    end
                  else
                    print("    [-] Failed to start lecture with student.")
                  end
                end
              end

              localValue15 = true
              break
            end
          end
        end

        task.wait(0.5)
      end
    end

    if not localValue14 then
      break
    elseif not localValue15 then
      task.wait(2)
    else
      task.wait(1)
    end
  end

  print("AutoFarm stopped.")
end

local localValue17 = {}

function GoToWork(parameter6, name)
  local humanoidRootPart5 = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild(
    "HumanoidRootPart"
  )

  if not parameter6 then
    return
  end

  if (humanoidRootPart5.Position - parameter6).Magnitude >= 100 then
    localValue1.ToWork:InvokeServer({ Name = name })
  end
end

local localValue18

function localValue17.startAutoFarm()
  if localValue14 then
    warn("AutoFarm is already running!")
    return
  else
    GoToWork(Vector3.new(999.67077636719, 47.191165924072, -251.87297058105), "HighSchoolTeacher")

    print(" Loading Desks, Hall Pass Station, and Board directly...")
    local gameplay = workspace
      :WaitForChild("Environment")
      :WaitForChild("Locations")
      :WaitForChild("SchoolArea")
      :WaitForChild("School")
      :WaitForChild("Interior")
      :WaitForChild("Floor2")
      :WaitForChild("Teacher1")
      :WaitForChild("Interior")
      :WaitForChild("Gameplay")
    desks = gameplay:WaitForChild("Desks")
    hallPassStation = gameplay:WaitForChild("Hall Pass Stations"):WaitForChild("Hall Pass Station")
    gameplay:WaitForChild("Board")
    localValue14 = true
    localValue18 = coroutine.create(helperFunction3)
    coroutine.resume(localValue18)
    print("AutoFarm started.")
    return
  end
end

function localValue17.stopAutoFarm()
  if not localValue14 then
    warn("AutoFarm is not running or already stopped.")
    return
  end

  localValue14 = false
  print("Stopping AutoFarm...")
end

return localValue17
