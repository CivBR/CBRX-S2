-- Tourism_Handler
-- Author: UltimatePotato
-- Modified by Sukritact
--=======================================================================================================================
-- Prevent Duplicates
--=======================================================================================================================
if MapModData.Tourism_Handler then return end
MapModData.Tourism_Handler = true
Events.SequenceGameInitComplete.Add(function() MapModData.Tourism_Handler = nil end)
--=======================================================================================================================

include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Tourism_Handler";
print("loaded")

--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
local iDummy1 	 	=	GameInfoTypes.BUILDING_TOURISMHANDLER_1 
local iDummy2 		=	GameInfoTypes.BUILDING_TOURISMHANDLER_2 
local iDummy4 		=	GameInfoTypes.BUILDING_TOURISMHANDLER_4 
local iDummy8 		=	GameInfoTypes.BUILDING_TOURISMHANDLER_8 
local iDummy16		=	GameInfoTypes.BUILDING_TOURISMHANDLER_16
local iDummy32 		=	GameInfoTypes.BUILDING_TOURISMHANDLER_32
local iDummy64 		=	GameInfoTypes.BUILDING_TOURISMHANDLER_64
local iDummy128		=	GameInfoTypes.BUILDING_TOURISMHANDLER_128
local iDummy256		=	GameInfoTypes.BUILDING_TOURISMHANDLER_256
local iDummy512  	=	GameInfoTypes.BUILDING_TOURISMHANDLER_512
local iDummy1024 	=	GameInfoTypes.BUILDING_TOURISMHANDLER_1024
local iDummy2048 	=	GameInfoTypes.BUILDING_TOURISMHANDLER_2048
local iDummy4096	=	GameInfoTypes.BUILDING_TOURISMHANDLER_4096
local iDummy8192 	=	GameInfoTypes.BUILDING_TOURISMHANDLER_8192
--=======================================================================================================================
-- Main Code
--=======================================================================================================================
function toBits(iNum)
    -- returns a table of bits, least significant first.
    tTable = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,} -- will contain the bits
    local iKey = 1
    while iNum > 0 do
        local iRest = math.fmod(iNum, 2)
        tTable[iKey] = iRest
        iKey = iKey + 1
        iNum = (iNum - iRest) / 2
    end
    return tTable
end

function TourismHandler(pCity, iNum)
	tTable = toBits(math.floor(iNum + 0.5))
	pCity:SetNumRealBuilding(iDummy1, 	 tTable[1])
	pCity:SetNumRealBuilding(iDummy2, 	 tTable[2])
	pCity:SetNumRealBuilding(iDummy4, 	 tTable[3])
	pCity:SetNumRealBuilding(iDummy8, 	 tTable[4])
	pCity:SetNumRealBuilding(iDummy16,	 tTable[5])
	pCity:SetNumRealBuilding(iDummy32, 	 tTable[6])
	pCity:SetNumRealBuilding(iDummy64, 	 tTable[7])
	pCity:SetNumRealBuilding(iDummy128,  tTable[8])
	pCity:SetNumRealBuilding(iDummy256,	 tTable[9])
    pCity:SetNumRealBuilding(iDummy512,  tTable[10])
    pCity:SetNumRealBuilding(iDummy1024, tTable[11])
    pCity:SetNumRealBuilding(iDummy2048, tTable[12])
    pCity:SetNumRealBuilding(iDummy4096, tTable[13])
    pCity:SetNumRealBuilding(iDummy8192, tTable[14])
end

function ChangeTourism(pCity, iNum)
	local pPlayer = Players[pCity:GetOwner()]
	local iCity = pCity:GetID()
	
	local iTourismSum = load(pPlayer, iCity)
	if not(iTourismSum) then iTourismSum = 0 end
	
	iTourismSum = iTourismSum + iNum
	
	if iTourismSum < 0 then iTourismSum = 0 end
	if iTourismSum > 16383 then iTourismSum = 16383 end
	
	TourismHandler(pCity, iTourismSum)
	save(pPlayer, iCity, iTourismSum)
end
LuaEvents.ChangeTourism.Add(ChangeTourism)

function SetTourism(pCity, iNum)
	local pPlayer = Players[pCity:GetOwner()]
	local iCity = pCity:GetID()
	
	if iTourismSum < 0 then iTourismSum = 0 end
	if iTourismSum > 16383 then iTourismSum = 16383 end
	
	TourismHandler(pCity, iTourismSum)
	save(pPlayer, iCity, iTourismSum)
end
LuaEvents.SetTourism.Add(SetTourism)
--=======================================================================================================================
--=======================================================================================================================