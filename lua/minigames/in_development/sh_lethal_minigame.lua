if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_lethal_dmg = {
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
      English = "Lethal Weapons"
    },
    desc = {
      English = "I'm too old for this shit"
    }
  }
else
  ttt2_minigames_lethal_dmg = CreateConVar("ttt2_minigames_lethal_dmg", "2.0", {FCVAR_ARCHIVE}, "ArcCW Damage Scaling")
end

if SERVER then
  local old_mult = 0.5
  function MINIGAME:OnActivation()
    old_mult = GetConVar("arccw_mult_damage"):GetFloat()
    RunConsoleCommand("arccw_mult_damage", ttt2_minigames_lethal_dmg:GetFloat() * old_mult)
  end

  function MINIGAME:OnDeactivation()
    RunConsoleCommand("arccw_mult_damage", old_mult)
  end
end
