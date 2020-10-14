-- Original Author: Explosive Watermelon
-- Additional Author, Debugging and Completing: Limaeus

--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local bDebug = false
local tag = "Neutral Nation"

-- --dprint
-- Credit to Limaeus
local function dprint(...)
    if bDebug then
		if ... ~= nil then
			print(tag .. ": " .. string.format(...))
		end
    end
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
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
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end

--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
include("IconSupport")
include("UnitSpawnHandler")

local traitNeutralID = GameInfoTypes["TRAIT_EW_TSOUHARISSEN"]
local promotionWeak = GameInfoTypes["PROMOTION_EW_NEUTRALITY"]
local unitMusketman = GameInfoTypes["UNIT_MUSKETMAN"]
local unitChonnonton = GameInfoTypes["UNIT_EW_CHONNONTON"]
local resourceFlint = GameInfoTypes["RESOURCE_EW_FLINT"]
local resourceIron = GameInfoTypes["RESOURCE_IRON"]
local buildingTattooist = GameInfoTypes["BUILDING_EW_TATTOOIST"]
local promotionCityAttack = GameInfoTypes["PROMOTION_EW_WAR_TATTOO"]
local dummy_buildingMilitaryProduction = GameInfoTypes["BUILDING_NEUTRAL_MILITARY_PRODUCTION_DUMMY"]
local techOptics = GameInfoTypes["TECH_OPTICS"]
local techAstronomy = GameInfoTypes["TECH_ASTRONOMY"]

local unitTable = {}

local i = 1
for row in DB.Query("SELECT ID, Type, Combat, RangedCombat, PrereqTech FROM Units WHERE (Domain = 'DOMAIN_LAND') AND (Combat > 0)") do
    unitTable[i] = {ID=row.ID, Type=row.Type, MeleeStr=row.Combat, RangedStr=row.RangedCombat, Tech=GameInfoTypes[row.PrereqTech]}
    i = i + 1
end

local promotionTable = {}
for row in DB.Query("SELECT UnitType, PromotionType FROM Unit_FreePromotions") do
	for k, v in pairs(unitTable) do
		if v.Type == row.UnitType then
			if not promotionTable[row.UnitType] then
				promotionTable[row.UnitType] = {row.PromotionType}
			else
				table.insert(promotionTable[row.UnitType], row.PromotionType)
			end

		end
	end
end
--tprint(promotionTable)

----------------------------------------------------------------------------------------------------------------------------
-- CHILD OF THE SUN
----------------------------------------------------------------------------------------------------------------------------
function EW_Lime_ResistanceSpawn(playerID)
    local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitNeutralID)) then return end
	for city in player:Cities() do
		--dprint(city:GetName())
		if city:IsResistance() then
			--dprint("found a city in resistance")
			local iChosenType = nil
			local iHighestStrength = 0
			local unitType = nil
			local team = Teams[player:GetTeam()]
			for k, v in pairs(unitTable) do
				if player:CanTrain(v.ID) then
					if team:IsHasTech(v.Tech) or (v.Tech == nil) then
						if v.RangedStr > 0 then
							if v.RangedStr >= iHighestStrength then
								iHighestStrength = v.RangedStr
								iChosenType = v.ID
								unitType = v.Type
								--dprint(iHighestStrength)
								--dprint(unitType)
							end
						else
							if v.MeleeStr >= iHighestStrength then
								iHighestStrength = v.MeleeStr
								iChosenType = v.ID
								unitType = v.Type
								--dprint(iHighestStrength)
								--dprint(unitType)
							end
						end

					end
				end
			end

			local placedUnit = false
			for a, promotions in pairs(promotionTable) do
				if a == unitType then
					if team:IsHasTech(techOptics) then
						table.insert(promotions, "PROMOTION_EMBARKATION")
					end
					table.insert(promotions, "PROMOTION_EW_NEUTRALITY")
					SpawnAtPlot(player, iChosenType, city:GetX(), city:GetY(), 0, 0, "NO_NAME", promotions)
					--dprint("Placed a " .. unitType)
					placedUnit = true
					break
				end
			end

			--dprint(tostring(placedUnit))

			if not placedUnit then
				local promotions = {}
				if team:IsHasTech(techOptics) then
					table.insert(promotions, "PROMOTION_EMBARKATION")
					if team:IsHasTech(techAstronomy) then
						table.insert(promotions, "PROMOTION_ALLWATER_EMBARKATION")
					end
				end
				--tprint(promotions)
				table.insert(promotions, "PROMOTION_EW_NEUTRALITY")
				SpawnAtPlot(player, iChosenType, city:GetX(), city:GetY(), 0, 0, "NO_NAME", promotions)

				--dprint("Placed a " .. unitType)
			end

		end
	end
