-- CBR_Pomo_Functions
-- Author: Limerickarcher
-- DateCreated: August 6th 2019

include('Sukritact_SaveUtils'); MY_MOD_NAME = "CBRPomo";
include('IconSupport')
include('PlotIterators')

--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local bDebug = true

function dprint(...)
  if (bDebug) then
    if ... ~= nil then
      print(string.format(...))
    else
      print('nil')
    end

  end
end

--IsCPDLL
--Credit to JFD
function IsCPDLL()
  for _, mod in pairs(Modding.GetActivatedMods()) do
    if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
      return true
    end
  end
  return false
end
local isCPDLL = IsCPDLL()

--HasTrait
--Credit to JFD
function HasTrait(player, traitID)
  if isCPDLL then
    return player:HasTrait(traitID)
  else
    local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
    local traitType = GameInfo.Traits[traitID].Type
    for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
      return true
    end
  end
  return false
end

-- String Splitter
-- Credit to StackOverflow
function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  if inputstr == nil then
    return nil
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function stringToBoolean(str)
  if str == 'true' then
    return true
  end
  return false
end

--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
local traitPomo = GameInfoTypes["TRAIT_CBR_POMO"]
local unitBasketWeaver = GameInfoTypes["UNIT_CBR_BASKET_WEAVER"]
local buildingClassDanceCave1 = GameInfoTypes["BUILDINGCLASS_CBR_POMO_1"]
local buildingClassDanceCave2 = GameInfoTypes["BUILDINGCLASS_CBR_POMO_2"]
local buildingDanceCave = GameInfoTypes["BUILDING_CBR_DANCE_CAVE"]
local buildingDanceCave2 = GameInfoTypes["BUILDING_CBR_DANCE_CAVE_2"]
local promotionNorth = GameInfoTypes["PROMOTION_CBR_POMO_NORTH"]
local promotionEast = GameInfoTypes["PROMOTION_CBR_POMO_EAST"]

----------------------------------------------------------------------------------------------------------------------------
-- SPIRIT OF THE FOUR DIRECTIONS
----------------------------------------------------------------------------------------------------------------------------
function Lime_SpiritOfTheFourDirections(playerID, unitID, unitX, unitY)
  local player = Players[playerID]
  if (not player:IsAlive()) then return end
  if (not HasTrait(player, traitPomo)) then return end
  local unit = player:GetUnitByID(unitID)
  local unitPlot = unit:GetPlot()
  if (not unitPlot) then return end

  local xCoord = unitPlot:GetX()
  local yCoord = unitPlot:GetY()

  dprint("xCoord " .. xCoord)
  dprint("yCoord " .. yCoord)

  local savedTable = split(load(unit, "CBR_POMO_unit_coord"), "_") or nil
  if not savedTable then
    save(unit, "CBR_POMO_unit_coord", xCoord .. "_" .. yCoord .. "_" .. tostring(unit:IsEmbarked()))
    return
  end

  local oldX = tonumber(savedTable[1])
  local oldY = tonumber(savedTable[2])
  local isEmbarked = stringToBoolean(savedTable[3])

  dprint("oldX " .. oldX)
  dprint("oldY " .. oldY)
  dprint("isEmbarked " .. tostring(isEmbarked))

  unit:SetHasPromotion(promotionEast, false)
  unit:SetHasPromotion(promotionNorth, false)

  local rand = math.random()
  dprint("random " .. rand)

  local count = 0
  local oldPlot = Map.GetPlot(oldX, oldY)

  for plot in PlotRingIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE) do
    --dprint("x coord: " .. plot:GetX() .. "y coord: " .. plot:GetY())
    if plot == oldPlot then
      if count == 3 then -- North-West
        if rand > 0.75 then
          dprint("Moved North-West, chose West")
          if isEmbarked == false and unit:IsEmbarked() then
            unit:SetMoves(unit:MaxMoves())
          end
        else
          dprint("Moved North-West, chose North")
          unit:SetHasPromotion(promotionNorth, true)
        end
      elseif count == 4 then -- North-East
        if rand > 0.75 then
          dprint("Moved North-East, chose East")
          unit:SetHasPromotion(promotionEast, true)
        else
          dprint("Moved North-East, chose North")
          unit:SetHasPromotion(promotionNorth, true)
        end
      elseif count == 5 then -- East
        dprint("Moved East")
        unit:SetHasPromotion(promotionEast, true)
      elseif count == 0 then -- South-East
        if rand > 0.75 then
          dprint("Moved South-East, chose East")
          unit:SetHasPromotion(promotionEast, true)
        else
          dprint("Moved South-East, chose South")
          if (not unit:GetCurrHitPoints() == unit:GetMaxHitPoints()) then
            if unit:GetCurrHitPoints() + 5 > unit:GetMaxHitPoints() then
              unit:SetDamage(unit:GetMaxHitPoints())
            else
              unit:ChangeDamage(-5)
            end
          end
        end
      elseif count == 1 then -- South-West
        if rand > 0.75 then
          dprint("Moved South-West, chose West")
          if isEmbarked == false and unit:IsEmbarked() then
            unit:SetMoves(unit:MaxMoves())
          end
        else
          dprint("Moved South-West, chose South")
          if (not unit:GetCurrHitPoints() == unit:GetMaxHitPoints()) then
            if unit:GetCurrHitPoints() + 5 > unit:GetMaxHitPoints() then
              unit:SetDamage(unit:GetMaxHitPoints())
            else
              unit:ChangeDamage(-5)
            end
          end
        end
      elseif count == 2 then -- West
        dprint("Moved West")
        if isEmbarked == false and unit:IsEmbarked() then
          unit:SetMoves(unit:MaxMoves())
        end
      end
      break
    end
    count = count + 1
  end

  save(unit, "CBR_POMO_unit_coord", xCoord .. "_" .. yCoord .. "_" .. tostring(unit:IsEmbarked()))

