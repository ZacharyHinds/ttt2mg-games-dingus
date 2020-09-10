if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {

}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Trouble in Ye Olde Traitor Towne"
    },
    desc = {
      English = "Methinks the traitor doth protest too much."
    }
  }
end

if SERVER then
  function MINIGAME:OnActivation()
    local primary_class = "weapon_huntingbow"
    local secondary_class = "weapon_ttt_shovel"
    local GetEntities = ents.GetAll()
    for i = 1, #GetEntities do
      local ent = GetEntities[i]
      if ent.Base == "weapon_tttbase" and ent.AutoSpawnable then
        ent:Remove()
      end
    end

    local GetPlayers = player.GetAll()
    for i = 1, #GetPlayers do
      local ply = GetPlayers[i]
      if not ply:Alive() or ply:IsSpec() then continue end

      local GetWeapons = ply:GetWeapons()
      for j = 1, #GetWeapons do
        local wep = GetWeapons[i]
        if not wep then continue end

        if wep.Kind == WEAPON_HEAVY or wep.Kind == WEAPON_PISTOL then
          ply:StripWeapon(wep.ClassName)
        end
        ply:Give("weapon_huntingbow")
        ply:Give(secondary_class)
        ply:GiveEquipmentItem("item_ttt_infinishoot")
      end
    end

    hook.Add("EntityFireBullets", "MinigameMedieval", function(ply, data)
      if not ply:IsPlayer() then return end
      local wep = ply:GetActiveWeapon()

      if wep.ClassName ~= primary_class and wep.ClassName ~= secondary_class then return end

      wep.inf_clip_old = wep:Clip1()
      wep:SetClip1(wep:GetMaxClip1() + 1)
    end)

    hook.Add("Think", "MinigameMedieval", function()
      local GetPlys = player.GetAll()
      for i = 1, #GetPlys do
        local ply = GetPlys[i]
        if not ply:Alive() or ply:IsSpec() then continue end
        local GetWeapons = weapons.GetList()
        for j = 1, #GetWeapons do
          local wep = GetWeapons[j]
          if wep.ClassName == "weapon_huntingbow" then
            wep:SetClip1(1)
          end
        end
      end
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("EntityFireBullets", "MinigameMedieval")
    hook.Remove("Think", "MinigameMedieval")
  end
end
