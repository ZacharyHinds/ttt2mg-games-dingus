if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Bouncy"
    },
    desc = {
      English = ""
    }
  }
end

if SERVER then
  function MINIGAME:OnActivation()
    hook.Add("GetFallDamage", "BouncingMinigameFall", function(ply, speed)
      ply:SetVelocity(Vector(0, 0, speed * 0.95))
      return 0
    end)
    hook.Add("EntityTakeDamage", "BouncingMinigameFallDmg", function(ply, dmginfo)
      if IsValid(ply) and ply:IsPlayer() and dmginfo:IsFallDamage() then return true end
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("GetFallDamage", "BouncingMinigameFall")
    hook.Remove("EntityTakeDamage", "BouncingMinigameFallDmg")
  end
end
