

local iCiv = GameInfoTypes.CIVILIZATION_SENSHI_MANCHU
local iSecondAttackPromo = GameInfoTypes.PROMOTION_SECOND_ATTACK
local iSenshiBannerBonusPromo = GameInfoTypes.PROMOTION_SENSHI_BANNER_BONUS
local iUnitSenshiBannerman = GameInfoTypes.UNIT_SENSHI_BANNERMAN

-------------------------------------------------------------------------------------------------------
--[[

1)	Set Up the table for the Banner Promotions

]]--
-------------------------------------------------------------------------------------------------------

local Banners = {
    [1] = GameInfoTypes.PROMOTION_SENSHI_BANNER_1,
    [2] = GameInfoTypes.PROMOTION_SENSHI_BANNER_2,
    [3] = GameInfoTypes.PROMOTION_SENSHI_BANNER_3,
    [4] = GameInfoTypes.PROMOTION_SENSHI_BANNER_4,
    [5] = GameInfoTypes.PROMOTION_SENSHI_BANNER_5,
    [6] = GameInfoTypes.PROMOTION_SENSHI_BANNER_6,
    [7] = GameInfoTypes.PROMOTION_SENSHI_BANNER_7,
    [8] = GameInfoTypes.PROMOTION_SENSHI_BANNER_8
}

-------------------------------------------------------------------------------------------------------
--[[

1)	Set Up the data for the Unit Types that should get Banner Promotions
2)	Just enter the default unit within each unit-class, like as shown for the recon and melee
	and gunpowder units
3)	Since I was not sure which class the UNIT_SENSHI_BANNERMAN will belong to:
	a)	I gave that unit its own specific entry
	b)	this is okay because of the method the code uses to fill in all other units
		from within the same unit-class
4)	Any units gifted by City-States should get covered by this code
5)	If CIVILIZATION_SENSHI_MANCHU captures a unit I don't remember whether this causes the UnitCreated
	events to fire
6)	Add Naval Units, Archer Units, Mounted, Armor, etc., as desired.
7)	Remove any unit listed and no unit from within that class of units will qualify for
	the Bannerman Promotions. 

]]--
-------------------------------------------------------------------------------------------------------

local tValidBannerUnits = { [GameInfoTypes.UNIT_LANCER] = "true",
	[GameInfoTypes.UNIT_HORSEMAN] = "true",
	[GameInfoTypes.UNIT_COMPOSITE_BOWMAN] = "true",
	[GameInfoTypes.UNIT_WWI_TANK] = "true",
	[GameInfoTypes.UNIT_MACHINE_GUN] = "true",
	[GameInfoTypes.UNIT_GATLINGGUN] = "true",
	[GameInfoTypes.UNIT_MECH] = "true",
	[GameInfoTypes.UNIT_MODERN_ARMOR] = "true",
	[GameInfoTypes.UNIT_HELICOPTER_GUNSHIP] = "true",
	[GameInfoTypes.UNIT_MOBILE_SAM] = "true",
	[GameInfoTypes.UNIT_ROCKET_ARTILLERY] = "true",
	[GameInfoTypes.UNIT_TANK] = "true",
	[GameInfoTypes.UNIT_ARTILLERY] = "true",
	[GameInfoTypes.UNIT_ANTI_AIRCRAFT_GUN] = "true",
	[GameInfoTypes.UNIT_ANTI_TANK_GUN] = "true",
	[GameInfoTypes.UNIT_CAVALRY] = "true",
	[GameInfoTypes.UNIT_CANNON] = "true",
	[GameInfoTypes.UNIT_TREBUCHET] = "true",
	[GameInfoTypes.UNIT_KNIGHT] = "true",
	[GameInfoTypes.UNIT_CROSSBOWMAN] = "true",
	[GameInfoTypes.UNIT_CATAPULT] = "true",
	[GameInfoTypes.UNIT_CHARIOT_ARCHER] = "true",
	[GameInfoTypes.UNIT_ARCHER] = "true",
	[GameInfoTypes.UNIT_BAZOOKA] = "true",
	[GameInfoTypes.UNIT_SCOUT] = "true",
	[GameInfoTypes.UNIT_WARRIOR] = "true",
	[GameInfoTypes.UNIT_SPEARMAN] = "true",
	[GameInfoTypes.UNIT_PIKEMAN] = "true",
	[GameInfoTypes.UNIT_GERMAN_LANDSKNECHT] = "true",
	[GameInfoTypes.UNIT_SWORDSMAN] = "true",
	[GameInfoTypes.UNIT_LONGSWORDSMAN] = "true",
	[GameInfoTypes.UNIT_MUSKETMAN] = "true",
	[GameInfoTypes.UNIT_SENSHI_GREEN_STANDARD] = "true",
	[GameInfoTypes.UNIT_RIFLEMAN] = "true",
	[GameInfoTypes.UNIT_GREAT_WAR_INFANTRY] = "true",
	[GameInfoTypes.UNIT_INFANTRY] = "true",
	[GameInfoTypes.UNIT_MARINE] = "true",
	[GameInfoTypes.UNIT_MECHANIZED_INFANTRY] = "true",
	[GameInfoTypes.UNIT_PARATROOPER] = "true",
	[GameInfoTypes.UNIT_XCOM_SQUAD] = "true"
}

