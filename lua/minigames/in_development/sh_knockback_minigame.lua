if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_trollprop_multiplier = {
    slider = true,
    min = 0,
    max = 5,
    decimal = 1,
    desc = "(Def. 2)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Hit Hard"
    },
    desc = {
      English = "We seem to hit people much farther?"
    }
  }
else
  ttt2_minigames_trollprop_multiplier = CreateConVar("ttt2_minigames_trollprop_multiplier")
end

if SERVER then
  function MINIGAME:OnActivation()
    hook.Add("EntityTakeDamage", "KnockbackMinigame", function(ply, dmginfo)
      if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() or ply:IsSpec() then return end

      dmginfo
    end)
  end

  function MINIGAME:OnDeactivation()

  end
end
