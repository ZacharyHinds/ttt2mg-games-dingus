if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"


if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Amnesia"
    },
    desc = {
      English = "One Detective, One Traitor, One Serialkiller, everyone else is an Amnesiac!"
    }
  }
else
end

if SERVER then
  function MINIGAME:OnActivation()
    local isSet1 = false
    local isSet2 = false
    local isSet3 = false

    for _, ply in RandomPairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end

      if not isSet1 then
        ply:SetRole(ROLE_DETECTIVE, TEAM_INNOCENT)
        isSet1 = true
      elseif not isSet2 then
        ply:SetRole(ROLE_TRAITOR, TEAM_TRAITOR)
        isSet2 = true
      elseif not isSet3 then
        ply:SetRole(ROLE_SERIALKILLER, TEAM_SERIALKILLER)
        isSet2 = true
      else
        ply:SetRole(ROLE_AMNESIAC, TEAM_NONE)
      end
    end
    SendFullStateUpdate()
  end

  function MINIGAME:OnDeactivation()

  end
end
