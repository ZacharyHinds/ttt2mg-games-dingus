if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Prop Hunt-ish"
    },
    desc = {
      English = "Everyone can turn into props!",
      Русский = "Каждый может превратиться в объект!"
    }
  }
end

if SERVER then
  function MINIGAME:OnActivation()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      local ply = plys[i]
      ply:GiveEquipmentWeapon("weapon_ttt_prop_disguiser")
      ply:GiveEquipmentItem("item_ttt_nopropdmg")
    end
  end

  function MINIGAME:OnDeactivation()

  end

  function MINIGAME:IsSelectable()
    if not WEPS.IsInstalled("weapon_ttt_prop_disguiser") then
      return false
    else
      return true
    end
  end
end
