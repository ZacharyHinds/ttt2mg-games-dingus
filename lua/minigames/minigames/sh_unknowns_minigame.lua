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
    desc = "ttt2_minigames_unknowns_dethealth (Def. 120)"
  },

  ttt2_minigames_unknowns_detarmor = {
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_minigames_unknowns_detarmor (Def. 30)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Error Unknown"
      Русский = "Ошибка неизвестна"
    },
    desc = {
      English = "One Detective, One Traitor, everyone else is Unknown!"
      Русский = "Один детектив, один предатель, все остальные неизвестны!"
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

  function MINIGAME:IsSelectable()
    if not UNKNOWN then
      return false
    else
      return true
    end
  end
end
