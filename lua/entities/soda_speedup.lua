AddCSLuaFile()

ENT.Base 				=	"base_anim"
ENT.Spawnable			=	true

util.PrecacheSound( "sound/sodacan/opencan.wav" )

if CLIENT then
language.Add( "soda_yellow", 'SpeedUp!™')
end

function ENT:Initialize()

	self:SetModel( "models/props_junk/PopCan01a.mdl" )
	self:SetSkin( 2 )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

hook.Add('TTTPlayerSpeedModifier', 'ttt2_supersoda_speedup' , function(ply, _, _, noLag)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if not ply:HasDrunkSoda('soda_speedup') then return end

    noLag[1] = noLag[1] * GetGlobalFloat('ttt_soda_speedup')
end)