CreateConVar('ttt_soda_total_spawn_amount', 6, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Set the amount of sodas that spawn each round.')
CreateConVar('ttt_soda_limit_one_per_player', 0, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Limit the soda usage to one per player.')
CreateConVar('ttt_soda_speedup', 1.75, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Set the speed you can get after drinking the SpeedUp! soda. (1.5 = 150%, 1.75 = 175% etc.)')
CreateConVar('ttt_soda_rageup', 1.30, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much damage do you deal after drinking the RageUp! soda (1.20 = 120%, 1.40 = 140% etc.)')
CreateConVar('ttt_soda_shootup', 1.50, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much much shorter the delay is after ShootUp! soda (1.20 = 120%, 1.40 = 140% etc.)')
CreateConVar('ttt_soda_shieldup', 10, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much extra armor points you receive.')
CreateConVar('ttt_soda_healup', 10, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much extra armor points you receive.')
CreateConVar('ttt_soda_creditup', 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much extra equipment credits you receive.')

hook.Add('TTTUlxInitCustomCVar', 'TTTSuperSodaInitRWCVar', function(name)
    ULib.replicatedWritableCvar('ttt_soda_total_spawn_amount', 'rep_ttt_soda_total_spawn_amount', GetConVar('ttt_soda_total_spawn_amount'):GetInt(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_limit_one_per_player', 'rep_ttt_soda_limit_one_per_player', GetConVar('ttt_soda_limit_one_per_player'):GetBool(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_speedup', 'rep_ttt_soda_speedup', GetConVar('ttt_soda_speedup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_rageup', 'rep_ttt_soda_rageup', GetConVar('ttt_soda_rageup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_shootup', 'rep_ttt_soda_shootup', GetConVar('ttt_soda_shootup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_shieldup', 'rep_ttt_soda_shieldup', GetConVar('ttt_soda_shieldup'):GetInt(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_healup', 'rep_ttt_soda_healup', GetConVar('ttt_soda_healup'):GetInt(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_creditup', 'rep_ttt_soda_creditup', GetConVar('ttt_soda_creditup'):GetInt(), true, false, name)
end)

if SERVER then
    -- ConVar replication is broken in GMod, so we do this, at least Alf added a hook!
    -- I don't like it any more than you do, dear reader. Copycat!
    hook.Add('TTT2SyncGlobals', 'ttt2_supersoda_sync_convars', function()
        SetGlobalFloat('ttt_soda_total_spawn_amount', GetConVar('ttt_soda_total_spawn_amount'):GetInt())
        SetGlobalBool('ttt_soda_limit_one_per_player', GetConVar('ttt_soda_limit_one_per_player'):GetBool())
        SetGlobalFloat('ttt_soda_speedup', GetConVar('ttt_soda_speedup'):GetFloat())
        SetGlobalFloat('ttt_soda_rageup', GetConVar('ttt_soda_rageup'):GetFloat())
        SetGlobalFloat('ttt_soda_shootup', GetConVar('ttt_soda_shootup'):GetFloat())
        SetGlobalFloat('ttt_soda_shieldup', GetConVar('ttt_soda_shieldup'):GetInt())
        SetGlobalFloat('ttt_soda_healup', GetConVar('ttt_soda_healup'):GetInt())
        SetGlobalFloat('ttt_soda_creditup', GetConVar('ttt_soda_creditup'):GetInt())
    end)

    -- sync convars on change
    cvars.AddChangeCallback('ttt_soda_total_spawn_amount', function(cv, old, new)
        SetGlobalInt('ttt_soda_total_spawn_amount', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_limit_one_per_player', function(cv, old, new)
        SetGlobalBool('ttt_soda_limit_one_per_player', tobool(tonumber(new)))
    end)
    cvars.AddChangeCallback('ttt_soda_speedup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_speedup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_rageup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_rageup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_shootup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_shootup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_shieldup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_shieldup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_healup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_healup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_creditup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_creditup', tonumber(new))
    end)
end

if CLIENT then
    hook.Add('TTTUlxModifyAddonSettings', 'TTTSupersodaModifySettings', function(name)
        local tttrspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

        -- Basic Settings 
        local tttrsclp1 = vgui.Create('DCollapsibleCategory', tttrspnl)
        tttrsclp1:SetSize(390, 50)
        tttrsclp1:SetExpanded(1)
        tttrsclp1:SetLabel('Basic Settings')

        local tttrslst1 = vgui.Create('DPanelList', tttrsclp1)
        tttrslst1:SetPos(5, 25)
        tttrslst1:SetSize(390, 50)
        tttrslst1:SetSpacing(5)

        local tttrsdh11 = xlib.makeslider{label = 'ttt_soda_total_spawn_amount (Def. 6)', repconvar = 'rep_ttt_soda_total_spawn_amount', min = 0, max = 25, decimal = 0, parent = tttrslst1}
        tttrslst1:AddItem(tttrsdh11)

        local tttrsdh12 = xlib.makecheckbox{label = 'ttt_soda_limit_one_per_player (Def. 0)', repconvar = 'rep_ttt_soda_limit_one_per_player', parent = tttrslst1}
        tttrslst1:AddItem(tttrsdh12)

        -- Multipliers 
        local tttrsclp2 = vgui.Create('DCollapsibleCategory', tttrspnl)
        tttrsclp2:SetSize(390, 100)
        tttrsclp2:SetExpanded(1)
        tttrsclp2:SetLabel('Mulipliers')

        local tttrslst2 = vgui.Create('DPanelList', tttrsclp2)
        tttrslst2:SetPos(5, 25)
        tttrslst2:SetSize(390, 75)
        tttrslst2:SetSpacing(5)
        
        local tttrsdh21 = xlib.makeslider{label = 'ttt_soda_speedup (Def. 1.75)', repconvar = 'rep_ttt_soda_speedup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh21)
        
        local tttrsdh22 = xlib.makeslider{label = 'ttt_soda_rageup (Def. 1.30)', repconvar = 'rep_ttt_soda_rageup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh22)
        
        local tttrsdh23 = xlib.makeslider{label = 'ttt_soda_shootup (Def. 1.50)', repconvar = 'rep_ttt_soda_shootup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh23)

        -- Instant Effects
        local tttrsclp3 = vgui.Create('DCollapsibleCategory', tttrspnl)
        tttrsclp3:SetSize(390, 50)
        tttrsclp3:SetExpanded(1)
        tttrsclp3:SetLabel('Instant Effects')

        local tttrslst3 = vgui.Create('DPanelList', tttrsclp3)
        tttrslst3:SetPos(5, 25)
        tttrslst3:SetSize(390, 75)
        tttrslst3:SetSpacing(5)

        local tttrsdh31 = xlib.makeslider{label = 'ttt_soda_shieldup (Def. 10)', repconvar = 'rep_ttt_soda_shieldup', min = 0, max = 100, decimal = 0, parent = tttrslst3}
        tttrslst3:AddItem(tttrsdh31)

        local tttrsdh32 = xlib.makeslider{label = 'ttt_soda_healup (Def. 10)', repconvar = 'rep_ttt_soda_healup', min = 0, max = 100, decimal = 0, parent = tttrslst3}
        tttrslst3:AddItem(tttrsdh32)

        local tttrsdh33 = xlib.makeslider{label = 'ttt_soda_creditup (Def. 1)', repconvar = 'rep_ttt_soda_creditup', min = 0, max = 100, decimal = 0, parent = tttrslst3}
        tttrslst3:AddItem(tttrsdh33)

        -- add to ULX
        xgui.hookEvent('onProcessModules', nil, tttrspnl.processModules)
        xgui.addSubModule('Super Soda', tttrspnl, nil, name)
    end)
end
