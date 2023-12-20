-- handle looking at sodas
hook.Add("TTTRenderEntityInfo", "ttt2_supersoda_highlight_sodas", function(tData)
	local client = LocalPlayer()
	local ent = tData:GetEntity()

	if not IsValid(client) or not client:IsTerror() or not client:Alive() then return end

	if not IsValid(ent) or tData:GetEntityDistance() > 100 then return end

	local soda_class = ent:GetClass()

	if not table.HasValue(SUPERSODA.sodas, soda_class) then return end -- no valid soda

	-- enable targetID rendering
	tData:EnableText()
	tData:EnableOutline()
	tData:SetOutlineColor(client:GetRoleColor())

	tData:SetTitle(ent.PrintName)
	tData:SetSubtitle(LANG.GetParamTranslation("ttt_pickup_soda", {usekey = Key("+use", "USE")}))
	tData:SetKeyBinding("+use")
	tData:AddDescriptionLine(LANG.GetTranslation("ttt_pickup_" .. soda_class))

	-- add extra information
	if GetGlobalBool("ttt_soda_limit_one_per_player") and client:SodaAmountDrunk() >= 1 then
		tData:AddDescriptionLine(
			LANG.GetTranslation("ttt_drank_soda_limit_reached"),
			COLOR_ORANGE
		)

		return
	end

	if ent.soda_type == "SINGLEUSE" and client:HasDrunkSoda(soda_class) then
		tData:AddDescriptionLine(
			LANG.GetTranslation("ttt_drank_soda_already_drunk"),
			COLOR_ORANGE
		)

		return
	end

	if ent.soda_type ~= "SINGLEUSE" then
		tData:AddDescriptionLine(
			LANG.GetTranslation("ttt_drank_soda_unlimted"),
			COLOR_LGRAY
		)
	end
end)
