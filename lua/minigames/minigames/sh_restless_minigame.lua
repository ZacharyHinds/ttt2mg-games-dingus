if SERVER then
  AddCSLuaFile()
end

MINIGAME.author = "Wasted"
MINIGAME.contact = "Zzzaaaccc13 on TTT2 Discord"

MINIGAME.conVarData = {
  ttt2_minigames_restless_deaths = {
    slider = true,
    min = 1,
    max = 10,
    desc = "ttt2_minigames_restless_deaths (Def. 1)"
  },

  ttt2_minigames_restless_delay = {
    slider = true,
    min = 0,
    max = 30,
    desc = "ttt2_minigames_restless_delay (Def. 3)"
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
end

if SERVER then
  local ttt2_minigames_restless_deaths = CreateConVar("ttt2_minigames_restless_deaths", "1", {FCVAR_ARCHIVE}, "How many lives the new restless have already used")
  local ttt2_minigames_restless_delay = CreateConVar("ttt2_minigames_restless_delay", "3", {FCVAR_ARCHIVE}, "Respawn delay for minigame")
  function MINIGAME:OnActivation()
    ttt2_rst_lives = GetConVar("ttt2_rst_lives")
    ttt2_rst_min_health = GetConVar("ttt2_rst_min_health")
    ttt2_rst_health_multi = GetConVar("ttt2_rst_health_multi")
    hook.Add("TTT2PostPlayerDeath", "RestlessMinigame", function(ply, _, attacker)
      if not IsValid(ply) or attacker:GetSubRole() == ROLE_INFECTED then return end
      if ply:GetSubRole() == ROLE_RESTLESS then return end

      local death_cnt = ttt2_minigames_restless_deaths:GetInt()
      if death_cnt > GetConVar("ttt2_rst_lives"):GetInt() then death_cnt = ttt2_rst_lives:GetInt() end
      ply:SetNWInt("rst_death_count", death_cnt)
      local rst_health = 100 - (ttt2_rst_health_multi:GetInt() * death_cnt)
      if rst_health < ttt2_rst_min_health:GetInt() then rst_health = ttt2_rst_min_health:GetInt() end


      ply:Revive(
        ttt2_minigames_restless_delay:GetInt(),
        function()
          ply:SetRole(ROLE_RESTLESS, TEAM_RESTLESS)
          ply:SetHealth(ttt2_minigames_restless_delay:GetInt())
          ply:SetMaxHealth(ttt2_minigames_restless_delay:GetInt())
          SendFullStateUpdate()
        end,
        nil,
        true,
        false
      )
      if death_cnt ~= ttt2_rst_lives:GetInt() then
        ply:SendRevivalReason("restless_reviving")
      else
        ply:SendRevivalReason("restless_final_life")
      end
    end)
  end

  function MINIGAME:OnDeactivation()
    hook.Remove("TTT2PostPlayerDeath", "RestlessMinigame")
  end

  function MINIGAME:IsSelectable()
    if not RESTLESS then
      return false
    else
      return true
    end
  end
end
