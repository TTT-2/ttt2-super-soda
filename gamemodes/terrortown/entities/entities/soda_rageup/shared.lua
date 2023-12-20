if SERVER then
	AddCSLuaFile()
else
	ENT.PrintName = "soda_rageup"
end

ENT.Base = "base_anim"
ENT.Spawnable = true

ENT.soda_type = "SINGLEUSE"

util.PrecacheSound("sound/sodacan/opencan.wav")

function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMaterial("models/props_junk/can_rageup", true)

	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
end

hook.Add("EntityTakeDamage", "ttt2_supersoda_rageup", function(target, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if not IsValid(target) or not target:IsPlayer() then return end
	if not IsValid(attacker) or not attacker:IsPlayer() then return end
	if not attacker:HasDrunkSoda("soda_rageup") then return end

	dmginfo:SetDamage(dmginfo:GetDamage() * GetConVar("ttt_soda_rageup"):GetFloat())
end)
