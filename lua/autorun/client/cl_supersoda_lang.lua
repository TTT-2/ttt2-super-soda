if CLIENT then
    hook.Add('Initialize', 'ttt2_supersoda_init_lang', function()
        -- ENGLISH
        LANG.AddToLanguage('English', 'ttt_drank_soda_speedup', 'You found the SpeedUp!™ can! Move faster!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_ragedup', 'You found the RageUp!™ can! Deal more damage!')
        LANG.AddToLanguage('English', 'ttt_drank_soda_shieldup', 'You found the ShieldUp!™ can! Get less damage!')
    end)
end