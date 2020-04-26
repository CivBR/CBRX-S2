--================================================================================================================
-- Rio dela Plata Event scripts
--================================================================================================================
-- Utils
include("Leugi_GranColombia_Utils.lua")
print ("Latin America Events Scripts LOADED");

---------------------------
-- Variables
---------------------------
local AnarchyTurns				= 5
local IndependencePolicy		= GameInfoTypes["POLICY_PG_INDEPENDENCE"]
local NumUnits					= 3

local iGoldDevotion				= 150
local iFestivalTurns			= 10
local iTempleClass				= GameInfoTypes["BUILDINGCLASS_TEMPLE"]
local iReligionID				= GameInfoTypes["RELIGION_CATHOLICISM"]

--=================================================================================================================
--=================================================================================================================
-- Independencia!
---------------------------
local	Events_PG_LatinAmerican_Independence = {}
		Events_PG_LatinAmerican_Independence.Name	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE"
		Events_PG_LatinAmerican_Independence.Desc	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_DESC"
		Events_PG_LatinAmerican_Independence.EventImage = 'Event_LatinTriumph.dds'
		Events_PG_LatinAmerican_Independence.Weight = 8

-- Conditions:
-- · Check Civ
-- · Must only happen once
--------------------------
Events_PG_LatinAmerican_Independence.CanFunc = (
function(player)
	-- Check Industrial Era
	if player:GetCurrentEra() ~= GameInfoTypes["ERA_INDUSTRIAL"] then return false end
	-- Check if it happened once
	if player:HasPolicy(IndependencePolicy) == true then return false end
	-- Check Civ
	if IsLatino(player) == false then return false end
	-- DO IT! (If chances are met xD)
	--Events_PG_LatinAmerican_Independence.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_DESC")
	return true
end	
)

Events_PG_LatinAmerican_Independence.Outcomes = {}
-- Outcome 1
-- · Anarchy
-- · Gain Policy
---------------------------
	Events_PG_LatinAmerican_Independence.Outcomes[1]			= {}
	Events_PG_LatinAmerican_Independence.Outcomes[1].Name		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_OUTCOME_1"
	Events_PG_LatinAmerican_Independence.Outcomes[1].Desc		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_OUTCOME_RESULT_1"
	Events_PG_LatinAmerican_Independence.Outcomes[1].Weight		= 9

	Events_PG_LatinAmerican_Independence.Outcomes[1].CanFunc = (
	function (player)
		-- Create Description
		CivType = GameInfo.Civilizations[player:GetCivilizationType()].Type
		print(player:GetCivilizationType())
		print ("" .. CivType .. "")
		
		LibertadorID = GetLibertador(player)
		UUID = GetIndependenceUnits(player)

		local iTurns = math.ceil(AnarchyTurns * iMod)
		
		Events_PG_LatinAmerican_Independence.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_OUTCOME_RESULT_1", iTurns, GameInfo.Units[LibertadorID].Description, NumUnits, GameInfo.Units[UUID].Description)

		return true
	end
	)

	Events_PG_LatinAmerican_Independence.Outcomes[1].DoFunc = (
	function (player)
		CivType = GameInfo.Civilizations[player:GetCivilizationType()].Type
		
		LibertadorID = GetLibertador(player)
		UUID = GetIndependenceUnits(player)

		local iTurns = math.ceil(AnarchyTurns * iMod)
		
		--Anarchy
		player:ChangeAnarchyNumTurns(iTurns)

		-- Give Libertador
		InitUnitFromCity(player:GetCapitalCity(), LibertadorID, 1)
		
		-- Give Support Units
		InitUnitFromCity(player:GetCapitalCity(), UUID, NumUnits)
		
		-- Give Policy
		SetPolicy(player, IndependencePolicy, true)

		-- Alert the world!
		desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_INDEPENDENCE_OUTCOME_RESULT_1_NOTIFICATION", player:GetCivilizationDescription())
		Leugi_Notification(player, desc, -1, -1, -1)
		
	end
	)



