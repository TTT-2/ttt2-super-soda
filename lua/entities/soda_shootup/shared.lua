AddCSLuaFile()

ENT.Base      = 'base_anim'
ENT.Spawnable = true

util.PrecacheSound('sound/sodacan/opencan.wav')

if CLIENT then
    language.Add('soda_shootup', 'ShootUp!™')
end

function ENT:Initialize()
    self:SetModel('models/props_junk/PopCan01a.mdl')
    self:SetMaterial('models/props_junk/popcan04a_phong', true)

    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if SERVER then self:PhysicsInit(SOLID_VPHYSICS) end

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end


-- shooting speed modify code by Alf21, THANKS!
if SERVER then
    util.AddNetworkString('ttt2_supersoda_shootup_speedupdate')

    local function DisableWeaponSpeed(wep)
        if IsValid(wep) and wep.OnDrop_old then
            wep.Primary.Delay = wep.Delay_old
            wep.OnDrop = wep.OnDrop_old

            net.Start('ttt2_supersoda_shootup_speedupdate')
            net.WriteBool(false)
            net.WriteEntity(wep)
            net.WriteFloat(wep.Primary.Delay)
            net.WriteFloat(wep.Delay_old)
            net.Send(wep.Owner)

            wep.OnDrop_old = nil
            wep.Delay_old = nil
        end
    end

    local function ApplyWeaponSpeed(wep)
        if (wep.Kind == WEAPON_HEAVY or wep.Kind == WEAPON_PISTOL) then
            local delay = math.Round(wep.Primary.Delay / GetGlobalFloat('ttt_soda_shootup'), 3)

            wep.Delay_old = wep.Primary.Delay
            wep.Primary.Delay = delay
            wep.OnDrop_old = wep.OnDrop

            wep.OnDrop = function(self, ...)
                if IsValid(self) then
                    if self.OnDrop_old then
                        DisableWeaponSpeed(self)

                        self.OnDrop_old = nil
                    end

                    self:OnDrop()
                end
            end

            net.Start('ttt2_supersoda_shootup_speedupdate')
            net.WriteBool(true)
            net.WriteEntity(wep)
            net.WriteFloat(wep.Primary.Delay)
            net.WriteFloat(wep.Delay_old)
            net.Send(wep.Owner)
        end
    end

    local function shootingModifier(ply, old, new)
        if not IsValid(ply) then return end

        if ply:HasDrunkSoda('soda_shootup') then
            ApplyWeaponSpeed(new)
        end

        if IsValid(old) then
            DisableWeaponSpeed(old)
        end
    end
    hook.Add('PlayerSwitchWeapon', 'ttt2_supersoda_shootup_hook', shootingModifier)
end

if CLIENT then
    net.Receive('ttt2_supersoda_shootup_speedupdate', function()
        local apply = net.ReadBool()
        local wep = net.ReadEntity()

        wep.Primary.Delay = net.ReadFloat()

        if apply then
            wep.OnDrop_old = wep.OnDrop

            wep.OnDrop = function(self, ...)
                if IsValid(self) then
                    self.Primary.Delay = net.ReadFloat()
                    self.OnDrop = self.OnDrop_old

                    self:OnDrop()
                end
            end
        else
            wep.OnDrop = wep.OnDrop_old
        end
    end)
end