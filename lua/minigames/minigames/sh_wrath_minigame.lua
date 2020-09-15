if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Karmic Wrath"
    },
    desc = {
      English = "You shall pay for your transgressions"
    }
  }
end

if SERVER then
  local karma_max = GetConVar("ttt_karma_max"):GetInt()
  function MINIGAME:OnActivation()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      local ply = plys[i]
      local ply_karma = ply:GetLiveKarma()
      if ply_karma >= karma_max then continue end

      local dmginfo = DamageInfo()
      dmginfo:SetDamage(100 - (100 * (ply_karma / karma_max)))
      dmginfo:SetAttacker(game.GetWorld())
      dmginfo:SetInflictor(game.GetWorld())
      ply:TakeDamageInfo(dmginfo)
    end
  end

  function MINIGAME:OnDeactivation()

  end

  function MINIGAME:IsSelectable()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      if plys[i]:GetLiveKarma() < karma_max then
        return true
      end
    end
    return false
  end
end
