if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted, Based on Randomat event by Owningle"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Third Person"
      Русский = "Третье лицо"
    },
    desc = {
      English = ""
    }
  }
end

if CLIENT then
  function MINIGAME:OnActivation()
    hook.Add("CalcView", "ThirdpersonMinigame", function(ply, pos, angles, fov)
      local new_origin = pos - (angles:Forward() * 100)
      new_origin.z = new_origin.z + 10
      local view = {
        origin = new_origin,
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
