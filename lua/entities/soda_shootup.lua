AddCSLuaFile()

ENT.Base      = 'base_anim'
ENT.Spawnable = true

util.PrecacheSound('sound/sodacan/opencan.wav')

if CLIENT then
    language.Add('soda_shootup', 'ShootUp!™')
end
if SERVER then
    resource.AddFile('materials/models/props_junk/popcan04a')
end

function ENT:Initialize()
    self:SetModel('models/props_junk/PopCan01a.mdl')
    self:SetMaterial('models/props_junk/popcan04a', true)

    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end