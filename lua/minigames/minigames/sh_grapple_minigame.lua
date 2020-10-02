if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Spider-terrorists!",
      Русский = "Террористы-пауки!"
    },
    desc = {
      English = "Does whatever a spider can!",
      Русский = "Делает всё, что может паук!"
    }
  }
end

if SERVER then
  function MINIGAME:OnActivation()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      local ply = plys[i]
      ply:GiveEquipmentWeapon("grapplehook")
      ply:GiveEquipmentItem("item_ttt_climb")
    end
  end

  function MINIGAME:OnDeactivation()

  end

  function MINIGAME:IsSelectable()
    if not WEPS.IsInstalled("grapplehook") or not items.GetStored("item_ttt_climb") then
      return false
    else
      return true
    end
  end
end
