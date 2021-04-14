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
    desc = "ttt2_minigames_onice_friction (Def. 0.0)"
  },
  ttt2_minigames_onice_nopropdmg = {
    checkbox = true,
    desc = "ttt2_minigames_onice_nopropdmg (Def. 1)"
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
end

if SERVER then
local ttt2_minigames_onice_friction = CreateConVar("ttt2_minigames_onice_friction", "0.0", {FCVAR_ARCHIVE}, "Friction amount")
local ttt2_minigames_onice_nopropdmg = CreateConVar("ttt2_minigames_onice_nopropdmg", "1", {FCVAR_ARCHIVE}, "If enabled, everyone becomes immune to prop damage")
  function MINIGAME:OnActivation()
    RunConsoleCommand("sv_friction", ttt2_minigames_onice_friction:GetFloat())

    if ttt2_minigames_onice_nopropdmg:GetBool() then
      local plys = player.GetAll()
      for i = 1, #plys do
        plys[i]:GiveEquipmentItem("item_ttt_nopropdmg")
      end
    end
  end

  function MINIGAME:OnDeactivation()
    timer.Simple(0.5, function()
      RunConsoleCommand("sv_friction", 8)
    end)
  end
end
