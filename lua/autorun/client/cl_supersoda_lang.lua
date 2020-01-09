if CLIENT then
	hook.Add("Initialize", "ttt2_supersoda_init_lang", function()
		-- ENGLISH
		LANG.AddToLanguage("English", "ttt_drank_soda_already_drunk", "You can drink each soda only once.")
		LANG.AddToLanguage("English", "ttt_drank_soda_limit_reached", "You can drink only one soda!")
		LANG.AddToLanguage("English", "ttt_drank_soda_cant_pickup", "You can't drink or pickup anything right now.")
		LANG.AddToLanguage("English", "ttt_drank_soda_unlimted", "Instant effect sodas can be drunk infinite times.")
		LANG.AddToLanguage("English", "ttt_spawned_soda", "There are {amount} super sodas this round. Pick them up to get some perks!")

		LANG.AddToLanguage("English", "ttt_drank_soda_speedup", "You found the SpeedUp!™ can! Move faster!")
		LANG.AddToLanguage("English", "ttt_drank_soda_rageup", "You found the RageUp!™ can! Deal more damage!")
		LANG.AddToLanguage("English", "ttt_drank_soda_shootup", "You found the ShootUp!™ can! Shoot Faster!")
		LANG.AddToLanguage("English", "ttt_drank_soda_jumpup", "You found the JumpUp!™ can! You can now jump twice!")
		LANG.AddToLanguage("English", "ttt_drank_soda_armorup", "You found the ArmorUp!™ can! You received extra armor points!")
		LANG.AddToLanguage("English", "ttt_drank_soda_healup", "You found the HealUp!™ can! You received extra health points!")
		LANG.AddToLanguage("English", "ttt_drank_soda_creditup", "You found the creditUp!™ can! You received extra equipment credits!")

		LANG.AddToLanguage("English", "ttt_pickup_soda_speedup", "You will move faster after drinking this soda")
		LANG.AddToLanguage("English", "ttt_pickup_soda_rageup", "You will deal more damage after drinking this soda")
		LANG.AddToLanguage("English", "ttt_pickup_soda_shootup", "You will shoot faster after drinking this soda")
		LANG.AddToLanguage("English", "ttt_pickup_soda_jumpup", "You can jump twice after drinking this soda")
		LANG.AddToLanguage("English", "ttt_pickup_soda_armorup", "You receive extra armor points by drinking this soda [INSTANT]")
		LANG.AddToLanguage("English", "ttt_pickup_soda_healup", "You receive extra health points by drinking this soda [INSTANT]")
		LANG.AddToLanguage("English", "ttt_pickup_soda_creditup", "You receive extra equipment credits by drinking this soda [INSTANT]")

		LANG.AddToLanguage("English", "ttt_pickup_soda", "Press [{usekey}] to drink soda")
	end)
end
