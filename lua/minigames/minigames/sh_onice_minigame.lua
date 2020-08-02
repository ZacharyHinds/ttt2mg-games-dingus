if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_roleshuffle_timer = {
    slider = true,
    min = 1,
    max = 240,
    desc = "(Def. 90)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Trouble in Terrorist Town: On Ice"
    },
    desc = {
      English = ""
    }
  }
else
  ttt2_minigames_onice_friction = CreateConVar("ttt2_minigames_onice_friction", "0.5", {FCVAR_ARCHIVE}, "Friction multiplier")
end

if SERVER then
  function MINIGAME:OnActivation()
    for _, ply in ipairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end

      ply:SetFriction(ply:GetFriction() * ttt2_minigames_onice_friction:GetFloat())
  end

  function MINIGAME:OnDeactivation()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetFriction(1)
    end
  end
end
if CLIENT then
end