end
GameEvents.PlayerDoTurn.Add(EW_Lime_ResistanceSpawn)

function Lime_ConvertToFlint(iTeam, iTech, iChange)
	local player = nil
	if (iTech == GameInfo.Technologies["TECH_GUNPOWDER"].ID) then
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if (Players[iPlayer] ~= nil) then
				if (Players[iPlayer]:GetTeam() == iTeam) then
					player = Players[iPlayer]
				end
			end
		end

		if player == nil then return end
		if (not player:IsAlive()) then return end
		if (not HasTrait(player, traitNeutralID)) then return end
		--dprint("player ID" .. player:GetID())
		--dprint(player:GetName())

		for city in player:Cities() do
			--dprint("city " .. city:GetName())
			for i = 0, city:GetNumCityPlots() - 1, 1 do
				local plot = city:GetCityIndexPlot(i)
				--dprint("plot found at " .. plot:GetX() .. " " .. plot:GetY())
				--dprint(plot:GetOwner())
				if plot:GetNumResource() > 0 and plot:GetOwner() == player:GetID() then
					--dprint("found owned plot with resource " .. plot:GetResourceType())
					--dprint("iron is " .. resourceIron)
					if plot:GetResourceType() == resourceIron then
						local tmpNum = plot:GetNumResource()
						plot:SetResourceType(resourceIron, 0)
						plot:SetResourceType(resourceFlint, 1)
						plot:SetNumResource(tmpNum)
						local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Converted [ICON_RESOURCE_IRON] to [ICON_RESOURCE_EW_FLINT]"), true)
						--dprint("replaced Iron with Flint at " .. plot:GetX() .. " " .. plot:GetY())
					end
				end
			end
		end
	end
end
GameEvents.TeamTechResearched.Add(Lime_ConvertToFlint)

function Lime_FlintProductionBonus(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitNeutralID)) then return end

	for city in player:Cities() do
		for i = 0, city:GetNumCityPlots() - 1, 1 do
			local plot = city:GetCityIndexPlot(i)
			----dprint("plot found at " .. plot:GetX() .. " " .. plot:GetY())
			----dprint("first check " .. plot:GetNumResource())
			----dprint("second check owner " .. plot:GetOwner())
			----dprint("second check player ID " .. player:GetID())
			----dprint("third check" .. plot:IsBeingWorked())
			if plot and plot:GetNumResource() > 0 and plot:GetOwner() == playerID and plot:IsBeingWorked() then
				--dprint("Found a worked resource of type " .. plot:GetResourceType())
				if plot:GetResourceType() == resourceFlint then
					--dprint("Found some worked flint")
					city:SetNumRealBuilding(dummy_buildingMilitaryProduction, 1)
					break
				else
					city:SetNumRealBuilding(dummy_buildingMilitaryProduction, 0)
				end
			else
				city:SetNumRealBuilding(dummy_buildingMilitaryProduction, 0)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(Lime_FlintProductionBonus)

----------------------------------------------------------------------------------------------------------------------------
-- CHONNONTON
----------------------------------------------------------------------------------------------------------------------------
function Lime_AI_UpgradeUnits(player, unit, resource)
	if resource ~= resourceFlint then return end

	local nunit = player:InitUnit(unitMusketman, unit:GetX(), unit:GetY())
	nunit:Convert(unit)
	unit:Kill(-1)
	--dprint("Upgraded Chonnonton to Musketman at " .. unit:GetX() .. " " .. unit:GetY())
end

function Lime_SpawnFlint(playerID, cityID, unitID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitNeutralID)) then return end
	local unit = player:GetUnitByID(unitID)
	local city = player:GetCityByID(cityID)
	if unit:GetUnitType() == unitChonnonton then
		for i = 0, city:GetNumCityPlots() - 1, 1 do
			local plot = city:GetCityIndexPlot(i)
			if plot:GetNumResource() == 0 and not plot:IsCity() and plot:GetOwner() == playerID then
				if not plot:IsWater() then
					local rand = Game.Rand(city:GetNumCityPlots()+1, "FlintSpawn")
					--dprint("random number is " .. rand)
					if rand > city:GetNumCityPlots()/1.2 then
						--dprint("Spawning Flint")
						plot:SetResourceType(resourceFlint, 1)
						plot:SetNumResource(Game.Rand(9, "Num Flint Generator"))

						if player:IsHuman() then
							local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
							Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Converted [ICON_RESOURCE_IRON] to [ICON_RESOURCE_EW_FLINT]"), true)
						else
							if plot:IsUnit() then
									Lime_AI_UpgradeUnits(player, plot:GetUnit(0), plot:GetResourceType())
							end
						end
						break
					end
				end
			end
		end
	end
