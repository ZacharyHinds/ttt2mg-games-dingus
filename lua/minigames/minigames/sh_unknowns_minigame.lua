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
end

if SERVER then
  local ttt2_minigames_unknowns_dethealth = CreateConVar("ttt2_minigames_unknowns_dethealth", "120", {FCVAR_ARCHIVE}, "How much health the detective has")
  local ttt2_minigames_unknowns_detarmor = CreateConVar("ttt2_minigames_unknowns_detarmor", "30", {FCVAR_ARCHIVE}, "How much armor the detective has")
  function MINIGAME:OnActivation()
    local isSet1 = false
    local isSet2 = false
    local plys = util.GetAlivePlayers()
    local ply
    repeat
      if #plys <= 0 then return end
      local rnd = math.random(#plys)
      ply = plys[ply]
      table.remove(plys, rnd)
    until IsValid(ply)
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
    SendFullStateUpdate()
  end

  function MINIGAME:OnDeactivation()

  end
end
