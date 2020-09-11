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
    desc = "(Def. 30)"
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
      for _, ply in RandomPairs(player.GetAll()) do
        if not ply:Alive() or ply:IsSpec() then continue end

        local spawnpoint = spawn.GetRandomPlayerSpawnEntity(ply)

        ply:SetPos(spawnpoint:GetPos())
        net.Send("groundhog_popup")
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
        text = "Again!"
      },
      "Okay, campers, rise and shine and don't forget your booties 'cause it's cold out there today!",
      5
    )
  end)
end
