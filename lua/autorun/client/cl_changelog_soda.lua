hook.Add("TTT2AddChange", "TTT2_role_supersoda_changelog", function()
	AddChange("TTT2 SuperSoda - v1.0", [[
		<ul>
			<li>Initial Release</li>
			<li>Available Sodas:</li>
			<ul>
				<li>SpeedUp!: Increases your default speed multiplier and makes you faster.</li>
				<li>ShieldUp!: Reduces the damage taken.</li>
				<li>RagedUp!: Increases your damage dealt to other players.</li>
				<li>ShootUp!: Increases your shooting speed.</li>
			</ul>
		</ul>
	]], os.time({year = 2019, month = 07, day = 25}))

	AddChange("TTT2 SuperSoda - v1.1", [[
		<ul>
			<li>Completely retextured all sodas</li>
			<li>Reworked ShieldUp! to ArmorUp! to use the new armor system</li>
			<li>New Sodas:</li>
			<ul>
				<li>ArmorUp!: Gives you armor points.</li>
				<li>HealUp!: Gives you health points.</li>
				<li>CreditUp!: Gives you equipment credits.</li>
			</ul>
			<li>The new sodas are all multi-drinkable since they give no status effect, but an instant effect</li>
		</ul>
	]], os.time({year = 2019, month = 10, day = 07}))

	AddChange("TTT2 SuperSoda - v1.2", [[
		<ul>
			<li>Added new JumpUp soda, thanks @LeBroomer</li>
			<ul>
				<li>Gives you a doublejump when drunk</li>
				<li>Adds a fourth jump to bluebull when used together</li>
			</ul>
			<li>Improved the spawn to stop removing ammo, thanks @LeBroomer</li>
			<li>Introduced spawn weights to tweak the amount of spawned sodas per type</li>
			<li>Fixed a bug of the shootup soda in combination with other wepaon modifying perks</li>
		</ul>
	]], os.time({year = 2019, month = 10, day = 13}))
end)
