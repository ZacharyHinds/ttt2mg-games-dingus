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
      English = "Spectator Prop Buff!"
    },
    desc = {
      English = "Prop possession is now twice as annoying!"
    }
  }
else
  ttt2_minigames_trollprop_multiplier = CreateConVar("ttt2_minigames_trollprop_multiplier")
end

if SERVER then
  function MINIGAME:OnActivation()
    prop_base = GetConVar("ttt_spec_prop_base"):GetFloat()
    prop_maxbonus = GetConVar("ttt_spec_prop_maxbonus"):GetFloat()
    prop_force = GetConVar("ttt_spec_prop_force"):GetFloat()
    prop_recharge = GetConVar("ttt_spec_prop_rechargetime"):GetFloat()

    RunConsoleCommand("ttt_spec_prop_base", prop_base * ttt2_minigames_trollprop_multiplier:GetFloat())
    RunConsoleCommand("ttt_spec_prop_maxbonus", prop_maxbonus * ttt2_minigames_trollprop_multiplier:GetFloat())
    RunConsoleCommand("ttt_spec_prop_force", prop_force * ttt2_minigames_trollprop_multiplier:GetFloat())
    RunConsoleCommand("ttt_spec_prop_rechargetime", prop_recharge * ttt2_minigames_trollprop_multiplier:GetFloat())


  end

  function MINIGAME:OnDeactivation()
    RunConsoleCommand("ttt_spec_prop_base", prop_base)
    RunConsoleCommand("ttt_spec_prop_maxbonus", prop_maxbonus)
    RunConsoleCommand("ttt_spec_prop_force", prop_force)
    RunConsoleCommand("ttt_spec_prop_rechargetime", prop_recharge)
  end
end
