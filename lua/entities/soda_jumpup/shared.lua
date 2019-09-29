AddCSLuaFile()

ENT.Base      = 'base_anim'
ENT.Spawnable = true

ENT.soda_type = 'SINGLEUSE'

util.PrecacheSound('sound/sodacan/opencan.wav')

if CLIENT then
	language.Add('soda_jumpup', 'JumpUp!™')
end

function ENT:Initialize()
    self:SetModel('models/props_junk/PopCan01a.mdl')
    self:SetMaterial('models/props_junk/can_jumpup', true)

    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end