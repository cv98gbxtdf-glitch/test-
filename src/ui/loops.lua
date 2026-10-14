-- Background loops + post-tab bootstrap.
--
-- Everything that fires once per N seconds (webhook stats poster, auth session
-- refresh, player/plot dropdown refresh), the per-build-session file reads
-- the UI needs on launch, SaveManager's autoload step, the UI "quiet"
-- transition, and the final __namecall hook all live here. It's a clean
-- boundary because none of this code touches the Obsidian window; it only
-- reads/writes shared state the tabs already set up.

return function(env)
  local ctx = env.ctx
  local httpService = env.httpService
  local replicatedStorage = env.replicatedStorage
  local localPlayer = env.localPlayer
  local SaveManager = env.SaveManager
  local flags = env.flags -- { running, uiQuiet }
  local cfg = env.cfg -- the shared config table (was localValue6)
  local dropdowns = env.dropdowns -- { players, build, stats }
  local auth = env.auth -- auth stub (the legacy table)
  local keyRef = env.keyRef -- the io_r() string

  local notify = env.helpers.notify
  local listPlayers = env.helpers.listPlayers
  local listPlotPlayers = env.helpers.listPlotPlayers
  local pollMood = env.helpers.pollMood

  -- Seed the webhook config from disk if the user previously saved one.
  pcall(function()
    local jsonDecode3 = httpService:JSONDecode(readfile("WereToolsWebhook.txt"))
    cfg.WebhookURL = jsonDecode3.url
    cfg.PingID = jsonDecode3.ping
  end)

  -- Webhook stats sender. Fires when `flags.webhookEnabled` is on and the
  -- shift earnings number changes; throttled to one post per 15 s.
  task.spawn(function()
    local lastSendAt = 0
    local lastEarnings = -1

    while flags.running do
      task.wait(5)
      if flags.webhookEnabled then
        pcall(function()
          if tick() - lastSendAt < 15 then
            return
          end
          local statsFolder = replicatedStorage:FindFirstChild("Stats")
          if statsFolder and statsFolder:FindFirstChild(localPlayer.Name) then
            local playerStats = statsFolder[localPlayer.Name]
            local job = playerStats:FindFirstChild("Job")
            if not job then
              return
            end
            local jobName = job.Value or "None"
            local shiftEarnings = (job:FindFirstChild("ShiftEarnings") and job.ShiftEarnings.Value)
              or 0
            local efficiency = (job:FindFirstChild("Efficiency") and job.Efficiency.Value) or 0
            local money = playerStats:FindFirstChild("Money")
            local blockbux = playerStats:FindFirstChild("Blockbux")
            local moneyValue = (money and money.Value) or 0
            local blockbuxValue = (blockbux and blockbux.Value) or 0
            local overall, energy, fun, hunger, hygiene = pollMood()
            local sessionPay = 0
            if money and 0 then
              sessionPay = moneyValue - 0
              if sessionPay < 0 then
                sessionPay = 0
              end
            end
            if shiftEarnings > 0 and shiftEarnings ~= lastEarnings then
              lastSendAt = tick()
              lastEarnings = shiftEarnings
              local executorRequest = ctx.http:executorRequest()
              if executorRequest and cfg.WebhookURL ~= "" then
                local payload = {
                  content = (cfg.PingID and cfg.PingID ~= "") and cfg.PingID or "",
                  username = "Were Tools WebHook",
                  avatar_url = "https://imagizer.imageshack.com/img924/3550/syF2Vn.png",
                  embeds = {
                    {
                      title = "Were Tools Stats",
                      color = 1752220,
                      fields = {
                        { name = "Current Job", value = tostring(jobName), inline = true },
                        {
                          name = "Shift Earnings",
                          value = "$" .. tostring(shiftEarnings),
                          inline = true,
                        },
                        {
                          name = "Efficiency",
                          value = tostring(efficiency) .. "%",
                          inline = true,
                        },
                        {
                          name = "Total Pay (Session)",
                          value = "$" .. tostring(sessionPay),
                          inline = true,
                        },
                        { name = "Money", value = "$" .. tostring(moneyValue), inline = true },
                        {
                          name = "Blockbux",
                          value = tostring(blockbuxValue),
                          inline = true,
                        },
                        {
                          name = "----- MOOD DATA -----",
                          value = "**MOOD DATA**",
                          inline = false,
                        },
                        { name = "Overall", value = tostring(overall) .. "%", inline = true },
                        { name = "Energy", value = tostring(energy) .. "%", inline = true },
                        { name = "Fun", value = tostring(fun) .. "%", inline = true },
                        { name = "Hunger", value = tostring(hunger) .. "%", inline = true },
                        { name = "Hygiene", value = tostring(hygiene) .. "%", inline = true },
                      },
                      timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                    },
                  },
                }
                executorRequest({
                  Url = cfg.WebhookURL,
                  Method = "POST",
                  Headers = { ["Content-Type"] = "application/json" },
                  Body = httpService:JSONEncode(payload),
                })
              end
            end
          end
        end)
      end
    end
  end)

  -- Auth session refresh. Executor keeps the licence stub happy; a real
  -- backend would rotate the token on this cadence.
  task.spawn(function()
    while flags.running do
      task.wait(600)
      if keyRef == "" then
        break
      end
      auth._req_01(keyRef, auth._sys_id(), function(ok, response)
        if ok and auth._sec_02(response._validationProof) then
          ctx.auth:setSessionToken(response.session_token)
        else
          auth._io_d()
        end
      end)
    end
  end)

  -- Player / plot dropdown refresh. New joins and plot ownership changes
  -- show up in the UI within 30 s.
  task.spawn(function()
    while flags.running do
      task.wait(30)
      pcall(function()
        local playerNames = listPlayers()
        local plotPlayers = listPlotPlayers()
        if dropdowns.players and dropdowns.players.SetValues then
          dropdowns.players:SetValues(playerNames)
        end
        if dropdowns.stats and dropdowns.stats.SetValues then
          dropdowns.stats:SetValues(playerNames)
        end
        if dropdowns.build and dropdowns.build.SetValues then
          dropdowns.build:SetValues(plotPlayers)
        end
      end)
    end
  end)

  -- Seed AutoHop config from disk.
  pcall(function()
    local jsonDecode4 = httpService:JSONDecode(readfile("WereTools_AutoHop.json"))
    if jsonDecode4 then
      cfg.HouseFinderValue = tostring(jsonDecode4.value or "0")
      cfg.HopDelay = tostring(jsonDecode4.HopDelay or "15")
    end
  end)

  SaveManager:LoadAutoloadConfig()

  task.wait(0.5)
  flags.uiQuiet = false

  -- Server-sent LookDir packets confuse the autofarm; drop them before they
  -- hit the queue. Chained so a prior hook still runs.
  local prevNamecall
  prevNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local firstArg = ...
    if not checkcaller() and method == "FireServer" then
      if type(firstArg) == "table" and firstArg.Type == "LookDir" then
        return
      end
    end
    return prevNamecall(self, ...)
  end)
  -- Silence "unused" warnings while leaving the hook installed.
  local _ = prevNamecall

  _ = notify -- reserved for future heartbeat notifications
end
