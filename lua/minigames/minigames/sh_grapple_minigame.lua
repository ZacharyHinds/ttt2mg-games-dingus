if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Spider-terrorists!"
    },
    desc = {
      English = "Does whatever a spider can!"
    }
  }
else
end

if SERVER then
  function MINIGAME:OnActivation()
    for _, ply in ipairs(player.GetAll()) do
      ply:GiveEquipmentWeapon("grapplehook")
      ply:GiveEquipmentItem("item_ttt_climb")
    end
  end

  function MINIGAME:OnDeactivation()

  end
end
