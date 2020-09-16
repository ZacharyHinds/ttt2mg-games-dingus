if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_antikarma_max_dmg = {
    slider = true,
    min = 0,
    max = 200,
    desc = "(Def. 75)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Anti-Karma"
    },
    desc = {
      English = "Nice guys finish last..."
    }
  }
end

if SERVER then
  CreateConVar("ttt2_minigames_antikarma_max_dmg", "75", {FCVAR_ARCHIVE}, "Maximum damage dealt at full karma")
  function MINIGAME:OnActivation()
    local karma_max = GetConVar("ttt_karma_max"):GetInt()
    local plys = util.GetAlivePlayers()
    for i = 1, #plys do
      local ply = plys[i]
      local ply_karma = ply:GetLiveKarma()

      local maxdmg = GetConVar("ttt2_minigames_antikarma_max_dmg"):GetInt()
      local dmgnum = maxdmg * (ply_karma / karma_max)
      local dmginfo = DamageInfo()
      dmginfo:SetDamage(dmgnum)
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
      if plys[i]:GetLiveKarma() < GetConVar("ttt_karma_max"):GetInt() then
        return true
      end
    end
    return false
  end
end
