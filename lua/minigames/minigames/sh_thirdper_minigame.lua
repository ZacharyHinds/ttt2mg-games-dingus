if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted, Based on Randomat event by Owningle"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Third Person"
    },
    desc = {
      English = ""
    }
  }
end

if CLIENT then
  function MINIGAME:OnActivation()
    hook.Add("CalcView", "ThirdpersonMinigame", function(ply, pos, angles, fov)
      local view = {
        origin = pos - (angles:Forward() * 100),
        angles = angles,
        fov = fov,
        drawviewer = true
      }
      return view
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("CalcView", "ThirdpersonMinigame")
  end
end
