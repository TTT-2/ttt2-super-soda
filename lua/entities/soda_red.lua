AddCSLuaFile()

ENT.Base 				=	"base_anim"
ENT.Spawnable			=	true

util.PrecacheSound( "sound/sodacan/opencan.wav" )

if CLIENT then
language.Add( "soda_red", 'RageUp!™')
end

function ENT:Initialize()

	self:SetModel( "models/props_junk/PopCan01a.mdl" )
	self:SetSkin( 1 )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:Use( activator )
	activator.DrankRed = true
	sound.Play( "sodacan/opencan.wav", activator:GetPos(), 60 )
	self:Remove()
	activator:ChatPrint( 'You found the RageUp!™ can! Deal more damage!' )
end