if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_unknowns_dethealth = {
    slider = true,
    min = 100,
    max = 200,
    desc = "(Def. 120)"
  },

  ttt2_minigames_unknowns_detarmor = {
    slider = true,
    min = 0,
    max = 100,
    desc = "(Def. 30)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Error Unknown"
    },
    desc = {
      English = "One Detective, One Traitor, everyone else is Unknown!"
    }
  }
else
  ttt2_minigames_unknowns_dethealth = CreateConVar("ttt2_minigames_unknowns_dethealth", "120", {FCVAR_ARCHIVE}, "How much health the detective has")
  ttt2_minigames_unknowns_detarmor = CreateConVar("ttt2_minigames_unknowns_detarmor", "30", {FCVAR_ARCHIVE}, "How much armor the detective has")
end

if SERVER then
  function MINIGAME:OnActivation()
    local isSet1 = false
    local isSet2 = false

    for _, ply in RandomPairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end

      if not isSet1 then
        ply:SetRole(ROLE_DETECTIVE, TEAM_INNOCENT)
        ply:SetDefaultCredits()
        ply:SetMaxHealth(ttt2_minigames_unknowns_dethealth:GetInt())
        ply:SetHealth(ttt2_minigames_unknowns_dethealth:GetInt())
        ply:GiveArmor(ttt2_minigames_unknowns_detarmor:GetInt())
        isSet1 = true
      elseif not isSet2 then
        ply:SetRole(ROLE_TRAITOR, TEAM_TRAITOR)
        ply:SetDefaultCredits()
        isSet2 = true
      else
        ply:SetRole(ROLE_UNKNOWN, TEAM_NONE)
      end
    end
    SendFullStateUpdate()
  end

  function MINIGAME:OnDeactivation()

  end
end
