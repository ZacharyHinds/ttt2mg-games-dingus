if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_amnesia_dethealth = {
    slider = true,
    min = 100,
    max = 200,
    desc = "ttt2_minigames_amnesia_dethealth (Def. 150)"
  },

  ttt2_minigames_amnesia_detarmor = {
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_minigames_amnesia_detarmor (Def. 30)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Amnesia"
      Русский = "Амнезия"
    },
    desc = {
      English = "One Detective, One Traitor, One Serialkiller, everyone else is an Amnesiac!"
      Русский = "Один детектив, один предатель, один серийный убийца, все остальные - больные амнезией!"
    }
  }
end

if SERVER then
  local ttt2_minigames_amnesia_dethealth = CreateConVar("ttt2_minigames_amnesia_dethealth", "150", {FCVAR_ARCHIVE}, "How much health the detective has")
  local ttt2_minigames_amnesia_detarmor = CreateConVar("ttt2_minigames_amnesia_detarmor", "30", {FCVAR_ARCHIVE}, "How much armor the detective has")
  function MINIGAME:OnActivation()
    local isSet1 = false
    local isSet2 = false
    local isSet3 = false
    local plys = util.GetAlivePlayers()

    for i = 1, #plys do
      local ply
      repeat
        if #plys <= 0 then return end
        local rnd = math.random(#plys)
        ply = plys[rnd]
        table.remove(plys, rnd)
      until IsValid(ply)
      if not isSet1 then
        ply:SetRole(ROLE_DETECTIVE, TEAM_INNOCENT)
        ply:SetMaxHealth(ttt2_minigames_amnesia_dethealth:GetInt())
        ply:SetHealth(ttt2_minigames_amnesia_dethealth:GetInt())
        ply:GiveArmor(ttt2_minigames_amnesia_detarmor:GetInt())
        isSet1 = true
      elseif not isSet2 then
        ply:SetRole(ROLE_TRAITOR, TEAM_TRAITOR)
        isSet2 = true
      elseif not isSet3 then
        ply:SetRole(ROLE_SERIALKILLER, TEAM_SERIALKILLER)
        isSet3 = true
      else
        ply:SetRole(ROLE_AMNESIAC, TEAM_NONE)
      end
    end
    SendFullStateUpdate()
  end

  function MINIGAME:OnDeactivation()

  end

  function MINIGAME:IsSelectable()
    if not AMNESIAC and SERIALKILLER then
      return false
    else
      return true
    end
  end
end
