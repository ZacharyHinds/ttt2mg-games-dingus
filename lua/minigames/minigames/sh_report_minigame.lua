if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Crime Reporter"
      Русский = "Криминальный репортёр"
    },
    desc = {
      English = ""
    }
  }
end

if SERVER then
  util.AddNetworkString("ttt2mg_reporter_minigame")
  function MINIGAME:OnActivation()
    hook.Add("TTT2PostPlayerDeath", "ReporterMinigame", function(victim, infl, attacker)
      if not IsValid(victim) or not victim:IsPlayer() then return end

      local report_string
      if attacker:IsPlayer() then
        report_string = "ttt2mg_reporter_murder"
      else
        report_string = "ttt2mg_reporter_died"
      end
      net.Start("ttt2mg_reporter_minigame")
      net.WriteString(report_string)
      net.WriteString(victim:Nick())
      net.Broadcast()
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("TTT2PostPlayerDeath", "ReporterMinigame")
  end
end

if CLIENT then
  net.Receive("ttt2mg_reporter_minigame", function()
    local report_string = LANG.GetParamTranslation(net.ReadString(), {nick = net.ReadString()})
    EPOP:AddMessage({
        text = report_string,
        color = COLOR_ORANGE
    },
      nil,
      4,
      nil,
      true
    )
  end)
end
