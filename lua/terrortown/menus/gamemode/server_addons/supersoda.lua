CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "submenu_addons_supersoda_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_supersoda_basic")

	form:MakeSlider({
		label = "label_soda_total_spawn_amount",
		serverConvar = "ttt_soda_total_spawn_amount",
		min = 0,
		max = 25,
		decimal = 0
	})

	form:MakeCheckBox({
		label = "label_soda_limit_one_per_player",
		serverConvar = "ttt_soda_limit_one_per_player"
	})

	local form2 = vgui.CreateTTT2Form(parent, "header_addons_supersoda_multiplier")

	form2:MakeSlider({
		label = "label_soda_speedup",
		serverConvar = "ttt_soda_speedup",
		min = 0,
		max = 3.5,
		decimal = 2
	})

	form2:MakeSlider({
		label = "label_soda_rageup",
		serverConvar = "ttt_soda_rageup",
		min = 0,
		max = 3.5,
		decimal = 2
	})

	form2:MakeSlider({
		label = "label_soda_shootup",
		serverConvar = "ttt_soda_shootup",
		min = 0,
		max = 3.5,
		decimal = 2
	})

	local form3 = vgui.CreateTTT2Form(parent, "header_addons_supersoda_instant")

	form3:MakeSlider({
		label = "label_soda_armorup",
		serverConvar = "ttt_soda_armorup",
		min = 0,
		max = 100,
		decimal = 0
	})

	form3:MakeSlider({
		label = "label_soda_healup",
		serverConvar = "ttt_soda_healup",
		min = 0,
		max = 100,
		decimal = 0
	})

	form3:MakeSlider({
		label = "label_soda_creditup",
		serverConvar = "ttt_soda_creditup",
		min = 0,
		max = 100,
		decimal = 0
	})

	local form4 = vgui.CreateTTT2Form(parent, "header_addons_supersoda_weight")

	form4:MakeHelp({
		label = "help_soda_spawn_disable"
	})

	form4:MakeSlider({
		label = "label_soda_speedup_sweight",
		serverConvar = "ttt_soda_speedup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_rageup_sweight",
		serverConvar = "ttt_soda_rageup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_shootup_sweight",
		serverConvar = "ttt_soda_shootup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_jumpup_sweight",
		serverConvar = "ttt_soda_jumpup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_armorup_sweight",
		serverConvar = "ttt_soda_armorup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_healup_sweight",
		serverConvar = "ttt_soda_healup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})

	form4:MakeSlider({
		label = "label_soda_creditup_sweight",
		serverConvar = "ttt_soda_creditup_sweight",
		min = 0,
		max = 10,
		decimal = 0
	})
end
