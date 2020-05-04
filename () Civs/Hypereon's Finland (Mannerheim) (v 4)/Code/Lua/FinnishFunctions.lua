--print("successfully loaded")

local civilizationID = GameInfoTypes["CIVILIZATION_FINNS"]

function Hyp_IsCivilizationActive(civilizationID)  --Thanks JFD
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end

	return false
end

if Hyp_IsCivilizationActive(civilizationID) then
	print("Marshal C.G.E. Mannerheim is in this game")
end

function BlockRuneSingers(playerID, unitID)
	if unitID == GameInfoTypes["UNIT_FINNIC_RUNE_SINGER"] then return false end
	return true
end
GameEvents.PlayerCanTrain.Add(BlockRuneSingers)

-------------------------------------------------------------------------------------------------
--KALEVALA PROMOTION
-------------------------------------------------------------------------------------------------

local Kalevala = GameInfoTypes.PROMOTION_KALEVALA --Strength from Culture per turn

function KalevalaCalc(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(Kalevala) then
			local iCultureRate = pPlayer:GetTotalJONSCulturePerTurn()
			if iCultureRate >= 50 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_FINNISH_SPIRIT"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_FINNISH_SPIRIT"], true)
				end	
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_FINNISH_SPIRIT"], false)
			end

			if iCultureRate >= 100 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"], true)
				end
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"], false)
			end

			if iCultureRate >= 150 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_KALEVALA"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_KALEVALA"], true)
				end	
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_KALEVALA"], false)
			end

			if iCultureRate >= 250 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_FINNISH_TOUGHNESS"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_FINNISH_TOUGHNESS"], true)
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_FINNISH_TOUGHNESS"], false)
			end

			if iCultureRate >= 500 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"], true)
				end
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"], false)
			end
		end
	end	
end	
end

------------------------------------------------------------------------------------
-- FINNISH TRAIT
------------------------------------------------------------------------------------
local numUnimprovedForests = 0

function Hyp_NumUnimprovedForests(playerID)
	local player = Players[playerID]
	if (player:GetCivilizationType() == civilizationID and player:IsAlive()) then
		for city in player:Cities() do
			for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
				local plot = city:GetCityIndexPlot(cityPlot)
				if plot ~= nil then
					if plot:GetOwner() == city:GetOwner() then
						if plot:GetFeatureType() == GameInfoTypes["FEATURE_FOREST"] then
							if plot:GetImprovementType(-1) then
								numUnimprovedForests = numUnimprovedForests + 1
							end
						end
						if plot:IsLake() then
							if city:IsHasBuilding() == GameInfoTypes["BUILDING_FINNISH_SAUNA"] then
								numUnimprovedForests = numUnimprovedForests + 1
							end
						end
						if plot:GetFeatureType() == GameInfoTypes["FEATURE_MARSH"] then
							if city:IsHasBuilding() == GameInfoTypes["BUILDING_FINNISH_SAUNA"] then
								numUnimprovedForests = numUnimprovedForests + 1
							end
						end
					end
				end
			--print ("Rune Singer points =" ..numUnimprovedForests)
			end
		end
	end
end

local RunePointMultiplier = 1

function Hyp_GiveRuneSingers(playerID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local pTeam = Teams[teamID]
	RunePointMultiplier = 1 + player:GetCurrentEra() 
	if player:GetCivilizationType() == civilizationID and player:IsEverAlive() and pTeam:IsHasTech(GameInfoTypes["TECH_WRITING"]) then
		if numUnimprovedForests > (150 * RunePointMultiplier) then
			player:AddFreeUnit(GameInfo.Units["UNIT_FINNIC_RUNE_SINGER"].ID, UNITAI_CULTURE)
			numUnimprovedForests = 0
		end
	end
end	

	GameEvents.PlayerDoTurn.Add(KalevalaCalc)
	GameEvents.PlayerDoTurn.Add(Hyp_NumUnimprovedForests)
	GameEvents.PlayerDoTurn.Add(Hyp_GiveRuneSingers)



		