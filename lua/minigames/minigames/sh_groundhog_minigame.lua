if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_groundhog_timer = {
    slider = true,
    min = 1,
    max = 240,
    desc = "ttt2_minigames_groundhog_timer (Def. 60)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Groundhog Day"
    },
    desc = {
      English = "Whew! Watch out for that first step. It's a doozy!"
    }
  }
else
  util.AddNetworkString("groundhog_popup")
end

if SERVER then
  local ttt2_minigames_groundhog_timer = CreateConVar("ttt2_minigames_groundhog_timer", "60", {FCVAR_ARCHIVE}, "Time between teleports")

  function MINIGAME:OnActivation()
    timer.Create("GroundhogMinigameTimer", ttt2_minigames_groundhog_timer:GetInt(), 0, function()
      local plys = util.GetAlivePlayers()
      for i = 1, #plys do
        local ply
        repeat
          if #plys <= 0 then return end
          local rnd = math.random(#plys)
          ply = plys[rnd]
          table.remove(plys, rnd)
        until IsValid(ply)

        local spawnpoint = spawn.GetRandomPlayerSpawnEntity(ply)
        ply:SetPos(spawnpoint:GetPos())
        net.Start("groundhog_popup")
        net.Send(ply)
        -- ply:SetDefaultCredits()
      end
    end)
  end

  function MINIGAME:OnDeactivation()
    timer.Remove("GroundhogMinigameTimer")
  end
end
if CLIENT then
  net.Receive("groundhog_popup", function()
    EPOP:AddMessage({
        text = LANG.TryTranslation("tt2mg_groundhog_epop"),
        color = COLOR_ORANGE
      },
      LANG.TryTranslation("tt2mg_groundhog_epop_desc"),
      5,
      nil,
      true
    )
  end)
end
