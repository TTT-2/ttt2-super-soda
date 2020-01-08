local key_params = {
	usekey = Key('+use', 'USE'),
	walkkey = Key('+walk', 'WALK')
}

-- handle looking at sodas
hook.Add('TTTRenderEntityInfo', 'ttt2_supersoda_highlight_sodas', function(data, params)
	local client = LocalPlayer()
	local soda_class = data.ent:GetClass()

	if data.distance > 100 then return end
	if not table.HasValue(SUPERSODA.sodas, soda_class) then return end -- no valid soda
	if not IsValid(client) or not client:IsTerror() or not client:Alive() then return end

	params.drawInfo = true
	params.displayInfo.key = input.GetKeyCode(input.LookupBinding('+use'))
	params.displayInfo.title.text = LANG.GetTranslation(soda_class)
	params.displayInfo.subtitle.text = LANG.GetParamTranslation('ttt_pickup_soda', key_params)

	params.displayInfo.desc = {
		{text = LANG.GetTranslation('ttt_pickup_' .. soda_class), color = COLOR_WHITE}
	}

	params.drawOutline = true
	params.outlineColor = client:GetRoleColor()

	-- add extra information
	if data.ent.soda_type == 'SINGLEUSE' and client:HasDrunkSoda(soda_class) then
		params.displayInfo.desc[#params.displayInfo.desc + 1] = {text = LANG.GetTranslation('ttt_drank_soda_already_drunk'), color = COLOR_ORANGE}

		return
	end

	if GetGlobalBool('ttt_soda_limit_one_per_player') and client:SodaAmountDrunk() >= 1 then
		params.displayInfo.desc[#params.displayInfo.desc + 1] = {text = LANG.GetTranslation('ttt_drank_soda_limit_reached'), color = COLOR_ORANGE}

		return
	end

	if data.ent.soda_type ~= 'SINGLEUSE' then
		params.displayInfo.desc[#params.displayInfo.desc + 1] = {text = LANG.GetTranslation('ttt_drank_soda_unlimted'), color = COLOR_LGRAY}
	end
end)
