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

hook.Add('EntityTakeDamage', 'ttt2_supersoda_ragedup', function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()

    if not IsValid(target) or not target:IsPlayer() then return end
    if not IsValid(attacker) or not attacker:IsPlayer() then return end
    if not attacker:HasDrunkSoda('soda_ragedup') then return end

    dmginfo:SetDamage(dmginfo:GetDamage() * GetGlobalFloat('ttt_soda_ragedup'))
end)