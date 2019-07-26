if SERVER then
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
        STATUS:RegisterStatus('soda_ragedup', {
            hud = Material('vgui/ttt/hud_icon_soda_ragedup.png'),
            type = 'good'
        })
        STATUS:RegisterStatus('soda_shootup', {
            hud = Material('vgui/ttt/hud_icon_soda_shootup.png'),
            type = 'good'
        })
    end)
end