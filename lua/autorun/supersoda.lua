AddCSLuaFile()

CreateConVar( "soda_minspeedup", 1.5, FCVAR_SERVER_CAN_EXECUTE, "Set the minimum speed you can get after drinking the SpeedUp! soda" )
CreateConVar( "soda_maxspeedup", 1.75, FCVAR_SERVER_CAN_EXECUTE, "Set the maximum speed you can get after drinking the SpeedUp! soda." )
CreateConVar( "soda_shieldup", 0.80, FCVAR_SERVER_CAN_EXECUTE, "How much damage do you get after drinking the ShieldUp! soda (0.80 = 80%, 0.60 = 60% etc.)" )
CreateConVar( "soda_ragedup", 1.20, FCVAR_SERVER_CAN_EXECUTE, "How much damage do you deal after drinking the RageUp! soda (1.20 = 120%, 1.40 = 140% etc.)" )

local smin = GetConVar( "soda_minspeedup" )
local smax = GetConVar( "soda_maxspeedup" )
local sshield = GetConVar( "soda_shieldup" )
local srage = GetConVar( "soda_ragedup" )

local sodatbl = { "soda_yellow", "soda_red", "soda_blue" }
	
hook.Add( "PostPlayerDeath", "resetstats", function( ply )
	
	ply.DrankYellow = false
	ply.DrankRed = false
	ply.DrankBlue = false

end)

hook.Add( "PlayerSpawn", "resetstats", function( ply )

	ply.DrankYellow = false
	ply.DrankRed = false
	ply.DrankBlue = false

end)

hook.Add("TTTPlayerSpeedModifier", "SuperSpeed" , function(ply)

	if ( ply.DrankYellow == true ) then
		return ( math.random( smin:GetFloat(), smax:GetFloat() ) )
	end

end)

hook.Add("EntityTakeDamage", "DecreaseDamage", function( target, dmginfo ) 

	if ( target.DrankBlue == true ) then
		dmginfo:SetDamage( dmginfo:GetDamage()*sshield:GetFloat() )
	end

end)

hook.Add("EntityTakeDamage", "IncreaseDamage", function( target, dmginfo ) 

	if ( dmginfo:GetAttacker().DrankRed == true ) then
		dmginfo:SetDamage( dmginfo:GetDamage()*srage:GetFloat() )
	end

end)

if SERVER then

local function RandomSoda()
	

	local spawns = ents.FindByClass( "item_*" )
	
	if (#spawns) > 0 then
		
		local spwn = spawns[ math.random( #spawns ) ]
		local soda = ents.Create( sodatbl[ math.random( #sodatbl ) ] )
		
		soda:SetPos( spwn:GetPos() )
		soda:Spawn()
		spwn:Remove()

	end

end

hook.Add("TTTBeginRound", "SpawnSoda" , RandomSoda )

end

hook.Add( "KeyPress", "UseMe", function( ply, key )
	
	local ent = ply:GetEyeTrace().Entity

	if ( key == IN_USE ) then
		
		if table.HasValue( sodatbl, ent:GetClass() ) then
		
		local dist = ply:GetPos():Distance( ent:GetPos() )
		
			if dist < 50 then
				UseFix( ent, ply )	
			end
		
		end
	
	end

end )

function UseFix( ent, ply )

	if ent:GetClass() == "soda_blue" then
		ply.DrankBlue = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the ShieldUp! soda! Get less damage!' )
	
	elseif ent:GetClass() == "soda_red" then
		ply.DrankRed = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the RageUp! soda! Deal more damage!' )
	
	elseif ent:GetClass() == "soda_yellow" then
		ply.DrankYellow = true
		sound.Play( "sodacan/opencan.wav", ply:GetPos(), 60 )
		ent:Remove()
		ply:ChatPrint( 'You found the SpeedUp! soda! Move faster!' )
	end
	
end

function VersionCheck()
print( "V. 1.003; 15.02.17, 00:10" )
print( "V. 1.004; 25.12.18, 14:28" )
end
concommand.Add( "debug_sodaversion", VersionCheck )