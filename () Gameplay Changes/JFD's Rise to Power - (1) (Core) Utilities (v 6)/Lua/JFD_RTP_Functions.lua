-- JFD_RTP_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("JFD_RTP_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--g_Buildings_MustBeCapital_Table
local g_Buildings_MustBeCapital_Table = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE MustBeCapital = 1;") do 	
	g_Buildings_MustBeCapital_Table[row.ID] = true
end

--g_Buildings_RequiresPantheon_Table
local g_Buildings_RequiresPantheon_Table = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE RequiresPantheon = 1;") do 	
	g_Buildings_RequiresPantheon_Table[row.ID] = true
end

--JFD_RTP_CityCanConstruct
local function JFD_RTP_CityCanConstruct(playerID, cityID, buildingID)
	local player = Players[playerID]
	local building = GameInfo.Buildings[buildingID]
	local city = player:GetCityByID(cityID)
	
	if g_Buildings_MustBeCapital_Table[buildingID] then
		if (not city:IsCapital()) then
			return false
		end
	end

	if g_Buildings_RequiresPantheon_Table[buildingID] then
		if (not player:HasCreatedPantheon()) then
			return false
		end
	end
	
	return true
end
GameEvents.CityCanConstruct.Add(JFD_RTP_CityCanConstruct)
--==========================================================================================================================
--==========================================================================================================================