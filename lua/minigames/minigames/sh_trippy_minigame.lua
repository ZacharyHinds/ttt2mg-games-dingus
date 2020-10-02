if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Took Too Much",
      Русский = "Перебрал"
    },
    desc = {
      English = "I think I'm gonna be sick!",
      Русский = "Кажется, меня сейчас стошнит!"
    }
  }
end

if CLIENT then
  local color_tbl = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 10,
    ["$pp_colour_mulr"] = -10,
    ["$pp_colour_mulg"] = -10,
    ["$pp_colour_mulb"] = -10
  }

  function MINIGAME:OnActivation()
    hook.Add("RenderScreenspaceEffects", "TrippyMinigameEffect", function()
      local client = LocalPlayer()
      if not client:Alive() or client:IsSpec() then return end

      DrawColorModify(color_tbl)
      cam.Start3D(EyePos(), EyeAngles())

      render.SuppressEngineLighting(true)
      render.SetColorModulation(1, 1, 1)
      render.SuppressEngineLighting(false)


      cam.End3D()
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("RenderScreenspaceEffects", "TrippyMinigameEffect")
  end

end