--==============================================================================================================================================
--==============================================================================================================================================
-- Devóción!
---------------------------
local	Events_PG_LatinAmerican_Devotion = {}
		Events_PG_LatinAmerican_Devotion.Name	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION"
		Events_PG_LatinAmerican_Devotion.Desc	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_DESC"
		Events_PG_LatinAmerican_Devotion.EventImage = 'Event_LatinDevocion.dds'
		Events_PG_LatinAmerican_Devotion.Weight = 5
		
-- Conditions:
-- · Check CultureType
-- · Check Gold
-- · Check Religion in city
--------------------------
Events_PG_LatinAmerican_Devotion.CanFunc = (
function(player)
	-- Check Latino
	if IsLatino(player) == false then return false end
	-- Check Gold
	local iCost = math.ceil(iGoldDevotion * iMod)
	if player:GetGold() < iCost then return false end
	-- Check cities with Catholicism
	NumCatholics = 0
	for city in player:Cities() do
		if (city:GetReligiousMajority() == GameInfoTypes["RELIGION_CHRISTIANITY"]) then
			NumCatholics = NumCatholics + 1
		end
	end
	if NumCatholics < 1 then return false end
	-- Now we got to pick a Catholic City
	CatholicCities = {}
	for city in player:Cities() do
		if (city:GetReligiousMajority() == GameInfoTypes["RELIGION_CHRISTIANITY"]) then
			table.insert(CatholicCities, city)
		end
	end
	eCity = tablerandom(CatholicCities)
	ID = eCity:GetID()
	save (player, "Catholic City", ID)
	CityName = Locale.ConvertTextKey(eCity:GetName());
	RandDevotion = math.random(22)
	DevotionName = Locale.ConvertTextKey("TXT_KEY_PG_DEVOTION_NAME_" .. RandDevotion .. "")
	--print (DevotionName)
	-- DO IT! (If chances are met xD)
	Events_PG_LatinAmerican_Devotion.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_DESC", CityName, DevotionName)
	return true
end	
)

Events_PG_LatinAmerican_Devotion.Outcomes = {}
-- Outcome 1
-- · Lose Gold
-- · Start WLTKD
---------------------------
	Events_PG_LatinAmerican_Devotion.Outcomes[1]			= {}
	Events_PG_LatinAmerican_Devotion.Outcomes[1].Name		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_OUTCOME_1"
	Events_PG_LatinAmerican_Devotion.Outcomes[1].Desc		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_OUTCOME_RESULT_1"
	Events_PG_LatinAmerican_Devotion.Outcomes[1].Weight		= 10

	Events_PG_LatinAmerican_Devotion.Outcomes[1].CanFunc = (
	function (player)
		-- Create Description
		local iCost = math.ceil(iGoldDevotion * iMod)
		ID = load(player, "Catholic City")
		city = player:GetCityByID(ID);
		CityName = Locale.ConvertTextKey(city:GetName());
		if isPeC() then
			Events_PG_LatinAmerican_Devotion.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_OUTCOME_RESULT_FESTIVALS_1", iCost, CityName)
		else
			Events_PG_LatinAmerican_Devotion.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_OUTCOME_RESULT_1", iCost, CityName)
		end
		return true
	end
	)

	Events_PG_LatinAmerican_Devotion.Outcomes[1].DoFunc = (
	function (player)
		-- Gold
		local iCost = math.ceil(iGoldDevotion * iMod)
		player:ChangeGold(-iCost)
		-- Festival
		ID = load(player, "Catholic City")
		city = player:GetCityByID(ID);
		local wltkd = math.ceil((iFestivalTurns) * iMod)
		city:ChangeWeLoveTheKingDayCounter(wltkd)
		CityName = Locale.ConvertTextKey(city:GetName());
		-- Alert the world!
		iRelFest = GameInfo.Buildings.BUILDING_FESTIVAL_FAITH_02.ID
		if isPeC() then
			iWLTKD = city:GetWeLoveTheKingDayCounter()
			FestTitle =  Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_FESTIVAL",CityName)
			FestDesc =  Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_FESTIVAL_FAITH", CityName, iWLTKD)		
			city:SetNumRealBuilding(iRelFest, 1)
			nUnit = GameInfoTypes["UNIT_NOTIFICATION_FESTIVAL_FAITH_02"];
			plot = city:Plot()
			Leugi_Notification(player, FestDesc, FestTitle, nUnit, plot)
		end
		desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PG_LATINCOLONIAL_DEVOTION_OUTCOME_RESULT_1_NOTIFICATION", CityName)
		Leugi_Notification(player, desc, -1, -1, -1)
	end
	)

