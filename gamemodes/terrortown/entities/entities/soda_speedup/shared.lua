if SERVER then
	AddCSLuaFile()
else
	ENT.PrintName = "soda_speedup"
end

ENT.Base = "base_anim"
ENT.Spawnable = true

ENT.soda_type = "SINGLEUSE"

util.PrecacheSound("sound/sodacan/opencan.wav")

function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMaterial("models/props_junk/can_speedup", true)

	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
end

hook.Add("TTTPlayerSpeedModifier", "ttt2_supersoda_speedup" , function(ply, _, _, noLag)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not ply:HasDrunkSoda("soda_speedup") then return end

	noLag[1] = noLag[1] * GetGlobalFloat("ttt_soda_speedup")
end)
