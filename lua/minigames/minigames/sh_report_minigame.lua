if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Crime Reporter"
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
        report_string = victim:Nick() .. " has been murdered!"
      else
        report_string = victim:Nick() .. " has died!"
      end
      net.Start("ttt2mg_reporter_minigame")
      net.WriteString(report_string)
      net.Broadcast()
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("TTT2PostPlayerDeath", "ReporterMinigame")
  end
end

if CLIENT then
  net.Receive("ttt2mg_reporter_minigame", function()
    local report_string = net.ReadString()
    EPOP:AddMessage({
      text = report_string
    })
  end)
end