--=============================================================================================================================================================================

--=================================================================================================================
--=================================================================================================================
-- Caudillos
---------------------------
local	Events_PG_LatinAmerican_Caudillos = {}
		Events_PG_LatinAmerican_Caudillos.Name	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_CAUDILLOS"
		Events_PG_LatinAmerican_Caudillos.Desc	= "TXT_KEY_EVENT_PG_LATINCOLONIAL_CAUDILLOS_DESC"
		Events_PG_LatinAmerican_Caudillos.EventImage = 'Event_LatinCaudillos.dds'
		Events_PG_LatinAmerican_Caudillos.Weight = 5

-- Conditions:
-- · Check Civ
-- · Must only happen once
--------------------------
Events_PG_LatinAmerican_Caudillos.CanFunc = (
function(player)
	-- Check if it happened once
	if player:HasPolicy(IndependencePolicy) == false then return false end
	-- DO IT! (If chances are met xD)
	return true
end	
)

Events_PG_LatinAmerican_Caudillos.Outcomes = {}
-- Outcome 1

---------------------------
	Events_PG_LatinAmerican_Caudillos.Outcomes[1]			= {}
	Events_PG_LatinAmerican_Caudillos.Outcomes[1].Name		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_CAUDILLOS_OUTCOME_1"
	Events_PG_LatinAmerican_Caudillos.Outcomes[1].Desc		= "TXT_KEY_EVENT_PG_LATINCOLONIAL_CAUDILLOS_OUTCOME_RESULT_1"
	Events_PG_LatinAmerican_Caudillos.Outcomes[1].Weight		= 10

	Events_PG_LatinAmerican_Caudillos.Outcomes[1].CanFunc = (
	function (player)
		-- 
		
		return true
	end
	)

	Events_PG_LatinAmerican_Caudillos.Outcomes[1].DoFunc = (
	function (player)
		CivType = GameInfo.Civilizations[player:GetCivilizationType()].Type

		LibertadorID = GetLibertador(player)
		UUID = GetIndependenceUnits(player)

		local iTurns = math.ceil(AnarchyTurns * iMod * 1.5)
		
		--Anarchy
		city = player:GetCapitalCity()
		city:ChangeResistanceTurns(iTurns)

		local x = pPlayer:GetCapitalCity():GetX() + 1
		local y = pPlayer:GetCapitalCity():GetY() + 1
		Players[63]:InitUnit(UUID, x, y):JumpToNearestValidPlot()
		Players[63]:InitUnit(UUID, x, y):JumpToNearestValidPlot()
		Players[63]:InitUnit(UUID, x, y):JumpToNearestValidPlot()
		Players[63]:InitUnit(LibertadorID, x, y):JumpToNearestValidPlot()
		
	end
	)


--====================================================================================================================================================================
--====================================================================================================================================================================

local LatinoCivs = {}
for row in DB.Query("SELECT CivilizationType FROM Civilization_JFD_CultureTypes WHERE SplashScreenTag = 'JFD_ColonialLatin'") do
	table.insert(LatinoCivs, row.CivilizationType)
end
for loop, iCiv in ipairs(LatinoCivs) do
	print("Adding Latino Events for " .. iCiv .. "")
	Events_AddCivilisationSpecific(GameInfoTypes["" .. iCiv .. ""], "Events_PG_LatinAmerican_Independence", Events_PG_LatinAmerican_Independence)
	Events_AddCivilisationSpecific(GameInfoTypes["" .. iCiv .. ""], "Events_PG_LatinAmerican_Devotion", Events_PG_LatinAmerican_Devotion)
	Events_AddCivilisationSpecific(GameInfoTypes["" .. iCiv .. ""], "Events_PG_LatinAmerican_Caudillos", Events_PG_LatinAmerican_Caudillos)
end
