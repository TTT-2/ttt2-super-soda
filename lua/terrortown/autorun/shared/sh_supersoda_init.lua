if SERVER then
	-- make sure the addon is synced to the client (this is somehow needed for the entities, don't ask me why)
	resource.AddWorkshop("1815518231")

	resource.AddFile("materials/vgui/ttt/hud_icon_soda_speedup.png");
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_ragedup.png");
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_shootup.png");
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_jumpup.png");

	resource.AddFile("materials/models/props_junk/can_healup");
	resource.AddFile("materials/models/props_junk/can_armorup");
	resource.AddFile("materials/models/props_junk/can_creditup");
	resource.AddFile("materials/models/props_junk/can_shootup");
	resource.AddFile("materials/models/props_junk/can_speedup");
	resource.AddFile("materials/models/props_junk/can_rageup");
	resource.AddFile("materials/models/props_junk/can_jumpup");

	resource.AddFile("sound/sodacan/opencan.wav");
end

if CLIENT then
	hook.Add("TTT2FinishedLoading", "supersoda_init_icon", function()
		STATUS:RegisterStatus("soda_speedup", {
			hud = Material("vgui/ttt/hud_icon_soda_speedup.png"),
			type = "good",
			name = "soda_speedup",
			sidebarDescription = "soda_speedup_desc"
		})
		STATUS:RegisterStatus("soda_rageup", {
			hud = Material("vgui/ttt/hud_icon_soda_rageup.png"),
			type = "good",
			name = "soda_rageup",
			sidebarDescription = "soda_rageup_desc"
		})
		STATUS:RegisterStatus("soda_shootup", {
			hud = Material("vgui/ttt/hud_icon_soda_shootup.png"),
			type = "good",
			name = "soda_shootup",
			sidebarDescription = "soda_shootup_desc"
		})
		STATUS:RegisterStatus("soda_jumpup", {
			hud = Material("vgui/ttt/hud_icon_soda_jumpup.png"),
			type = "good",
			name = "soda_jumpup",
			sidebarDescription = "soda_jumpup_desc"
		})
	end)
end
