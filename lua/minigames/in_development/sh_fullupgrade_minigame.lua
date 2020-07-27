if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Full Upgrade"
    },
    desc = {
      English = "Boredom for noone!"
    }
  }
else

end

if SERVER then
  function TraitorRoles()
    local roleData = roles.GetByIndex(ROLE_TRAITOR)

    return roleData:GetSubRoles()
  end

  function InnocentRoles()
    local roleData = roles.GetByIndex(ROLE_INNOCENT)

    return roleData:GetSubRoles()
  end

  function MINIGAME:OnActivation()
    local isUpgraded
    for _, ply in ipairs(player.GetAll()) do
      isUpgraded = false
      if ply:GetSubRole() == ROLE_INNOCENT then
        for k, rl in RandomPairs(InnocentRoles()) do
          if isUpgraded then continue end
          ply:SetRole(rl)
          isUpgraded = true
          SendFullStateUpdate()
        end
      elseif ply:GetSubRole() == ROLE_TRAITOR then
        for k, rl in RandomPairs(TraitorRoles()) do
          if isUpgraded then continue end
          ply:SetRole(rl)
          isUpgraded = true
          SendFullStateUpdate()
        end
      end
    end
  end

  function MINIGAME:OnDeactivation()

  end
end
