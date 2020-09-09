if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_recoil_mult = {
    slider = true,
    min = 0,
    max = 2,
    decimal = 2,
    desc = "(Def. 2.0)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Recoil Upgrade"
    },
    desc = {
      English = "Watch out, they've got a kick to them"
    }
  }
else
  ttt2_minigames_recoil_mult = CreateConVar("ttt2_minigames_recoil_mult", "2.0", {FCVAR_ARCHIVE}, "ArcCW Recoil Multiplier scale")
end

if SERVER then
  local old_mult = 1
  function MINIGAME:OnActivation()
    old_mult = GetConVar("arccw_mult_recoil"):GetFloat()
    RunConsoleCommand("arccw_mult_recoil", ttt2_minigames_recoil_mult:GetFloat() * old_mult)
  end

  function MINIGAME:OnDeactivation()
    RunConsoleCommand("arccw_mult_recoil", old_mult)
  end
end
