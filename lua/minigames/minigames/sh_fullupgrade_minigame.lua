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
  local t_roles = {ROLE_GLUTTON, ROLE_VAMPIRE, ROLE_HITMAN, ROLE_EXECUTIONER, ROLE_MESMERIST}
  local i_roles = {ROLE_SURVIVALIST, ROLE_SPECTRE, ROLE_PHARAOH, ROLE_WRATH, ROLE_SHINIGAMI, ROLE_CLAIRVOYANT}

  function MINIGAME:OnActivation()
    local isUpgraded
    for _, ply in ipairs(player.GetAll()) do
      isUpgraded = false
      if ply:GetSubRole() == ROLE_INNOCENT then
        for k, rl in RandomPairs(i_roles) do
          if isUpgraded then continue end
          ply:SetRole(rl)
          isUpgraded = true
        end
      elseif ply:GetSubRole() == ROLE_TRAITOR then
        for k, rl in RandomPairs(t_roles) do
          if isUpgraded then continue end
          ply:SetRole(rl)
          isUpgraded = true
        end
      end
    end
    SendFullStateUpdate()
  end

  function MINIGAME:OnDeactivation()

  end
end
