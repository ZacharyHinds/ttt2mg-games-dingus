if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

if CLIENT then
  MINIGAME.lang = {
    name = {
      English = "There are ghosts around"
    },
    desc = {
      English = "Boredom for noone!"
    }
  }
end

if SERVER then
  local ghostents = {}
  function MINIGAME:OnActivation()
    hook.Add("TTT2PostPlayerDeath", "HauntingMinigame", function(ply, _, attacker)
      timer.Simple(3, function()
        ghostents[ply:Nick()] = ents.Create("npc_kleiner")
        local ghostent = ghostents[ply:Nick()]
        ghostent:SetModel(ply:GetModel())
        ghostent:SetPos(ply:GetPos())
        ghostent:Spawn()
        ghostent:SetNotSolid(true)
        ghostent:SetColor(Color( 245, 245, 245, 100))
        ghostent:SetRenderMode(RENDERMODE_GLOW)

        ply:SetNWBool("IsSpooky", true)

      end)
    end)
    local tick_delay = CurTime() + 3
    hook.Add("Think", "ghostMinigameUpdate", function()
      for _, ply in ipairs(player.GetAll()) do
        if ply:Alive() or ply:IsSpec() then continue end
        if not ply:GetNWBool("IsSpooky") then continue end
        local hasUpdated = false
        if CurTime() >= tick_delay and not hasUpdated then
          ghostent = ghostents[ply:Nick()]
          ghostent:SetPos(ply:GetPos())
          tick_delay = CurTime() + 5
          hasUpdated = true
        end
      end
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("Think", "ghostMinigameUpdate")
    hook.Remove("TTT2PostPlayerDeath", "HauntingMinigame")
  end
end
