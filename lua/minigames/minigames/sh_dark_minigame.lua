if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Lights Out!"
    },
    desc = {
      English = ""
    }
  }
end

if SERVER then
  util.AddNetworkString("DarkMinigameLightmap")
  function MINIGAME:OnActivation()
    engine.LightStyle(0, "a")
    net.Start("DarkMinigameLightmap")
    net.Broadcast()
  end

  function MINIGAME:OnDeactivation()
    timer.Simple(1.5, function()
      engine.LightStyle(0, "m")
      net.Start("DarkMinigameLightmap")
      net.Broadcast()
    end)
  end
end

if CLIENT then
  net.Receive("DarkMinigameLightmap", function()
    render.RedownloadAllLightmaps()
  end)
end
