if SERVER then
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_speedup.png');
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_shieldup.png');
    resource.AddFile('materials/vgui/ttt/hud_icon_soda_ragedup.png');
    resource.AddFile('sound/sodacan/opencan.wav');
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
    end)
end