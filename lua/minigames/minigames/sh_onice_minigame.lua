if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_onice_friction = {
    slider = true,
    min = -1,
    max = 8,
    decimal = 1,
    desc = "(Def. 0.1)"
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
  ttt2_minigames_onice_friction = CreateConVar("ttt2_minigames_onice_friction", "0.0", {FCVAR_ARCHIVE}, "Friction amount")
end

if SERVER then
  function MINIGAME:OnActivation()
    RunConsoleCommand("sv_friction", ttt2_minigames_onice_friction:GetFloat())
  end

  function MINIGAME:OnDeactivation()
    RunConsoleCommand("sv_friction", 8)
  end
end
