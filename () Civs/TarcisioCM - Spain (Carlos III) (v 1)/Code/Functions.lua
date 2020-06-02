include("IconSupport.lua")
include("InfoTooltipInclude.lua")
include("PlotIterators.lua")
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "TarcisioCMCarlosIII";
--==========================================================================================================================
-- UA
--==========================================================================================================================
local targetUnit
local targetPlayer
function GreatPersonBorn(playerID, unitID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"] then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:IsGreatPerson() then
			local oldNum = load(player, "tcmSpainNumberGreatPeople")
			local currentNum = player:GetGreatPeopleCreated()
			if not(oldNum) then
				oldNum = 0
			end
			local greenlight = false
			if currentNum > oldNum then
				greenlight = true
			end
			if player:GetFaith() == 0 and unit:GetUnitType() == GameInfoTypes["UNIT_PROPHET"] then
				greenlight = true
			end
			if unit:GetUnitType() == GameInfoTypes["UNIT_GREAT_GENERAL"] or unit:GetUnitType() == GameInfoTypes["UNIT_GREAT_ADMIRAL"] then
				greenlight = false
			end
			if greenlight == true then
				local plot = unit:GetPlot()
				for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					local city = loopPlot:GetPlotCity()
					if city then 
						if player:IsHuman() then
							targetUnit = unit
							targetPlayer = player
							LuaEvents.tcmExpendGreatPerson()
						end
						break
					end
				end
			end
			save(player, "tcmSpainNumberGreatPeople", currentNum)
		end
	end
end
Events.SerialEventUnitCreated.Add(GreatPersonBorn)
--==========================================================================================================================
function ShowPopup()
	Controls.TCMExpendGreatPersonPopupBG:SetHide(false)
	Controls.TCMExpendGreatPersonPopup:SetHide(false)

	local unitName = targetUnit:GetName()
	local text = Locale.ConvertTextKey("TXT_KEY_TCM_BOURBON_SPAIN_UA_POPUP", unitName)
	Controls.Message:SetText(text)
end
LuaEvents.tcmExpendGreatPerson.Add(function() ShowPopup() end)
--==========================================================================================================================
function OnAccept()
	Controls.TCMExpendGreatPersonPopupBG:SetHide(true)
	Controls.TCMExpendGreatPersonPopup:SetHide(true)	

	targetPlayer:ChangeNumFreePolicies(1)
	targetUnit:Kill()
end
Controls.Accept:RegisterCallback(Mouse.eLClick, OnAccept)

function OnRefuse()
	Controls.TCMExpendGreatPersonPopupBG:SetHide(true)
	Controls.TCMExpendGreatPersonPopup:SetHide(true)	
end
Controls.Refuse:RegisterCallback(Mouse.eLClick, OnRefuse)

IconHookup(23, 80, "CIV_COLOR_ATLAS", Controls.DialogTopIcon)
--==========================================================================================================================
function tradeRouteIdentifier(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"] then
		local listOfCities = {}
		local listOfCitiesWithTradeRoute = {}
		if player:CountNumBuildings(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"]) > 0 then
			for city in player:Cities() do
				local plot = city:Plot()
				local targetPlotX = load(plot, "tcmCityHasInternalTradeRouteToX")
				local targetPlotY = load(plot, "tcmCityHasInternalTradeRouteToY")
				local targetPlot
				if targetPlotX and targetPlotY then
					targetPlot = Map.GetPlot(targetPlotX, targetPlotY)
				end
				if city:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"]) then
					if targetPlot then
						local targetCity = targetPlot:GetPlotCity()
						if targetCity then
							local lastGreatPerson = load(plot, "tcmLastPickedGreatPerson")
							if lastGreatPerson == "Merchant" or lastGreatPerson == nil then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MERCHANT"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MERCHANT"], numSpecialists)
							elseif lastGreatPerson == "Engineer" then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ENGINEER"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ENGINEER"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ENGINEER"], numSpecialists)
							elseif lastGreatPerson == "Scientist" then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_SCIENTIST"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_SCIENTIST"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_SCIENTIST"], numSpecialists)
							elseif lastGreatPerson == "Writer" then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_WRITER"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_WRITER"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_WRITER"], numSpecialists)
							elseif lastGreatPerson == "Artist" then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ARTIST"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ARTIST"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ARTIST"], numSpecialists)
							elseif lastGreatPerson == "Musician" then
								local numSpecialists = (city:GetNumSpecialistsInBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MUSICIAN"]) * 3) * 100
								city:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MUSICIAN"], -numSpecialists)
								targetCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MUSICIAN"], numSpecialists)
							end
						end
					end
					table.insert(listOfCities, city)
					save(plot, "tcmCityHasInternalTradeRouteToX", nil)
					save(plot, "tcmCityHasInternalTradeRouteToY", nil)
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"], 0)
				end

			end
		end
		local tradeRoutes = player:GetTradeRoutes()
		for tradeRouteID, tradeRoute in ipairs(tradeRoutes) do
			if tradeRoute.FromID == tradeRoute.ToID then
				local originatingCity = tradeRoute.FromCity
				local targetCity = tradeRoute.ToCity
				local gold = ((tradeRoute.ToFood + tradeRoute.ToProduction) / 100) + originatingCity:GetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"])
				originatingCity:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"], gold)
				local plot = originatingCity:Plot()
				local otherPlot = targetCity:Plot()
				local otherPlotX = otherPlot:GetX()
				local otherPlotY = otherPlot:GetY()
				save(plot, "tcmCityHasInternalTradeRouteToX", otherPlotX)
				save(plot, "tcmCityHasInternalTradeRouteToY", otherPlotY)
				if load(plot, "tcmLastPickedGreatPerson") == nil then
					save(plot, "tcmLastPickedGreatPerson", "Merchant")
				end
				table.insert(listOfCitiesWithTradeRoute, originatingCity)
				if not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"])) and not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ENGINEER"])) and not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_SCIENTIST"])) and not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MUSICIAN"])) and not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_WRITER"])) and not(originatingCity:IsHasBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ARTIST"])) then
					originatingCity:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"], 1)
				end
				
			end
		end
		if listOfCities then
			for key,city in pairs(listOfCities) do 
				local remove = true
				if listOfCitiesWithTradeRoute then
					for key,originatingCity in pairs(listOfCitiesWithTradeRoute) do 
						if city == originatingCity then
							remove = false
						end
					end
				end
				if remove == true then
					tcmRemoveEverything(city)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(tradeRouteIdentifier)
