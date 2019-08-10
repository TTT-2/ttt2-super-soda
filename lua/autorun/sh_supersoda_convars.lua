CreateConVar('ttt_soda_spawn_amount', 3, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Set the amount of sodas that spawn each round.')
CreateConVar('ttt_soda_limit_one_per_player', 0, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Limit the soda usage to one per player.')
CreateConVar('ttt_soda_speedup', 1.75, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'Set the speed you can get after drinking the SpeedUp! soda. (1.5 = 150%, 1.75 = 175% etc.)')
CreateConVar('ttt_soda_shieldup', 0.70, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much damage do you get after drinking the ShieldUp! soda (0.80 = 80%, 0.60 = 60% etc.)')
CreateConVar('ttt_soda_rageup', 1.30, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much damage do you deal after drinking the RageUp! soda (1.20 = 120%, 1.40 = 140% etc.)')
CreateConVar('ttt_soda_shootup', 1.50, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, 'How much much shorter the delay is after ShootUp! soda (1.20 = 120%, 1.40 = 140% etc.)')

hook.Add('TTTUlxInitCustomCVar', 'TTTSuperSodaInitRWCVar', function(name)
    ULib.replicatedWritableCvar('ttt_soda_spawn_amount', 'rep_ttt_soda_spawn_amount', GetConVar('ttt_soda_spawn_amount'):GetInt(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_limit_one_per_player', 'rep_ttt_soda_limit_one_per_player', GetConVar('ttt_soda_limit_one_per_player'):GetBool(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_speedup', 'rep_ttt_soda_speedup', GetConVar('ttt_soda_speedup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_shieldup', 'rep_ttt_soda_shieldup', GetConVar('ttt_soda_shieldup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_rageup', 'rep_ttt_soda_rageup', GetConVar('ttt_soda_rageup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_shootup', 'rep_ttt_soda_shootup', GetConVar('ttt_soda_shootup'):GetFloat(), true, false, name)
end)

if SERVER then
    -- ConVar replication is broken in GMod, so we do this, at least Alf added a hook!
    -- I don't like it any more than you do, dear reader. Copycat!
    hook.Add('TTT2SyncGlobals', 'ttt2_supersoda_sync_convars', function()
        SetGlobalFloat('ttt_soda_spawn_amount', GetConVar('ttt_soda_spawn_amount'):GetInt())
        SetGlobalBool('ttt_soda_limit_one_per_player', GetConVar('ttt_soda_limit_one_per_player'):GetBool())
        SetGlobalFloat('ttt_soda_speedup', GetConVar('ttt_soda_speedup'):GetFloat())
        SetGlobalFloat('ttt_soda_shieldup', GetConVar('ttt_soda_shieldup'):GetFloat())
        SetGlobalFloat('ttt_soda_rageup', GetConVar('ttt_soda_rageup'):GetFloat())
        SetGlobalFloat('ttt_soda_shootup', GetConVar('ttt_soda_shootup'):GetFloat())
    end)

    -- sync convars on change
    cvars.AddChangeCallback('ttt_soda_spawn_amount', function(cv, old, new)
        SetGlobalInt('ttt_soda_spawn_amount', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_limit_one_per_player', function(cv, old, new)
        SetGlobalBool('ttt_soda_limit_one_per_player', tobool(tonumber(new)))
    end)
    cvars.AddChangeCallback('ttt_soda_speedup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_speedup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_shieldup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_shieldup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_rageup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_rageup', tonumber(new))
    end)
    cvars.AddChangeCallback('ttt_soda_shootup', function(cv, old, new)
        SetGlobalFloat('ttt_soda_shootup', tonumber(new))
    end)
end

if CLIENT then
    hook.Add('TTTUlxModifyAddonSettings', 'TTTSupersodaModifySettings', function(name)
        local tttrspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

        -- Basic Settings 
        local tttrsclp = vgui.Create('DCollapsibleCategory', tttrspnl)
        tttrsclp:SetSize(390, 50)
        tttrsclp:SetExpanded(1)
        tttrsclp:SetLabel('Basic Settings')

        local tttrslst1 = vgui.Create('DPanelList', tttrsclp)
        tttrslst1:SetPos(5, 25)
        tttrslst1:SetSize(390, 50)
        tttrslst1:SetSpacing(5)

        local tttrsdh1 = xlib.makeslider{label = 'ttt_soda_spawn_amount (Def. 3)', repconvar = 'rep_ttt_soda_spawn_amount', min = 0, max = 25, decimal = 0, parent = tttrslst1}
        tttrslst1:AddItem(tttrsdh1)

        local tttrsdh2 = xlib.makecheckbox{label = 'ttt_soda_limit_one_per_player (Def. 0)', repconvar = 'rep_ttt_soda_limit_one_per_player', parent = tttrslst1}
        tttrslst1:AddItem(tttrsdh2)

        -- Multipliers 
        local tttrsclp = vgui.Create('DCollapsibleCategory', tttrspnl)
        tttrsclp:SetSize(390, 100)
        tttrsclp:SetExpanded(1)
        tttrsclp:SetLabel('Mulipliers')

        local tttrslst2 = vgui.Create('DPanelList', tttrsclp)
        tttrslst2:SetPos(5, 25)
        tttrslst2:SetSize(390, 100)
        tttrslst2:SetSpacing(5)
        
        local tttrsdh1 = xlib.makeslider{label = 'ttt_soda_speedup (Def. 1.75)', repconvar = 'rep_ttt_soda_speedup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh1)
        
        local tttrsdh2 = xlib.makeslider{label = 'ttt_soda_shieldup (Def. 0.7)', repconvar = 'rep_ttt_soda_shieldup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh2)

        local tttrsdh3 = xlib.makeslider{label = 'ttt_soda_rageup (Def. 1.3)', repconvar = 'rep_ttt_soda_rageup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh3)
        
        local tttrsdh4 = xlib.makeslider{label = 'ttt_soda_shootup (Def. 1.5)', repconvar = 'rep_ttt_soda_shootup', min = 0, max = 3.5, decimal = 2, parent = tttrslst2}
        tttrslst2:AddItem(tttrsdh4)

        -- add to ULX
        xgui.hookEvent('onProcessModules', nil, tttrspnl.processModules)
        xgui.addSubModule('Super Soda', tttrspnl, nil, name)
    end)
end
