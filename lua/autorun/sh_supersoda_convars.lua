CreateConVar( "ttt_soda_speedup", 1.75, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Set the speed you can get after drinking the SpeedUp! soda. (1.5 = 150%, 1.75 = 175% etc.)" )
CreateConVar( "ttt_soda_shieldup", 0.70, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much damage do you get after drinking the ShieldUp! soda (0.80 = 80%, 0.60 = 60% etc.)" )
CreateConVar( "ttt_soda_ragedup", 1.30, {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How much damage do you deal after drinking the RageUp! soda (1.20 = 120%, 1.40 = 140% etc.)" )

hook.Add('TTTUlxInitCustomCVar', 'TTTSuperSodaInitRWCVar', function(name)
    ULib.replicatedWritableCvar('ttt_soda_speedup', 'rep_ttt_soda_speedup', GetConVar('ttt_soda_speedup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_shieldup', 'rep_ttt_soda_shieldup', GetConVar('ttt_soda_shieldup'):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar('ttt_soda_ragedup', 'rep_ttt_soda_ragedup', GetConVar('ttt_soda_ragedup'):GetFloat(), true, false, name)
end)

if SERVER then
    -- ConVar replication is broken in GMod, so we do this, at least Alf added a hook!
    -- I don't like it any more than you do, dear reader. Copycat!
    hook.Add('TTT2SyncGlobals', 'ttt2_supersoda_sync_convars', function()
        SetGlobalFloat("ttt_soda_speedup", GetConVar("ttt_soda_speedup"):GetFloat())
        SetGlobalFloat("ttt_soda_shieldup", GetConVar("ttt_soda_shieldup"):GetFloat())
        SetGlobalFloat("ttt_soda_ragedup", GetConVar("ttt_soda_ragedup"):GetFloat())
    end)

    -- sync convars on change
    cvars.AddChangeCallback("ttt_soda_speedup", function(cv, old, new)
        SetGlobalFloat("ttt_soda_speedup", tonumber(new))
    end)
    cvars.AddChangeCallback("ttt_soda_shieldup", function(cv, old, new)
        SetGlobalFloat("ttt_soda_shieldup", tonumber(new))
    end)
    cvars.AddChangeCallback("ttt_soda_ragedup", function(cv, old, new)
        SetGlobalFloat("ttt_soda_ragedup", tonumber(new))
    end)
end

if CLIENT then
	hook.Add('TTTUlxModifySettings', 'TTTSupersodaModifySettings', function(name)
		local tttrspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

		-- Chat Messages 
		local tttrsclp = vgui.Create('DCollapsibleCategory', tttrspnl)
		tttrsclp:SetSize(390, 100)
		tttrsclp:SetExpanded(1)
		tttrsclp:SetLabel('Mulipliers')

		local tttrslst = vgui.Create('DPanelList', tttrsclp)
		tttrslst:SetPos(5, 25)
		tttrslst:SetSize(390, 100)
		tttrslst:SetSpacing(5)

		local tttrsdh1 = xlib.makeslider{label = 'ttt_soda_speedup (Def. 1.75)', repconvar = 'rep_ttt_soda_speedup', min = 0, max = 2.5, decimal = 2, parent = tttrslst}
		tttrslst:AddItem(tttrsdh1)

        local tttrsdh2 = xlib.makeslider{label = 'ttt_soda_shieldup (Def. 0.7)', repconvar = 'rep_ttt_soda_shieldup', min = 0, max = 2.5, decimal = 2, parent = tttrslst}
        tttrslst:AddItem(tttrsdh2)

        local tttrsdh3 = xlib.makeslider{label = 'ttt_soda_ragedup (Def. 1.3)', repconvar = 'rep_ttt_soda_ragedup', min = 0, max = 2.5, decimal = 2, parent = tttrslst}
		tttrslst:AddItem(tttrsdh3)

		xgui.hookEvent('onProcessModules', nil, tttrspnl.processModules)
		xgui.addSubModule('Super Soda', tttrspnl, nil, name)
    end)
end