end
GameEvents.UnitSetXY.Add(Lime_SpiritOfTheFourDirections)

----------------------------------------------------------------------------------------------------------------------------
-- Basket Weaver
----------------------------------------------------------------------------------------------------------------------------
function Lime_AI_BasketWeaver(player, plot, unit, playerID)
  player:ChangeJONSCulture(50)
  Players[plot:GetOwner()]:ChangeMinorCivFriendshipWithMajor(playerID, 50)
  local rewardGold = 50 * (player:GetCurrentEra() + 1)
  player:ChangeGold(rewardGold)
  dprint("Found a Basket Weaver in a City State")
end

function Lime_Pomo_UnitSelection(playerID, unitID, x, y, a5, bool)
  if bool then
    local player = Players[playerID]
    if (not player:IsAlive()) then return end
    if (not HasTrait(player, traitPomo)) then return end
    local unit = player:GetUnitByID(unitID)
    if unit:GetUnitType() ~= unitBasketWeaver then return end
    local plot = unit:GetPlot()
    if plot == nil then return end
	if not plot:GetOwner() then return end

    if Players[plot:GetOwner()]:IsMinorCiv() then
      Controls.PomoBackground:SetHide(false)
      selUnit = unit
      Controls.PomoButton:SetHide(false)
      PomoToolTip = Locale.ConvertTextKey("TXT_KEY_POMO_BASKET_WEAVER_UPGRADE_TAG")
      Controls.PomoButton:LocalizeAndSetToolTip("" .. PomoToolTip .. "")
    end
  else
    Controls.PomoBackground:SetHide(true)
    selUnit = nil;
  end
end
Events.UnitSelectionChanged.Add(Lime_Pomo_UnitSelection);

function Lime_BasketWeaverButton()
  local plot = selUnit:GetPlot()
  local playerID = selUnit:GetOwner()
  local player = Players[playerID]
  if selUnit:GetMoves() > 0 then
    player:ChangeJONSCulture(50)
    Players[plot:GetOwner()]:ChangeMinorCivFriendshipWithMajor(playerID, 50)
    local rewardGold = 50 * (player:GetCurrentEra() + 1)
    player:ChangeGold(rewardGold)
    dprint("Found a Basket Weaver in a City State")
    if (player:IsHuman() and plot:GetX() and plot:GetY()) then
      local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
      Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_GOLD]", rewardGold), true)
      Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_CULTURE]", 50), true)
      Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num} [ICON_INFLUENCE]", 50), true)
    end

    selUnit:Kill(-1)
  end
end

Controls.PomoButton:RegisterCallback(Mouse.eLClick, Lime_BasketWeaverButton)
IconHookup(44, 45, "UNIT_ACTION_ATLAS", Controls.PomoImage )
Controls.PomoBackground:SetHide(true)

