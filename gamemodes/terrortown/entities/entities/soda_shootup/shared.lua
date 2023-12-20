if SERVER then
	AddCSLuaFile()
else
	ENT.PrintName = "soda_shootup"
end

ENT.Base = "base_anim"
ENT.Spawnable = true

ENT.soda_type = "SINGLEUSE"

util.PrecacheSound("sound/sodacan/opencan.wav")

function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMaterial("models/props_junk/can_shootup", true)

	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
end

-- shooting speed modify code by Alf21, THANKS!
if SERVER then
	util.AddNetworkString("ttt2_supersoda_shootup_speedupdate")

	local function DisableWeaponSpeed(wep)
		if IsValid(wep) and wep.OnDrop_old then
			wep.Primary.Delay = wep.Delay_old
			wep.OnDrop = wep.OnDrop_old

			net.Start("ttt2_supersoda_shootup_speedupdate")
			net.WriteEntity(wep)
			net.WriteFloat(wep.Primary.Delay)
			net.Send(wep.Owner)

			wep.OnDrop_old = nil
			wep.Delay_old = nil
		end
	end

	local function ApplyWeaponSpeed(wep)
		if (wep.Kind == WEAPON_HEAVY or wep.Kind == WEAPON_PISTOL) then
			local delay = math.Round(wep.Primary.Delay / GetGlobalFloat("ttt_soda_shootup"), 3)

			wep.Delay_old = wep.Primary.Delay
			wep.Primary.Delay = delay
			wep.OnDrop_old = wep.OnDrop

			net.Start("ttt2_supersoda_shootup_speedupdate")
			net.WriteEntity(wep)
			net.WriteFloat(wep.Primary.Delay)
			net.Send(wep.Owner)
		end
	end

	function ENT:ConsumeSoda(ply)
		if not IsValid(ply) then return end

		ApplyWeaponSpeed(ply:GetActiveWeapon())
	end

	hook.Add("PlayerSwitchWeapon", "ttt2_supersoda_shootup_hook", function(ply, old, new)
		if not IsValid(ply) then return end

		if ply:HasDrunkSoda("soda_shootup") then
			ApplyWeaponSpeed(new)
		end

		if IsValid(old) then
			DisableWeaponSpeed(old)
		end
	end)

	hook.Add("PlayerDroppedWeapon", "ttt2_infinishoot_handle_weapon_drop", function(ply, wep)
		if not IsValid(ply) then return end

		DisableWeaponSpeed(wep)
	end)

	hook.Add("TTT2RemovedSoda", "ttt2_soda_remove_shootup", function(ply, soda_name)
		if not IsValid(ply) then return end
		if soda_name ~= "soda_shootup" then return end

		DisableWeaponSpeed(ply:GetActiveWeapon())
	end)
end

if CLIENT then
	net.Receive("ttt2_supersoda_shootup_speedupdate", function()
		local wep = net.ReadEntity()

		wep.Primary.Delay = net.ReadFloat()
	end)
end
