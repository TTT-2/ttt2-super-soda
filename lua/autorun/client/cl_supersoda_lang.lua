if CLIENT then
    hook.Add('Initialize', 'ttt2_supersoda_init_lang', function()
        -- ENGLISH
        LANG.AddToLanguage('English', 'ttt_drank_soda_already_drunk', 'You can drink each soda only once.')
        LANG.AddToLanguage('English', 'ttt_drank_soda_limit_reached', 'You can drink only one soda!')
        LANG.AddToLanguage('English', 'ttt_spawned_soda', 'There are {amount} super sodas this round. Pick them up to get some perks!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_speedup', 'You found the SpeedUp!™ can! Move faster!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_ragedup', 'You found the RageUp!™ can! Deal more damage!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_shieldup', 'You found the ShieldUp!™ can! Get less damage!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_shootup', 'You found the ShootUp!™ can! Shoot Faster!')
    end)
end