function Lime_Pomo_GiveBasketWeaverIcon(playerID, unitID, unitX, unitY)
  local player = Players[playerID]
  if (not player:IsAlive()) then return end
  if (not HasTrait(player, traitPomo)) then return end
  local unit = player:GetUnitByID(unitID)
  if unit:GetUnitType() ~= unitBasketWeaver then return end
  local plot = unit:GetPlot()
  if not plot then return end
  if not plot:GetOwner() then return end

  if Players[plot:GetOwner()]:IsMinorCiv() then
    if player:IsHuman() then
      Controls.PomoBackground:SetHide(false)
      Controls.PomoButton:SetHide(false)
      PomoToolTip = Locale.ConvertTextKey("TXT_KEY_POMO_BASKET_WEAVER_UPGRADE_TAG")
      Controls.PomoButton:LocalizeAndSetToolTip("" .. PomoToolTip .. "")
      dprint("Displayed the Basket Weaver's Mission Icon")
    else
      Lime_AI_BasketWeaver(player, plot, unit, playerID)
    end
  else
    Controls.PomoBackground:SetHide(true)
    selUnit = nil;
    dprint("Hid the Basket Weaver's Mission Icon")
  end


end
GameEvents.UnitSetXY.Add(Lime_Pomo_GiveBasketWeaverIcon)


----------------------------------------------------------------------------------------------------------------------------
-- Dance Cave
----------------------------------------------------------------------------------------------------------------------------
function Lime_DanceCave(playerID)
  local player = Players[playerID]
  if (not player:IsAlive()) then return end
  if (not HasTrait(player, traitPomo)) then return end

  for city in player:Cities() do
    city:ChangeHealRate(0)
    dprint(city:GetNumGreatWorksInBuilding(buildingClassDanceCave1))
    dprint(city:GetNumGreatWorksInBuilding(buildingClassDanceCave2))

    if city:GetNumGreatWorksInBuilding(buildingClassDanceCave1) == 1 and city:GetNumGreatWorksInBuilding(buildingClassDanceCave2) == 1 then
      city:ChangeHealRate(50)
      dprint("Upped City Heal Rate by 50")
    end
  end
end
GameEvents.PlayerDoTurn.Add(Lime_DanceCave)

function Lime_DanceCave_Dummy(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
  local player = Players[ownerID]
  if not player then return end
  if (not player:IsAlive()) then return end
  if (not HasTrait(player, traitPomo)) then return end
  if (not GameInfoTypes[buildingType] == buildingDanceCave) then return end

  player:GetCityByID(cityID):SetNumRealBuilding(buildingDanceCave2, 1)
end
GameEvents.CityConstructed.Add(Lime_DanceCave_Dummy)

----------------------------------------------------------------------------------------------------------------------------
-- Random Capital Selection
----------------------------------------------------------------------------------------------------------------------------
-- Utils from JFD and C15
----------------------------------------------------------------------------------------------------------------------------
local tCapitals = {}
for row in GameInfo.Lime_Pomo_Capitals() do
	table.insert(tCapitals, {CityName = Locale.ConvertTextKey(row.CityName)})
end

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function C15_CheckCityNameExists(sName, pCity)
	for i = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local pPlayer = Players[i]
		if pPlayer then
			for pIterCity in pPlayer:Cities() do
				if pIterCity ~= pCity and pIterCity:GetName() == sName then
					return true
				end
			end
		end
	end
	return false
end

function C15_GetRandomCityName(pCity)
	local sName
	local tNames = tCapitals
	while not sName and #tNames > 0 do
		local iRand = JFD_GetRandom(1, #tNames)
		if C15_CheckCityNameExists(tNames[iRand].CityName, pCity) then
			table.remove(tNames, iRand)
		else
			sName = tNames[iRand].CityName
		end
	end
	return sName
end

function Lime_CapitalFounded(playerID, iX, iY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitPomo)) then return end

	local plot = Map.GetPlot(iX, iY)
	local city = plot:GetPlotCity()

	if city:IsCapital() then
		local name = C15_GetRandomCityName(city)
		if name then
			city:SetName(name)
		end
	end
end
GameEvents.PlayerCityFounded.Add(Lime_CapitalFounded)

print("The Pomo Tribe is in the game")