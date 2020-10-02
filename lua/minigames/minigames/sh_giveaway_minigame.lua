if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Sweepstakes Giveaway",
      Русский = "Тотализаторный розыгрыш"
    },
    desc = {
      English = "You've all won a prize!",
      Русский = "Вы все выиграете приз!"
    }
  }
end

if SERVER then
  util.AddNetworkString("ttt2mg_giveaway")

  function MINIGAME:OnActivation()
    local weps = weapons.GetList()
    local give_weps = {}
    for i = 1, #weps do
      local wep = weps[i]
      if wep and (wep.CanBuy and #wep.CanBuy > 0) then
        give_weps[#give_weps + 1] = wep
        -- print("[Giveaway Minigame] Added Potential Prize: " .. (give_weps[#give_weps].PrintName or WEPS.GetClass(give_weps[#give_weps])))
      end
    end
    local item = give_weps[math.random(#give_weps)]
    -- local is_item = tonumber(item.id)
    -- local swep_table = (not is_item) and weapons.GetStored(item.ClassName) or nil
    local print_name = item.PrintName or WEPS.GetClass(item)


    timer.Simple(12, function()
      local plys = util.GetAlivePlayers()
      for i = 1, #plys do
        local ply = plys[i]
        if not IsValid(ply) then continue end
        ply:Give(WEPS.GetClass(item))
        -- if is_item then
        --   ply:GiveEquipmentItem(is_item)
        -- elseif swep_table then
        --   ply:GiveEquipmentWeapon(swep_table)
        -- end
      end
      net.Start("ttt2mg_giveaway")
      net.WriteString(print_name)
      net.Broadcast()
    end)
  end

  function MINIGAME:OnDeactivation()

  end
end
if CLIENT then
  net.Receive("ttt2mg_giveaway", function()
    local wep_name = net.ReadString()
    wep_name = LANG.TryTranslation(wep_name) or wep_name
    EPOP:AddMessage({
        text = LANG.TryTranslation("ttt2mg_giveaway_epop"),
        color = COLOR_ORANGE
    },
      nil,
      3,
      nil,
      true
    )
    timer.Simple(3, function()
      EPOP:AddMessage({
        text = wep_name,
        color = COLOR_ORANGE
      },
        nil,
        2,
        nil,
        true
      )
    end)
  end)
end
