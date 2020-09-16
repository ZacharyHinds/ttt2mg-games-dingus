-- Still broken, will fix eventually

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
end

if SERVER then
  function MINIGAME:OnActivation()
    local plys = player.GetAll()
    local iroles = INNOCENT:GetSubRoles()
    local troles = TRAITOR:GetSubRoles()
    for i = 1, #plys do
      local ply = plys[i]
      if ply:GetSubRole() == ROLE_INNOCENT then
        ply:SetRole(iroles[math.random(#iroles)])
      elseif ply:GetSubRole() == ROLE_TRAITOR then
        ply:SetRole(troles[math.random(#troles)])
      end
    end
    timer.Simple(0.5, SendFullStateUpdate)
  end

  function MINIGAME:OnDeactivation()

  end

  function MINIGAME:IsSelectable()
    return false
  end
end
