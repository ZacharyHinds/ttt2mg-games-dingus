if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_wobbly_max_grav = {
    slider = true,
    min = -1,
    max = 5,
    decimal = 1,
    desc = "ttt2_minigames_wobbly_max_grav (Def. 2.0)"
  },
  ttt2_minigames_wobbly_min_grav = {
    slider = true,
    min = -1,
    max = 5,
    decimal = 1,
    desc = "ttt2_minigames_wobbly_min_grav (Def. 0.1)"
  },
  ttt2_minigames_wobbly_max_speed = {
    slider = true,
    min = -100,
    max = 100,
    decimal = 0,
    desc = "ttt2_minigames_wobbly_max_speed (Def. 50)"
  },
  ttt2_minigames_wobbly_min_speed = {
    slider = true,
    min = -100,
    max = 100,
    decimal = 0,
    desc = "ttt2_minigames_wobbly_min_speed (Def. -50)"
  },
  ttt2_minigames_wobbly_universal_grav = {
    checkbox = true,
    desc = "ttt2_minigames_wobbly_universal_grav (Def. 1)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Temporal Flux"
      Русский = "Временной поток"
    },
    desc = {
      English = ""
    }
  }
else
  ttt2_minigames_wobbly_max_grav = CreateConVar("ttt2_minigames_wobbly_max_grav", "2.0", {FCVAR_ARCHIVE}, "Maximum Gravity")
  ttt2_minigames_wobbly_min_grav = CreateConVar("ttt2_minigames_wobbly_min_grav", "0.1", {FCVAR_ARCHIVE}, "Minimum Gravity")
  ttt2_minigames_wobbly_max_speed = CreateConVar("ttt2_minigames_wobbly_max_speed", "-50", {FCVAR_ARCHIVE}, "Maximum Speed")
  ttt2_minigames_wobbly_min_speed = CreateConVar("ttt2_minigames_wobbly_min_speed", "50", {FCVAR_ARCHIVE}, "Minimum Speed")
  ttt2_minigames_wobbly_universal_grav = CreateConVar("ttt2_minigames_wobbly_universal_grav", "1", {FCVAR_ARCHIVE}, "Should the gravity be the same for everyone")
  util.AddNetworkString("ttt2mg_wobbly_popup")
end

if SERVER then
  function randFloat(lower, greater)
    return lower + math.random() * (greater - lower)
  end

  function MINIGAME:OnActivation()
    timer.Create("WobblyMinigame", 15, 0, function()
      local GetPlayers = player.GetAll()
      local gravity = randFloat(ttt2_minigames_wobbly_min_grav:GetFloat(), ttt2_minigames_wobbly_max_grav:GetFloat())
      for i = 1, #GetPlayers do
        local ply = GetPlayers[i]
        if not ply:Alive() or ply:IsSpec() then continue end

        if not ttt2_minigames_wobbly_universal_grav:GetBool() then
          gravity = randFloat(ttt2_minigames_wobbly_min_grav:GetFloat(), ttt2_minigames_wobbly_max_grav:GetFloat())
        end

        ply:SetGravity(gravity)
      end

      game.SetTimeScale(1)
      local timescale = game.GetTimeScale()
      local modifier = math.random(ttt2_minigames_wobbly_max_speed:GetInt(), ttt2_minigames_wobbly_min_speed:GetInt())
      game.SetTimeScale(timescale + modifier / 100)

      net.Start("ttt2mg_wobbly_popup")
      net.Broadcast()
    end)
  end

  function MINIGAME:OnDeactivation()
    timer.Remove("WobblyMinigame")
    game.SetTimeScale(1)
  end
end

if CLIENT then
  net.Receive("ttt2mg_wobbly_popup", function()
    EPOP:AddMessage({
        text = "Time-Space Anomaly Detected!",
        color = COLOR_ORANGE
    },
      "Gravity and Time Warp Imminent",
      4,
      nil,
      true
    )
  end)
end
