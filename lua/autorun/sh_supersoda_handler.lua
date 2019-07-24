local sodatbl = { "soda_yellow", "soda_red", "soda_blue" }

if SERVER then
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_yellow.png");
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_blue.png");
	resource.AddFile("materials/vgui/ttt/hud_icon_soda_red.png");
	resource.AddFile("sound/sodacan/opencan.wav");
end

if CLIENT then
	hook.Add("Initialize", "supersoda_init_icon", function()
		STATUS:RegisterStatus("supersoda_yellow", {
			hud = Material("vgui/ttt/hud_icon_soda_yellow.png"),
			type = "good",
			DrawInfo = function() return tostring(math.Round(GetGlobalFloat("ttt_soda_speedup"), 2)*100) end
		})
		STATUS:RegisterStatus("supersoda_blue", {
			hud = Material("vgui/ttt/hud_icon_soda_blue.png"),
			type = "good",
			DrawInfo = function() return tostring(math.Round(GetGlobalFloat("ttt_soda_shieldup"), 2)*100) end
		})
		STATUS:RegisterStatus("supersoda_red", {
			hud = Material("vgui/ttt/hud_icon_soda_red.png"),
			type = "good",
			DrawInfo = function() return tostring(math.Round(GetGlobalFloat("ttt_soda_ragedup"), 2)*100) end
		})
	end)
end

hook.Add("PostPlayerDeath", "resetstats", function(ply)
	ply.DrankYellow = false
	ply.DrankRed = false
	ply.DrankBlue = false
end)

hook.Add("PlayerSpawn", "resetstats", function(ply)
	ply.DrankYellow = false
	ply.DrankRed = false
	ply.DrankBlue = false
end)

hook.Add("TTTPlayerSpeedModifier", "SuperSpeed" , function(ply)
	if ply.DrankYellow then
		return GetConVar("ttt_soda_speedup"):GetFloat()
	end
end)

hook.Add("EntityTakeDamage", "DecreaseDamage", function(target, dmginfo) 
	if target.DrankBlue then
		dmginfo:SetDamage(dmginfo:GetDamage() * GetConVar("ttt_soda_shieldup"):GetFloat())
	end
end)

hook.Add("EntityTakeDamage", "IncreaseDamage", function(target, dmginfo) 
	if dmginfo:GetAttacker().DrankRed then
		dmginfo:SetDamage(dmginfo:GetDamage() * GetConVar("ttt_soda_ragedup"):GetFloat())
	end
end)

if SERVER then
	local function SpawnRandomSoda()
		local spawns = ents.FindByClass("item_*")
		
		if (#spawns) > 0 then
			
			local spwn = spawns[ math.random( #spawns ) ]
			local soda = ents.Create( sodatbl[ math.random( #sodatbl ) ] )
			
			soda:SetPos( spwn:GetPos() )
			soda:Spawn()
			spwn:Remove()

		end
	end
	hook.Add("TTTBeginRound", "SpawnSoda" , SpawnRandomSoda)

end

hook.Add( "KeyPress", "UseMe", function(ply, key)
	local ent = ply:GetEyeTrace().Entity

	if ( key == IN_USE ) then
		
		if table.HasValue( sodatbl, ent:GetClass() ) then
		
		local dist = ply:GetPos():Distance( ent:GetPos() )
			if dist < 50 then
				UseFix( ent, ply )	
			end
		end
	end
end)

function UseFix( ent, ply )
	if ent:GetClass() == "soda_blue" then

		ply.DrankBlue = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the ShieldUp! soda! Get less damage!' )
		STATUS:AddStatus()

		if SERVER then STATUS:AddStatus(ply, 'supersoda_blue') end
	
	elseif ent:GetClass() == "soda_red" then

		ply.DrankRed = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the RageUp! soda! Deal more damage!' )

		if SERVER then STATUS:AddStatus(ply, 'supersoda_red') end
	
	elseif ent:GetClass() == "soda_yellow" then

		ply.DrankYellow = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the SpeedUp! soda! Move faster!' )

		if SERVER then STATUS:AddStatus(ply, 'supersoda_yellow') end
	end
end

function VersionCheck()
	print( "TTT2 - V. 1.0.0" )
end
concommand.Add( "debug_sodaversion", VersionCheck )