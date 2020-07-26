if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_credits_count = {
    slider = true,
    min = 1,
    max = 10,
    desc = "(Def. 1)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "2 Person Teams!"
    },
    desc = {
      English = "Does whatever a spider can!"
    }
  }
else
end

local ColorsList = {}

if SERVER then
  function MINIGAME:OnActivation()
    local plys1 = {}
    local plys2 = {}

    local isA = true
    for _, ply in RandomPairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end

      if isA then
        plys1[#plys1 + 1] = ply
        isA = false
      else
        plys2[#plys2 + 1] = ply
      end
    end

    for i = 1 in #plys1 do
      ply = plys1[i]
      ply2 = plys2[i]

    end
  end

  function MINIGAME:OnDeactivation()

  end
end
