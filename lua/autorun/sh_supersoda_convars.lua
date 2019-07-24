CreateConVar( "ttt_soda_speedup", 1.75, FCVAR_SERVER_CAN_EXECUTE, "Set the speed you can get after drinking the SpeedUp! soda. (1.5 = 150%, 1.75 = 175% etc.)" )
CreateConVar( "ttt_soda_shieldup", 0.70, FCVAR_SERVER_CAN_EXECUTE, "How much damage do you get after drinking the ShieldUp! soda (0.80 = 80%, 0.60 = 60% etc.)" )
CreateConVar( "ttt_soda_ragedup", 1.30, FCVAR_SERVER_CAN_EXECUTE, "How much damage do you deal after drinking the RageUp! soda (1.20 = 120%, 1.40 = 140% etc.)" )

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