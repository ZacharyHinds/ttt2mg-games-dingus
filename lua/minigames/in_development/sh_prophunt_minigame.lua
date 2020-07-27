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
      English = "Everyone can turn into props!"
    }
  }
else
end

if SERVER then
  function MINIGAME:OnActivation()
    for _, ply in ipairs(player.GetAll()) do
      ply:GiveEquipmentWeapon("weapon_ttt_prophide")
      ply:GiveEquipmentItem("item_ttt_nopropdmg")
    end
  end

  function MINIGAME:OnDeactivation()

  end
end