end
GameEvents.CityTrained.Add(Lime_SpawnFlint)

function Lime_Neutral_UnitSelection(playerID, unitID, x, y, a5, bool)
	if bool then
		local player = Players[playerID]
		if (not player:IsAlive()) then return end
		if (not HasTrait(player, traitNeutralID)) then return end
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() ~= unitChonnonton then return end
		local plot = unit:GetPlot()
		if plot == nil then return end
		if plot:GetNumResource() == 0 then return end
		local resource = plot:GetResourceType()
		local team = Teams[player:GetTeam()]
		if not team:IsHasTech(GameInfoTypes["TECH_GUNPOWDER"]) then return end

		if resource == resourceFlint then
			Controls.NeutralBackground:SetHide(false)
			selUnit = unit
			Controls.NeutralButton:SetHide(false)
			NeutralToolTip = Locale.ConvertTextKey("TXT_KEY_NEUTRAL_CHONNONTON_UPGRADE_TAG")
			Controls.NeutralButton:LocalizeAndSetToolTip("" .. NeutralToolTip .. "")
		end

	else
		Controls.NeutralBackground:SetHide(true)
		selUnit = nil;
	end
end
Events.UnitSelectionChanged.Add(Lime_Neutral_UnitSelection);

function Lime_ChonnontonButton()
	local plot = selUnit:GetPlot()
	local playerID = selUnit:GetOwner()
	local player = Players[playerID]
	if selUnit:GetMoves() > 0 then
		local newUnit = player:InitUnit(unitMusketman, selUnit:GetX(), selUnit:GetY())
		newUnit:Convert(selUnit)
		selUnit:Kill(-1)
		--dprint("Upgraded Chonnonton to Musketman at " .. selUnit:GetX() .. " " .. selUnit:GetY())
	end
end

Controls.NeutralButton:RegisterCallback(Mouse.eLClick, Lime_ChonnontonButton )
IconHookup(44, 45, "UNIT_ACTION_ATLAS", Controls.NeutralImage )
Controls.NeutralBackground:SetHide(true)

function Lime_Neutral_GiveUpgradeChonnonton(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitNeutralID)) then return end
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() ~= unitChonnonton then return end
	local plot = unit:GetPlot()
	if plot == nil then return end
	local resource = plot:GetResourceType()
	local team = Teams[player:GetTeam()]
	if not team:IsHasTech(GameInfoTypes["TECH_GUNPOWDER"]) then return end

	if player:IsHuman() then
		if resource == resourceFlint then
			Controls.NeutralBackground:SetHide(false)
			Controls.NeutralButton:SetHide(false)
			NeutralToolTip = Locale.ConvertTextKey("TXT_KEY_NEUTRAL_CHONNONTON_UPGRADE_TAG")
			Controls.NeutralButton:LocalizeAndSetToolTip("" .. NeutralToolTip .. "")
			--dprint("Displayed the Chonnonton's free upgrade button")
		else
			Controls.NeutralBackground:SetHide(true)
			selUnit = nil;
			--dprint("Hid the Chonnonton's free upgrade button")
		end
	else
		Lime_AI_UpgradeUnits(player, unit, resource)
	end
end
GameEvents.UnitSetXY.Add(Lime_Neutral_GiveUpgradeChonnonton)

----------------------------------------------------------------------------------------------------------------------------
-- TATTOOIST
----------------------------------------------------------------------------------------------------------------------------

function ManuallyGiveFreeTattooPromo(playerID, cityID, unitID)
	local pPlayer = Players[playerID]
	local pCity = pPlayer:GetCityByID(cityID)
	if pCity:IsHasBuilding(buildingTattooist) then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pUnit:IsCombatUnit() then
			pUnit:SetHasPromotion(promotionCityAttack, true)
		end
	end
end
GameEvents.CityTrained.Add(ManuallyGiveFreeTattooPromo)

function EW_RemovePenalty(playerID, unitID, ewX, ewY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:IsHasPromotion(promotionWeak) then
		if Map.GetPlot(ewX, ewY):IsCity() then
			local city = Map.GetPlot(ewX, ewY):GetPlotCity()
			if city:IsHasBuilding(buildingTattooist) then
				unit:SetHasPromotion(promotionWeak, false)
				--dprint("Removed the Weakness promotion at " .. ewX .. " " .. ewY)
			end
		end
	end
end
GameEvents.UnitSetXY.Add(EW_RemovePenalty)

print("The Neutral Nation is in the game")