-------------------------------------------------------------------------------------------------------
--Following is for Enlightenment Era Compatibility
--Delete the ones for any "classes" of units you don't want
--for the purposes of this lua, mod load order is not important because lua happens after SQL/XML
-------------------------------------------------------------------------------------------------------
for row in GameInfo.Units("Type='UNIT_EE_EXPLORER'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_LINE_INFANTRY'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_SKIRMISHER'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_SURVEYOR'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_FIELD_GUN'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_UHLAN'") do
	tValidBannerUnits[row.ID] = "true"
end
for row in GameInfo.Units("Type='UNIT_EE_CUIRASSIER'") do
	tValidBannerUnits[row.ID] = "true"
end







--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--	Functions Used as Toolkit Items and 'called' by other functions within the code
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


-------------------------------------------------------------------------------------------------------
-- GetUnitsInAdjacentPlotsWithPromotion

--[[

1)	Data sent for sFrienEmies can be:
	a)	"SamePlayer"	unit owner has to be same as iPlayer
	b)	"Enemies"	unit owner has to be at war with iPlayer
	c)	"Friends"	unit owner cannot be at war with iPlayer
	d)	nil (ie, nothing specified)
		this defaults to same as "SamePlayer"
2)	Data sent for sFrienEmies can be:
	a)	"boolean"	routine returns "true" on encountering 1st qualifying unit
	b)	"table"		all qualifying unit objects are stored in an lua-table and this table is the 'return' value
	c)	"integer"	an integer count is kept of all qualifying units and this integer count is the 'return' value
	d)	nil (ie, nothing specified)
		this defaults to same as "boolean"

]]--

-------------------------------------------------------------------------------------------------------

function GetUnitsInAdjacentPlotsWithPromotion(pPlot, iPromotion, iPlayer, sFrienEmies, sReturnType)
	local tUnitsFound = {}
	local iNumUnitsFound = 0
	local pPlayer = Players[iPlayer]
	local iPlayersTeamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[iPlayersTeamID]
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local pAdjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
		if pAdjacentPlot and pAdjacentPlot:IsUnit() then
			for i = 0, pAdjacentPlot:GetNumUnits() do
				local pAdjacentUnit = pAdjacentPlot:GetUnit(i)
				if pAdjacentUnit and pAdjacentUnit:IsHasPromotion(iPromotion) then
					local bCountUnit = false
					if pAdjacentUnit:GetOwner() == iPlayer then
						if (sFrienEmies == "SamePlayer") or (sFrienEmies == nil) then
							if (sReturnType == "boolean") or (sReturnType == nil) then
								return true
							else
								bCountUnit = true
							end
						end
					else
						if pPlayerTeam:IsAtWar(Players[pAdjacentUnit:GetOwner()]:GetTeam()) then
							if sFrienEmies == "Enemies" then
								if (sReturnType == "boolean") or (sReturnType == nil) then
									return true
								else
									bCountUnit = true
								end
							end
						else
							if sFrienEmies == "Friends" then
								if (sReturnType == "boolean") or (sReturnType == nil) then
									return true
								else
									bCountUnit = true
								end
							end
						end
					end
					if  bCountUnit then
						if (sReturnType == "table") then
							table.insert(tUnitsFound, pAdjacentUnit)
						else	--defaulters get counted as integers
							iNumUnitsFound = iNumUnitsFound + 1
						end
					end
				end
			end
		end
	end
	if (sReturnType == "boolean") or (sReturnType == nil) then
		return false
	elseif (sReturnType == "table") then
		return tUnitsFound
	else
		return iNumUnitsFound
	end
