AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "Golden Gun"
   SWEP.Slot = 0
   SWEP.Icon = "vgui/ttt/icon_revolver"
   SWEP.IconLetter = "f"
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "pistol"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 4.5
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.0325
SWEP.Primary.Damage = 1000
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Sound = Sound("Golden_Deagle.Single")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = Model("models/weapons/zaratusa/powerdeagle/v_powerdeagle.mdl")
SWEP.WorldModel = Model("models/weapons/zaratusa/powerdeagle/w_powerdeagle.mdl")

SWEP.IronSightsPos = Vector(1.1, 0.6, 0.7)
SWEP.IronSightsAng = Vector(0, 0, 75)

SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "none"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

if SERVER then
  util.AddNetworkString("goldengun_pickup")
end

function SWEP:Equip()
  local owner = self:GetOwner()

  owner:SetNWBool("golden_gun_glow", true)
  net.Start("goldengun_pickup")
  net.WriteEntity(owner)
  net.Broadcast()
end

if CLIENT then
  net.Receive("golden_gun_glow")
