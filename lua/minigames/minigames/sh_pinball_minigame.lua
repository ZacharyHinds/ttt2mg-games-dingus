if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_pinball_mult = {
    slider = true,
    min = 1,
    max = 8,
    decimal = 1,
    desc = "(Def. 2.0)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Ricochet"
    },
    desc = {
      English = "That deaf, dumb, blind kid sure plays a mean pinball"
    }
  }
else
  ttt2_minigames_pinball_mult = CreateConVar("ttt2_minigames_pinball_mult", "2", {FCVAR_ARCHIVE}, "Velocity multiplier for pinball minigame")
end

if SERVER then
  function MINIGAME:OnActivation()
    hook.Add("ShouldCollide", "MinigamePinball", function(ply1, ply2)
      if not (ply1 and ply2) or not (ply1:IsPlayer() and ply2:IsPlayer()) then return end
      if ply1:GetPos():DistToSqr(ply2:GetPos()) > 1300 then return end

      velocity = Vector(ply1:GetPos().x - ply2:GetPos().x, ply1:GetPos().y - ply2:GetPos().y, ply1:GetPos().z - ply2:GetPos().z)
      ply1:SetVelocity(velocity * ttt2_minigames_pinball_mult:GetFloat())
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("ShouldCollide", "MinigamePinball")
  end
end
