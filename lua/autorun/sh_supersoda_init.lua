if SERVER then
    -- make sure the addon is synced to the client (this is somehow needed for the entities, don't ask me why)
    resource.AddWorkshop('1815518231')

    resource.AddFile('materials/vgui/ttt/hud_icon_soda_speedup.png');
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_shieldup.png');
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_ragedup.png');
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_shootup.png');
    resource.AddFile('sound/sodacan/opencan.wav');

    resource.AddFile('materials/models/props_junk/popcan01a_phong');
    resource.AddFile('materials/models/props_junk/popcan02a_phong');
    resource.AddFile('materials/models/props_junk/popcan03a_phong');
    resource.AddFile('materials/models/props_junk/popcan04a_phong');
    resource.AddFile('materials/models/props_junk/popcan05a_phong');
    resource.AddFile('materials/models/props_junk/popcan06a_phong');
end

if CLIENT then
    hook.Add('Initialize', 'supersoda_init_icon', function()
        STATUS:RegisterStatus('soda_speedup', {
            hud = Material('vgui/ttt/hud_icon_soda_speedup.png'),
            type = 'good'
        })
        STATUS:RegisterStatus('soda_shieldup', {
            hud = Material('vgui/ttt/hud_icon_soda_shieldup.png'),
            type = 'good'
        })
        STATUS:RegisterStatus('soda_rageup', {
            hud = Material('vgui/ttt/hud_icon_soda_rageup.png'),
            type = 'good'
        })
        STATUS:RegisterStatus('soda_shootup', {
            hud = Material('vgui/ttt/hud_icon_soda_shootup.png'),
            type = 'good'
        })
    end)
end