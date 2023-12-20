if SERVER then
	AddCSLuaFile()
else
	ENT.PrintName = "soda_jumpup"
end

ENT.Base = "base_anim"
ENT.Spawnable = true

ENT.soda_type = "SINGLEUSE"

util.PrecacheSound("sound/sodacan/opencan.wav")

function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMaterial("models/props_junk/can_jumpup", true)

	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
end

function ENT:ConsumeSoda(ply)
	--only modify jump height when the player doesn"t have blue bull
	if ply:HasEquipmentItem("item_ttt_blue_bull") then
		ply:SetNWInt("MaxJumpLevel", ply:GetNWInt("MaxJumpLevel", 2) + 1)
	else
		ply:SetNWInt("MaxJumpLevel", 1)
		ply:SetNWInt("JumpLevel", 0)
		ply:SetJumpPower(200) -- jump a little bit higher
	end
end

local function GetMoveVector(mv)
	local ang = mv:GetAngles()

	local max_speed = mv:GetMaxSpeed()

	local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
	local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

	local abs_xy_move = math.abs(forward) + math.abs(side)

	if abs_xy_move == 0 then
		return Vector(0, 0, 0)
	end

	local mul = max_speed / abs_xy_move

	local vec = Vector()

	vec:Add(ang:Forward() * forward)
	vec:Add(ang:Right() * side)

	vec:Mul(mul)

	return vec
end

hook.Add("SetupMove", "SodaJump", function(ply, mv)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not ply:HasDrunkSoda("soda_jumpup") or ply:HasEquipmentItem("item_ttt_blue_bull") then return end

	-- Let the engine handle movement from the ground
	if ply:OnGround() then
		ply:SetNWInt("JumpLevel", 0)

		return
	end

	-- Don't do anything if not jumping
	if not mv:KeyPressed(IN_JUMP) then
		return
	end

	ply:SetNWInt("JumpLevel", ply:GetNWInt("JumpLevel") + 1)

	if ply:GetNWInt("JumpLevel") > 1 then
		return
	end

	local vel = GetMoveVector(mv)

	vel.z = ply:GetJumpPower()

	mv:SetVelocity(vel)

	ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)
end )

hook.Add("TTT2RemovedSoda", "ttt2_soda_remove_shootup_jumpup", function(ply, soda_name)
	if not IsValid(ply) then return end
	if soda_name ~= "soda_jumpup" then return end

	ply:SetJumpPower(160) -- bit more then twice as much
end)
