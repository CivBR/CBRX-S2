--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
MapModData.CBRX					= MapModData.CBRX or {}
CBRX							= MapModData.CBRX

CBRX.JFD_RTP					= CBRX.JFD_RTP or {}
JFD_RTP							= CBRX.JFD_RTP

CBRX.PARG_War					= CBRX.PARG_War or {}
PARG_War						= CBRX.PARG_War
CBRX.PARG_Recent				= CBRX.PARG_Recent or {}
PARG_Recent						= CBRX.PARG_Recent

CBRX.JFD_SwedenKarlXII			= CBRX.JFD_SwedenKarlXII or {}
JFD_SwedenKarlXII				= CBRX.JFD_SwedenKarlXII
JFD_SwedenKarlXII.FoodStorage	= JFD_SwedenKarlXII.FoodStorage or {}
FoodStorage						= JFD_SwedenKarlXII.FoodStorage

CBRX.JFD_RTP_CyclesOfPower		= CBRX.JFD_RTP_CyclesOfPower or {}
JFD_RTP_CyclesOfPower			= CBRX.JFD_RTP_CyclesOfPower

CBRX.JFD_RTP_Epithets			= CBRX.JFD_RTP_Epithets or {}
JFD_RTP_Epithets				= CBRX.JFD_RTP_Epithets

CBRX.JFD_RTP_Sovereignty		= CBRX.JFD_RTP_Sovereignty or {}
JFD_RTP_Sovereignty				= CBRX.JFD_RTP_Sovereignty

CBRX.THP_Mandukhai				= CBRX.THP_Mandukhai or {}
THP_Mandukhai					= CBRX.THP_Mandukhai
THP_Mandukhai.UnitHomeCities	= THP_Mandukhai.UnitHomeCities or {}
UnitHomeCities					= THP_Mandukhai.UnitHomeCities
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================
-- CACHING
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
include("TableSaverLoader016.lua");

tableRoot = CBRX
tableName = "CBRX"

include("CBRX_TSL_TSLSerializerV3.lua");

TableLoad(tableRoot, tableName)

print("LIME TESTING - Running OnModLoaded")

function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)
	TableSave(tableRoot, tableName)
end
OnModLoaded()

print("LIME TESTING - OnModLoaded has been run")
--==========================================================================================================================
--==========================================================================================================================