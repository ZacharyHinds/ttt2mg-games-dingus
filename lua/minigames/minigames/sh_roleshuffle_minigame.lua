if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_roleshuffle_timer = {
    slider = true,
    min = 1,
    max = 240,
    desc = "(Def. 90)"
  }
}

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "RESTLESS DEAD!"
    },
    desc = {
      English = "The dead will return as Restless!"
    }
  }
else
  ttt2_minigames_roleshuffle_timer = CreateConVar("ttt2_minigames_roleshuffle_timer", "90", {FCVAR_ARCHIVE}, "Time between role shuffles")
  util.AddNetworkString("roleshuffle_popup")
end

if SERVER then
  function ShuffleRoles()
    local ply_x = nil
    local ply_first = nil
    for _, ply in RandomPairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end

      if ply_x then
        ply:SetRole(ply_x:GetSubRole(), ply_x:GetTeam())
        ply_x = ply

      else
        ply_x = ply
        ply_first = ply
      end
    end

    ply_first:SetSubRole(ply_x:GetSubRole(), ply_x:GetTeam())

    SendFullStateUpdate()
  end

  function MINIGAME:OnActivation()
    ShuffleRoles()
    timer.Create("RoleshuffleMinigameTimer", ttt2_minigames_roleshuffle_timer:GetInt(), 0, function()
      net.Start("roleshuffle_popup")
      net.Broadcast()
    end)
  end

  function MINIGAME:OnDeactivation()

  end
end
if CLIENT then
  net.Receive("roleshuffle_popup", function()
    EPOP:AddMessage({
      text = "Shuffle!"
    },
    "",
    3)
  end)
end