--==========================================================================================================================
-- Walloon Guard Related
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- walloonGuardSpawning
----------------------------------------------------------------------------------------------------------------------------
function walloonGuardSpawning(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"] then
		if player:CanTrain(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"]) then
			for city in player:Cities() do
				if city:IsPuppet() and not(city:IsResistance()) then
					local turnsLeft = city:GetUnitProductionTurnsLeft(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"])
					if turnsLeft <= 1 then
						if not(player:IsHuman()) then
							InitUnitFromCity(city, GameInfoTypes["UNIT_TCM_WALLOON_GUARD"], 1)
						else
							local plot = city:Plot()
							if load(plot, "walloonExpendedForHeal") == nil then
								InitUnitFromCity(city, GameInfoTypes["UNIT_TCM_WALLOON_GUARD"], 1)
							else
								for unit in player:Units() do
									if unit:GetUnitType() == GameInfoTypes["UNIT_TCM_WALLOON_GUARD"] then
										unit:ChangeExperience(5)
										unit:ChangeDamage(-30)
									end
								end
							end
						end
						city:SetUnitProduction(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"], 0)
					else
						local productionChange = math.ceil(((city:GetBaseYieldRate(yieldProductionID) + (city:GetBaseYieldRate(yieldProductionID)*city:GetProductionModifier(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"]))/100)) * 66)
						city:ChangeUnitProduction(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"], productionChange)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(walloonGuardSpawning)
----------------------------------------------------------------------------------------------------------------------------
-- InitUnitFromCity <-- This one's JFD
----------------------------------------------------------------------------------------------------------------------------
function InitUnitFromCity(pCity, iUnitType, iNum)
	pPlayer = Players[pCity:GetOwner()]
	for i = 1, iNum do
		pUnit = pPlayer:InitUnit(iUnitType, pCity:GetX(), pCity:GetY())
		pUnit:SetExperience(pCity:GetDomainFreeExperience(pUnit:GetDomainType()))
		for promotion in GameInfo.UnitPromotions() do
			iPromotion = promotion.ID
				if (pCity:GetFreePromotionCount(iPromotion) > 0 and pUnit:IsPromotionValid(iPromotion)) then
				pUnit:SetHasPromotion(iPromotion, true)
			end
		end
	end
end
--==========================================================================================================================
-- Santisima Trinidad Related
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- disableFrigate
----------------------------------------------------------------------------------------------------------------------------
function disableFrigate(playerID, unitTypeID)
	if unitTypeID == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1"] or unitTypeID == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_2"] or unitTypeID == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_3"] then
		return false
	else
		return true
	end
end
GameEvents.PlayerCanTrain.Add(disableFrigate)
----------------------------------------------------------------------------------------------------------------------------
-- FrigateUpgrade
----------------------------------------------------------------------------------------------------------------------------
function FrigateUpgrade(playerId, unitId, newUnitId, bGoodyHut)
	local player = Players[playerId]
	local newUnit = player:GetUnitByID(newUnitId)
	if newUnit:GetUnitType() == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_HUGE_COST_1"] then
		local unit = player:GetUnitByID(unitId)
		if unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_2"]) then
			newerUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE"], unit:GetX(), unit:GetY())
			newerUnit:Convert(newUnit)
			newerUnit:SetMoves(0)

			local damage = unit:GetDamage()
			newerUnit:SetDamage(damage)
			newerUnit:SetLevel(unit:GetLevel())
			newerUnit:SetExperience(unit:GetExperience())

			for promotion in GameInfo.UnitPromotions() do
				if unit:IsHasPromotion(promotion.ID) then
					newerUnit:SetHasPromotion(GameInfoTypes[promotion.Type], true)
				end
			end

			newerUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_3"], true)
			newerUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_2"], false)
		elseif unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_1"]) then
			newerUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD"], unit:GetX(), unit:GetY())
			newerUnit:Convert(newUnit)
			newerUnit:SetMoves(0)

			local damage = unit:GetDamage()
			newerUnit:SetDamage(damage)
			newerUnit:SetLevel(unit:GetLevel())
			newerUnit:SetExperience(unit:GetExperience())

			for promotion in GameInfo.UnitPromotions() do
				if unit:IsHasPromotion(promotion.ID) then
					newerUnit:SetHasPromotion(GameInfoTypes[promotion.Type], true)
				end
			end

			newerUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_2"], true)
			newerUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_1"], false)
		elseif not(unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_3"])) then
			newerUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD"], unit:GetX(), unit:GetY())
			newerUnit:Convert(newUnit)
			newerUnit:SetMoves(0)

			local damage = unit:GetDamage()
			newerUnit:SetLevel(unit:GetLevel())
			newerUnit:SetDamage(damage)
			newerUnit:SetExperience(unit:GetExperience())

			for promotion in GameInfo.UnitPromotions() do
				if unit:IsHasPromotion(promotion.ID) then
					newerUnit:SetHasPromotion(GameInfoTypes[promotion.Type], true)
				end
			end

			newerUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_1"], true)
		end
	elseif newUnit:GetUnitType() == GameInfoTypes["UNIT_BATTLESHIP"] then
		local unit = player:GetUnitByID(unitId)
		if unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_1"]) or unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_2"]) or unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_3"]) then
			newUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_1"], false)
			newUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_2"], false)
			newUnit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_SPANISH_SHIP_3"], false)
		end
	end
end
GameEvents.UnitUpgraded.Add(FrigateUpgrade)
----------------------------------------------------------------------------------------------------------------------------
-- researchBattleships
----------------------------------------------------------------------------------------------------------------------------
function researchBattleships(eTeam, eTech, iChange)
	local battleshipTech = GameInfo.Units["UNIT_BATTLESHIP"].PrereqTech
	if eTech == GameInfo.Technologies[battleshipTech].ID then
		local team = Teams[eTeam]
		local playerID = team:GetLeaderID()
		local player = Players[playerID]
		for unit in player:Units() do
			if unit:GetUnitType() == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD"] then
				local moves = unit:GetMoves()
				newUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE"], unit:GetX(), unit:GetY())
				newUnit:Convert(unit)
				newUnit:SetMoves(moves)
			end
		end
	end
end
GameEvents.TeamTechResearched.Add(researchBattleships)
----------------------------------------------------------------------------------------------------------------------------
-- updateToUpgradeableVersion
----------------------------------------------------------------------------------------------------------------------------
local battleshipTech = GameInfo.Units["UNIT_BATTLESHIP"].PrereqTech

function updateToUpgradeableVersion(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if not unit then return end
	if unit:GetUnitType() == GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD"] then
		local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
		if teamTechs:HasTech(GameInfoTypes[battleshipTech]) then
			newUnit = player:InitUnit(GameInfoTypes["UNIT_TCM_SANTISIMA_TRINIDAD_UPGRADEABLE"], unit:GetX(), unit:GetY())
			newUnit:Convert(unit)
			newUnit:SetMoves(unit:GetMoves())
		end
	end
end
Events.SerialEventUnitCreated.Add(updateToUpgradeableVersion)
--==========================================================================================================================
-- UI FUNCTIONS
-- This code was adapted from JFD's Sardinia-Piedmont, thus it has his name all around.
--==========================================================================================================================
local isCityViewOpen = false
----------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdatePurchaseOptions
----------------------------------------------------------------------------------------------------------------------------
function JFD_UpdatePurchaseOptions()
	Controls.UnitBackground:SetHide(true)
	Controls.UnitImage:SetHide(true)
	Controls.UnitButton:SetDisabled(true)
	Controls.UnitButton:LocalizeAndSetToolTip(nil)

	Controls.GoldBackground:SetHide(true)
	Controls.GoldButton:SetDisabled(true)
	Controls.GoldButton:LocalizeAndSetToolTip(nil)

	Controls.SpecialistBackground:SetHide(true)
	Controls.SpecialistButton:SetDisabled(true)
	Controls.SpecialistButton:LocalizeAndSetToolTip(nil)
	
	local city = UI.GetHeadSelectedCity()
	if city then
		local playerID = city:GetOwner()
		local player = Players[playerID]
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"] then
			local plot = city:Plot()
			if load(plot, "tcmCityHasInternalTradeRouteToX") ~= nil then
				local targetPlotX = load(plot, "tcmCityHasInternalTradeRouteToX")
				local targetPlotY = load(plot, "tcmCityHasInternalTradeRouteToY")
				local targetPlot = Map.GetPlot(targetPlotX, targetPlotY)
				local targetCity = targetPlot:GetPlotCity()

				local specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_MERCHANT")
				if load(plot, "tcmLastPickedGreatPerson") == "Engineer" then
					specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_ENGINEER")
				elseif load(plot, "tcmLastPickedGreatPerson") == "Scientist" then
					specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_SCIENTIST")
				elseif load(plot, "tcmLastPickedGreatPerson") == "Writer" then
					specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_WRITER")
				elseif load(plot, "tcmLastPickedGreatPerson") == "Artist" then
					specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_ARTIST")
				elseif load(plot, "tcmLastPickedGreatPerson") == "Musician" then
					specialistButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_MUSICIAN")
				end
				Controls.SpecialistButton:SetText(specialistButtonText)

				local civName
				if targetCity then
					civName = targetCity:GetName()
				else
					civName = "nowhere"
				end
				local specialistToolTip = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_UA_CHANGE_SLOT_TOOLTIP", civName)
				Controls.SpecialistButton:LocalizeAndSetToolTip(specialistToolTip)

				Controls.SpecialistBackground:SetHide(false)
				Controls.SpecialistButton:SetDisabled(false)
				Controls.GoldBackground:SetHide(false)
				local goldFromInternalTradeRoutes = city:GetNumBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_GOLD_DUMMY"])
				local goldButtonText = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_UA_GOLD", goldFromInternalTradeRoutes)
				local goldToolTip = Locale.ConvertTextKey("TXT_KEY_CIV_TCM_BOURBON_SPAIN_UA_GOLD_TOOLTIP", goldFromInternalTradeRoutes)
				Controls.GoldButton:LocalizeAndSetToolTip(goldToolTip)
				Controls.GoldButton:SetText(goldButtonText)
			end
			if city:IsPuppet() and city:GetResistanceTurns() <= 0 then
				if player:CanTrain(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"]) then
					Controls.UnitBackground:SetHide(false)
					Controls.UnitImage:SetHide(false)
					Controls.UnitButton:SetDisabled(false)
					Controls.UnitButton:LocalizeAndSetToolTip(nil)

					local walloonGuardID = GameInfo.Units["UNIT_TCM_WALLOON_GUARD"]
					local turnsLeft = math.ceil(city:GetUnitProductionTurnsLeft(GameInfoTypes["UNIT_TCM_WALLOON_GUARD"]))
					turnsLeft = turnsLeft + math.ceil(turnsLeft * 0.66)
					local unitButtonText = Locale.ConvertTextKey("TXT_KEY_TCM_WALLOON_GUARD_TURNS_LEFT", turnsLeft)
					IconHookup(walloonGuardID.PortraitIndex, 64, walloonGuardID.IconAtlas, Controls.UnitImage)
					Controls.UnitButton:SetText(unitButtonText)
					Controls.UnitBackground:SetHide(false)
					Controls.UnitImage:SetHide(false)

					local plot = city:Plot()
					local toolTip 
					if load(plot, "walloonExpendedForHeal") == nil then
						toolTip = Locale.ConvertTextKey("TXT_KEY_TCM_WALLOON_GUARDS_SPAWN")
					else
						toolTip = Locale.ConvertTextKey("TXT_KEY_TCM_WALLOON_GUARDS_EXPEND")
					end
					Controls.UnitButton:LocalizeAndSetToolTip(toolTip)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- TCM_SlotOnClick
----------------------------------------------------------------------------------------------------------------------------
function TCM_SlotOnClick()
	local city = UI.GetHeadSelectedCity();
	if city then
		local plot = city:Plot()
		if load(plot, "tcmCityHasInternalTradeRouteToX") ~= nil then
			tcmRemoveEverything(city)
			local lastGreatPerson = load(plot, "tcmLastPickedGreatPerson")
			if lastGreatPerson == "Merchant" or lastGreatPerson == nil then
				save(plot, "tcmLastPickedGreatPerson", "Engineer")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ENGINEER"], 1)
			elseif lastGreatPerson == "Engineer" then
				save(plot, "tcmLastPickedGreatPerson", "Scientist")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_SCIENTIST"], 1)
			elseif lastGreatPerson == "Scientist" then
				save(plot, "tcmLastPickedGreatPerson", "Writer")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_WRITER"], 1)
			elseif lastGreatPerson == "Writer" then
				save(plot, "tcmLastPickedGreatPerson", "Artist")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ARTIST"], 1)
			elseif lastGreatPerson == "Artist" then
				save(plot, "tcmLastPickedGreatPerson", "Musician")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MUSICIAN"], 1)
			elseif lastGreatPerson == "Musician" then
				save(plot, "tcmLastPickedGreatPerson", "Merchant")
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"], 1)
			end
			
		end
	end
	JFD_UpdatePurchaseOptions()
end
Controls.SpecialistButton:RegisterCallback(Mouse.eLClick, TCM_SlotOnClick)

function tcmRemoveEverything(city)
	local buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ENGINEER"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_SCIENTIST"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_WRITER"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ARTIST"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	buildingID = GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MUSICIAN"]
	if city:GetNumSpecialistsInBuilding(buildingID) > 0 then
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
		city:DoTask(TaskTypes.TASK_REMOVE_SPECIALIST, 0, buildingID, 0)
	end
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ENGINEER"], 0)
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_SCIENTIST"], 0)
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MERCHANT"], 0)
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_WRITER"], 0)
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_ARTIST"], 0)
	city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_BOURBON_SPAIN_MUSICIAN"], 0)
	city:DoReallocateCitizens()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnPurchase
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnClick()
	local city = UI.GetHeadSelectedCity();
	if city then
		if city:IsPuppet() then
			local plot = city:Plot()
			if load(plot, "walloonExpendedForHeal") == nil then
				save(plot, "walloonExpendedForHeal", true)
			else
				save(plot, "walloonExpendedForHeal", nil)
			end
		end
	end
	JFD_UpdatePurchaseOptions()
end
Controls.UnitButton:RegisterCallback(Mouse.eLClick, JFD_OnClick)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnEnterCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_UpdatePurchaseOptions()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnExitCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_UpdatePurchaseOptions()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnNextCityScren
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnNextCityScren()
	if isCityViewOpen then
		JFD_UpdatePurchaseOptions()
	end
end
Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScren)
--==========================================================================================================================
--==========================================================================================================================


function decisionCultureForTraining(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	local player = Players[ownerId]
	if player:HasPolicy(GameInfoTypes["POLICY_TCM_BOURBON_PACTE"]) then
		local culture = math.ceil(player:GetJONSCulturePerTurnFromCities() / 2)
		player:ChangeJONSCulture(culture)
	end
end
GameEvents.CityTrained.Add(decisionCultureForTraining)

function strengthForAllies(playerID)
	local player = Players[playerID]
	if player:HasPolicy(GameInfoTypes["POLICY_TCM_BOURBON_PACTE"]) then
		for unit in player:Units() do
			local plot = unit:GetPlot()
			local owner = plot:GetOwner()
			if owner then
				if player:IsDoF(owner) then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_BOURBON_PACT"], true)
				else
					for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						for i = 0, loopPlot:GetNumUnits() - 1, 1 do  
							local otherUnit = loopPlot:GetUnit(i)
							if otherUnit and player:IsDoF(otherUnit:GetOwner()) and otherUnit:IsCombatUnit() then
								unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_BOURBON_PACT"], true)
								break
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn(strengthForAllies)
