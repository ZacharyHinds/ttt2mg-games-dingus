if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "Grayscale",
      Русский = "Серый оттенок"
    },
    desc = {
      English = ""
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
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 0.05,
    ["$pp_colour_mulg"] = 0.05,
    ["$pp_colour_mulb"] = 0.05
  }

  function MINIGAME:OnActivation()
    hook.Add("RenderScreenspaceEffects", "GrayscaleMinigameEffect", function()
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
    hook.Remove("RenderScreenspaceEffects", "GrayscaleMinigameEffect")
  end

end
