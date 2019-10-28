SUPERSODA = {}
SUPERSODA.sodas = {'soda_speedup', 'soda_rageup', 'soda_shootup', 'soda_armorup', 'soda_healup', 'soda_creditup', 'soda_jumpup'}

-- add functions to player object, SHARED
local plymeta = FindMetaTable('Player')
function plymeta:HasDrunkSoda(soda_name)
    if not self.drankSoda then return false end

    return self.drankSoda[soda_name] or false
end

function plymeta:SetSoda(soda_name, soda_state)
    if not self.drankSoda then
        self.drankSoda = {}
    end
    self.drankSoda[soda_name] = soda_state
end

function plymeta:DrinkSoda(soda_name)
    self:SetSoda(soda_name, true)
end

function plymeta:RemoveSoda(soda_name)
    self:SetSoda(soda_name, false)

    hook.Run("TTT2RemovedSoda", self, soda_name)
end

function plymeta:SodaAmountDrunk()
    if not self.drankSoda then
        return 0
    end
    
    local amount = 0
    for _,drunk_soda in pairs(self.drankSoda) do
        if drunk_soda then amount = amount + 1 end
    end
    return amount
end


if SERVER then
    util.AddNetworkString('ttt2_supersoda_reset')
    util.AddNetworkString('ttt2_supersoda_drink')
    util.AddNetworkString('ttt2_supersoda_msg_already_drunk')
    util.AddNetworkString('ttt2_supersoda_msg_limit_reached')
    util.AddNetworkString('ttt2_supersoda_msg_spawned')

    -- RESET PLAYER SODA STATE
    function SUPERSODA:ResetPlayerState(ply)
        for _,soda in ipairs(self.sodas) do
            ply:RemoveSoda(soda)
        end

        net.Start('ttt2_supersoda_reset')
        net.Send(ply)
    end
    hook.Add('PlayerSpawn', 'ttt2_supersoda_reset_hook', function(ply)
        SUPERSODA:ResetPlayerState(ply)
    end)

    -- HANDLE SODA PICKUP
    function SUPERSODA:PickupSoda(ply, ent)
        if not IsValid(ent) then return end

        local soda = ent:GetClass()

        if ply:GetPos():Distance(ent:GetPos()) >= 100 then return end -- too far away
        if not table.HasValue(SUPERSODA.sodas, soda) then return end -- no valid soda

        -- check if alerady drunk
        if ent.soda_type == "SINGLEUSE" and ply:HasDrunkSoda(soda) then
            net.Start('ttt2_supersoda_msg_already_drunk')
            net.Send(ply)

            return -- do not continue
        end

        -- check if limited
        if GetGlobalBool('ttt_soda_limit_one_per_player') and ply:SodaAmountDrunk() >= 1 then
            net.Start('ttt2_supersoda_msg_limit_reached')
            net.Send(ply)

            return -- do not continue
        end

        -- handle single call sodas
        if ent.ConsumeSoda then
            ent:ConsumeSoda(ply)
        end

        -- drink soda and notify
        sound.Play('sodacan/opencan.wav', ply:GetPos(), 60)
        ent:Remove()
        STATUS:AddStatus(ply, soda)

        -- set drank soda on client
        ply:DrinkSoda(soda)
        net.Start('ttt2_supersoda_drink')
        net.WriteString(soda)
        net.Send(ply)
    end
    hook.Add('KeyPress', 'ttt2_supersoda_pickup', function(ply, key)
        if key ~= IN_USE then return end

        SUPERSODA:PickupSoda(ply, ply:GetEyeTrace().Entity)
    end)

    hook.Add('TTTBeginRound', 'ttt2_supersoda_spawn' , function()
        -- limit by defined max and found items
        local amount = math.min(#ents.FindByClass('item_*'), GetGlobalInt('ttt_soda_total_spawn_amount'))

        -- make sure more than 0 sodas can be spawned
        if amount == 0 then return end

        -- create a new soda table based on the spawn weights
        weighted_spawn = {}
        for _, soda in ipairs(SUPERSODA.sodas) do
            local weight = GetConVar('ttt_' .. soda .. '_sweight'):GetInt()
            for i = 1, weight do
                table.Add(weighted_spawn, {soda})
            end
        end

        -- only continue if sodas should be spawned
        if #weighted_spawn == 0 then return end
        
        local spawns = ents.FindByClass('item_*')
        for i = 1, amount do
            -- research since one item was replaced

            local index = math.random(#spawns)
            local spwn = spawns[index]
            local spwn_name = spwn:GetClass()
            local soda = ents.Create(weighted_spawn[math.random(#weighted_spawn)])

            soda:SetPos(spwn:GetPos())
            soda:Spawn()
            spwn:Remove()
            table.remove(spawns, index)

            local newSpwn = ents.Create(spwn_name)
            newSpwn:SetPos(soda:GetPos() + Vector(20, 20, 0))
            newSpwn:Spawn()
        end

        -- send message about spawned bottles
        if amount == 0 then return end

        net.Start('ttt2_supersoda_msg_spawned')
        net.WriteUInt(amount, 16)
        net.Send(player.GetAll())
    end)
end

if CLIENT then
    net.Receive('ttt2_supersoda_reset', function()
        local client = LocalPlayer()

        if not client or not IsValid(client) then return end

        for _,soda in ipairs(SUPERSODA.sodas) do
            client:RemoveSoda(soda)
        end
    end)

    net.Receive('ttt2_supersoda_drink', function()
        local client = LocalPlayer()
        local soda = net.ReadString()

        client:DrinkSoda(soda)
        MSTACK:AddMessage(LANG.GetTranslation('ttt_drank_' .. soda))
    end)

    net.Receive('ttt2_supersoda_msg_already_drunk', function()
        MSTACK:AddMessage(LANG.GetTranslation('ttt_drank_soda_already_drunk'))
    end)
    net.Receive('ttt2_supersoda_msg_limit_reached', function()
        MSTACK:AddMessage(LANG.GetTranslation('ttt_drank_soda_limit_reached'))
    end)
    net.Receive('ttt2_supersoda_msg_spawned', function()
        -- store in variable since it sets the text to red otherwise
        local text = LANG.GetParamTranslation('ttt_spawned_soda', {amount = net.ReadUInt(16)})
        MSTACK:AddMessage(text)
    end)
end
