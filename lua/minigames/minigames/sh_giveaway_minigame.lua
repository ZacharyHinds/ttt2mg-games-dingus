if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Sweepstakes Giveaway"
    },
    desc = {
      English = "You've all won a prize!"
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
      if wep and wep.CanBuy then
        give_weps[#give_weps + 1] = wep
      end
    end
    local item
    local is_item
    local swep_table
    repeat
      if #weps <= 0 then return end
      local rnd = math.random(#give_weps)
      item = give_weps[rnd]
      is_item = tonumber(item.id)
      swep_table = (not is_item) and weapons.GetStored(item.ClassName) or nil
      table.remove(give_weps, rnd)
    until IsValid(item) and (is_item or swep_table)
    local print_name = LANG.TryTranslation(item:GetPrintName()) or item.PrintName or WEPS.GetClass(item)

    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      local ply = plys[i]
      if not IsValid(ply) then continue end
      if is_item then
        ply:GiveEquipmentItem(is_item)
      elseif swep_table then
        ply:GiveEquipmentWeapon(swep_table)
      end
    end
    net.Start("ttt2mg_giveaway")
    net.WriteString(print_name)
    net.Broadcast()
  end

  function MINIGAME:OnDeactivation()

  end
end
if CLIENT then
  net.Receive("ttt2mg_giveaway", function()
    local wep_name = net.ReadString()
    EPOP:AddMessage({
      text = "Today's Giveaway is..."},
      "",
    3)
    EPOP:AddMessage({
      text = wep_name},
      "",
    2)
  end)
end
