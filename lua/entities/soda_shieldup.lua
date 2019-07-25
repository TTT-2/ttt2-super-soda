AddCSLuaFile()

ENT.Base      = 'base_anim'
ENT.Spawnable = true

util.PrecacheSound('sound/sodacan/opencan.wav')

if CLIENT then
	language.Add('soda_shieldup', 'ShieldUp!™')
end

function ENT:Initialize()
    self:SetModel('models/props_junk/PopCan01a.mdl')
    self:SetMaterial("models/props_junk/popcan01a_phong", true)

    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end

hook.Add('EntityTakeDamage', 'ttt2_supersoda_shieldup', function(target, dmginfo)
    if not IsValid(target) or not target:IsPlayer() then return end
    if not target:HasDrunkSoda('soda_shieldup') then return end

    dmginfo:SetDamage(dmginfo:GetDamage() * GetGlobalFloat('ttt_soda_shieldup'))
end)