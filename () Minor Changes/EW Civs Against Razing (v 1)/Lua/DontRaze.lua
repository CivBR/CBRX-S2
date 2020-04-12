local ewBias = 1

function EW_DontRaze(playerID)
	local ewPlayer = Players[playerID]
	local ewCiv = ewPlayer:GetCivilizationType()
	local ewTrueCiv = GameInfo.Civilizations[ewCiv].Type
	local ewLeader = 0
	for row in GameInfo.Civilization_Leaders("CivilizationType = '" .. ewTrueCiv .. "'") do
		ewLeader = row.LeaderheadType
	end
	if not ewPlayer:IsHuman() then
		for row in GameInfo.Leader_Flavors("LeaderType = '" .. ewLeader .. "' AND FlavorType = 'FLAVOR_HAPPINESS'") do
			ewBias = row.Flavor
		end
		local ewHappy = ewPlayer:GetHappiness()
		for ewCity in ewPlayer:Cities() do
			if ewCity:IsRazing() then
				local ewRaze = ewCity:GetRazingTurns()
				if (ewHappy) > (-10 / ewBias) then
					ewCity:ChangeRazingTurns(-ewRaze)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(EW_DontRaze)