end

-------------------------------------------------------------------------------------------------------
-- AddAllItemsInSameClassToTable
-- All All Items In Same Classes To Defined Table
-------------------------------------------------------------------------------------------------------
function AddAllItemsInSameClassToTable(tTableName, sDataType)
	if sDataType == "Units" then
		for iUnit,sData in pairs(tTableName) do
			local sUnitClass = GameInfo.Units[iUnit].Class
			for UnitRow in GameInfo.Units("Class='" .. sUnitClass .. "'") do
				if not tTableName[UnitRow.ID] then
					tTableName[UnitRow.ID] = sData
				end
			end
		end
	elseif sDataType == "Buildings" then
		for iBuilding,vData in pairs(tTableName) do
			local sBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
			for BuildingRow in GameInfo.Buildings("BuildingClass='" .. sBuildingClass .. "'") do
				if not tTableName[BuildingRow.ID] then
					tTableName[BuildingRow.ID] = vData
				end
			end
		end

	end
end
----------------------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
-- Gets a Random Number from the Game.Rand method
-- cures the irksome issues with the way the Game.Rand method selects a random number
-- with JFD's code you always get a number between 'lower' and 'upper' and including both 'lower' and 'upper' as possible results
----------------------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------
---- WilliamHoward's IsCivInPlay
------------------------------------------------------------
function IsCivInPlay(iCivType)
  for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local iSlotStatus = PreGame.GetSlotStatus(iSlot)
    if (iSlotStatus == SlotStatus.SS_TAKEN or iSlotStatus == SlotStatus.SS_COMPUTER) then
      if (PreGame.GetCivilization(iSlot) == iCivType) then
        return true
      end
    end
  end
  
  return false
end


--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--	Functions Directly Hooked to Game Events
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-------------------------------------------------------------------------------------------------------
--SetBanner adds the banner promotions to appropriate units on unit creation
-------------------------------------------------------------------------------------------------------
function SetBanner(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if(pPlayer == nil or
		pUnit == nil or
		pUnit:IsDead()) then
		return
	end
	if pPlayer:GetCivilizationType() == iCiv then
		if tValidBannerUnits[pUnit:GetUnitType()] then
			pUnit:SetHasPromotion(Banners[JFD_GetRandom(1, #Banners)], true)
		end
	end
end
-------------------------------------------------------------------------------------------------------
--SetBanner adds the banner promotions to appropriate units on unit creation
-------------------------------------------------------------------------------------------------------

function BannerAffectsEveryTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if not pPlayer:IsBarbarian() then
		for pUnit in pPlayer:Units() do
			local bUnitIsSenshiBannerman = (pUnit:GetUnitType() == iUnitSenshiBannerman)
			pUnit:SetHasPromotion(iSenshiBannerBonusPromo, false)
			if bUnitIsSenshiBannerman then
				pUnit:SetHasPromotion(iSecondAttackPromo, false)
			end
			local pPlot = pUnit:GetPlot()
			for Item,PromotionID in pairs(Banners) do
				if pUnit:IsHasPromotion(PromotionID) then
					if GetUnitsInAdjacentPlotsWithPromotion(pPlot, PromotionID, iPlayer, "SamePlayer", "boolean") then
						pUnit:SetHasPromotion(iSenshiBannerBonusPromo, true)
						--Senshi's Edit:
						local maxMoves = pUnit:MaxMoves()
						pUnit:SetMoves(maxMoves)
					end
					if bUnitIsSenshiBannerman then
						if GetUnitsInAdjacentPlotsWithPromotion(pPlot, PromotionID, iPlayer, "SamePlayer", "integer") >= 2 then
							pUnit:SetHasPromotion(iSecondAttackPromo, true)
						end
					end
				end
			end
		end
	end
end

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--	GameEventSubscriptions
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

if IsCivInPlay(iCiv) then
	AddAllItemsInSameClassToTable(tValidBannerUnits, "Units")
	LuaEvents.SerialEventUnitCreatedGood.Add(SetBanner)
	GameEvents.PlayerDoTurn.Add(BannerAffectsEveryTurn)
end
