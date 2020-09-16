if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Trouble in Ye Olde Terrorist Towne"
    },
    desc = {
      English = ""
    }
  }
end

if SERVER then
  function MINIGAME:OnActivation()
    local ents = ents.GetAll()

    for i = 1, #ents do
      local ent = ents[i]
      if ent.Base == "weapon_tttbase" and ent.AutoSpawnable then
        ent:Remove()
      end
    end
    local plys = util.GetAlivePlayers()
    local wep
    for i = 1, #plys do
      local ply = plys[i]
      local weps = ply:GetWeapons()
      for j = 1, #weps do
        wep = weps[j]
        if wep.Kind == WEAPON_HEAVY or wep.Kind == WEAPON_PISTOL then
          ply:StripWeapon(wep:GetClass())
        end
      end
      ply:GiveEquipmentWeapon("weapon_ttt_mg_bow")
      ply:GiveEquipmentWeapon("weapon_ttt_shovel")
    end
  end

  function MINIGAME:OnDeactivation()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      plys[i]:StripWeapon("weapon_ttt_mg_bow")
    end
  end

  function MINIGAME:IsSelectable()
    if not WEPS.IsInstalled("weapon_ttt_shovel") or not WEPS.IsInstalled("weapon_huntingbow") then return false end
  end
end
