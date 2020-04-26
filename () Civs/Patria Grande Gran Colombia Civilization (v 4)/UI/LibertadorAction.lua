--=========================================================================================================================================================
-- CUSTOM MISSION SCRIPT
--=========================================================================================================================================================
-- Re-written by Tomatekh
-- Utils
include("Leugi_GranColombia_Utils.lua")
print("Gran Colombia Scripts")
--Support
include("IconSupport.lua")
-------------------------------------
-- Libertador_Action
-------------------------------------

local iMission				= "MISSION_PG_RECRUIT"

local iLibertador			= GameInfoTypes["UNIT_PG_LIBERTADOR"]
local iLibertadorUpgrade	= GameInfoTypes["UNIT_PG_UPGRADE_LIBERTADOR"]
local iCultureCost			= 100





--=====================================
-- CONDITION
--=====================================
function ConditionMission(unit, player)
	iEnable = false
	if unit:GetMoves() <= 0 then return "Hidden" end
	if HasTrait(player, "TRAIT_PG_GRANCOLOMBIA") then
		--print("EH1")
		if (GameInfo.Units[unit:GetUnitType()].Special) then
			--print("EH2")
			if unit:GetUnitType() ~= iLibertador and unit:GetUnitType() ~= iLibertadorUpgrade then
				--print("EH3")
				iCost = iModded(iCultureCost)
				if (player:GetJONSCulture() >= iCost) then 
					--print("EH4")
					iEnable = true
				else
					--print("UUH")
					iEnable = false
				end
				--print("AHA")
				local playerID = unit:GetOwner()
				local plot = unit:GetPlot()
				--print("WH")
				if (plot:GetOwner() ~= playerID) then iEnable = false end
				if (plot:IsWater()) then iEnable = false end
				--print("ASDAS")
				if iEnable == true then
					return "Enabled"
				else
					--print("CDS")
					return "Disabled"
				end
				return "Disabled"
			end
		end
	end
	return "Hidden"
end


--=====================================
-- RESULT
--=====================================
function ResultMission(unit, player)
	unit:SetMoves(0)
	newUnit = player:InitUnit(iLibertadorUpgrade, unit:GetX(), unit:GetY())			
	newUnit:Convert(unit);	
	iCost = iModded(iCultureCost)
	player:ChangeJONSCulture(-iCost)
	local plot = unit:GetPlot()
	local text = "[COLOR_CULTURE_STORED]-100 [ICON_CULTURE][ENDCOLOR]"
	Leugi_FloatingText(plot, text)
	--unit:greatperson()
end

--==================================
-- AI Usage
--==================================
function MissionAI(iPlayer, iUnit)
	local player = Players[iPlayer];
	local unit = player:GetUnitByID(iUnit);
	lCount = 0
	for pUnit in player:Units() do
		if (pUnit:GetUnitType() == iLibertador) or (pUnit:GetUnitType() == iLibertadorUpgrade) then
			lCount = lCount + 1;
		end
	end
	if lCount < 2 then
		 if not (player:IsHuman()) then 
			if HasTrait(player, "TRAIT_PG_GRANCOLOMBIA") then
				if (GameInfo.Units[unit:GetUnitType()].Special) then
					if unit:GetUnitType() ~= iLibertador and unit:GetUnitType() ~= iLibertadorUpgrade then
						iCost = math.ceil((iCultureCost) * iMod)
						if (player:GetJONSCulture() > iCost) then
							ResultMission(unit, player)
						end
					end
				end 
			end
		 end
	end
end
Events.SerialEventUnitCreated.Add(MissionAI)

--=====================================
-- CP MISSION
--=====================================
local iMissionID			= GameInfoTypes[iMission]

for row in DB.Query("SELECT Description FROM Missions WHERE Type = '" .. iMission .. "'") do
	TooltipTitle = Locale.ConvertTextKey("" .. row.Description .. "")
end
for row in DB.Query("SELECT Help FROM Missions WHERE Type = '" .. iMission .. "'") do
	TooltipDesc	= Locale.ConvertTextKey("" .. row.Help .. "")
end
for row in DB.Query("SELECT DisabledHelp FROM Missions WHERE Type = '" .. iMission .. "'") do
	TooltipDisabled	= Locale.ConvertTextKey("" .. row.DisabledHelp .. "")
end
for row in DB.Query("SELECT IconAtlas FROM Missions WHERE Type = '" .. iMission .. "'") do
	Atlas = row.IconAtlas
end

--=====================================
-- MISSION POSSIBLE: Must return true to show... otherwise return bTestVisible if it shows but disabled
--=====================================
function iMissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if missionID == iMissionID then
		local IsCondition = ConditionMission(unit, player)
		if IsCondition == "Enabled" then
			return true
		end
		if IsCondition == "Disabled" then
			return bTestVisible
		end
		if IsCondtion == "Hidden" then
			return false
		end
	end
end		
--=================================
-- MISSION START
--=================================
local CUSTOM_MISSION_NO_ACTION		 = 0
local CUSTOM_MISSION_ACTION			 = 1
local CUSTOM_MISSION_DONE			 = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3

function iMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == iMissionID then
		local unit = player:GetUnitByID(unitID)
		ResultMission(unit, player)
		return CUSTOM_MISSION_ACTION
	end
	return CUSTOM_MISSION_NO_ACTION
end

--=================================
-- MISSION COMPLETED
--=================================
function iMissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == iMissionID then
		return true 
	end
	return false
end

--==================================
-- Tomatekh Button
--==================================

--==================================
-- Button Possible
--==================================
function iButtonPossible(playerID, unitID, x, y, a5, bool)
	if bool then
		local player = Players[playerID]
		local unit = player:GetUnitByID(unitID)
		selUnit = nil;
		local Check = ConditionMission(unit, player)
		if Check == "Enabled" then
			Controls.Libertador_Action_Background:SetHide(false)
			selUnit = unit;
			Controls.Libertador_Action_Button:SetDisabled(false)
			Controls.Libertador_Action_Image:SetAlpha( 1 );  
			Controls.Libertador_Action_Button:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]" .. TooltipTitle .. "[ENDCOLOR][NEWLINE][NEWLINE]" .. TooltipDesc .. "")
			return "Enabled"
		end
		if Check == "Disabled" then
			Controls.Libertador_Action_Background:SetHide(false)
			selUnit = unit;
			Controls.Libertador_Action_Image:SetAlpha( 0.4 );  
			Controls.Libertador_Action_Button:SetDisabled(true)
			Controls.Libertador_Action_Button:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]" .. TooltipTitle .. "[ENDCOLOR][NEWLINE][NEWLINE]" .. TooltipDesc .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. TooltipDisabled .. "[ENDCOLOR]")		
			return "Disabled"
		end
		if Check == "Hidden" then
			Controls.Libertador_Action_Background:SetHide(true)
			selUnit = nil;
			return "Hidden"
		end
	end
	Controls.Libertador_Action_Background:SetHide(true)
	selUnit = nil;
end

function SetXYCheck(playerID, unitID, x, y)
	if selUnit ~= nil then
		if selUnit == Players[playerID]:GetUnitByID(unitID) then
			local player = Players[playerID]
		local unit = player:GetUnitByID(unitID)
		selUnit = nil;
		local Check = ConditionMission(unit, player)
		if Check == "Enabled" then
			Controls.Libertador_Action_Background:SetHide(false)
			selUnit = unit;
			Controls.Libertador_Action_Button:SetDisabled(false)
			Controls.Libertador_Action_Image:SetAlpha( 1 );  
			Controls.Libertador_Action_Button:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]" .. TooltipTitle .. "[ENDCOLOR][NEWLINE][NEWLINE]" .. TooltipDesc .. "")
			return "Enabled"
		end
		if Check == "Disabled" then
			Controls.Libertador_Action_Background:SetHide(false)
			selUnit = unit;
			Controls.Libertador_Action_Image:SetAlpha( 0.4 );  
			Controls.Libertador_Action_Button:SetDisabled(true)
			Controls.Libertador_Action_Button:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]" .. TooltipTitle .. "[ENDCOLOR][NEWLINE][NEWLINE]" .. TooltipDesc .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. TooltipDisabled .. "[ENDCOLOR]")		
			return "Disabled"
		end
		if Check == "Hidden" then
			Controls.Libertador_Action_Background:SetHide(true)
			selUnit = nil;
			return "Hidden"
		end
		end
	end
end
--==================================
-- Button Start
--==================================
function MyButtonFunction()
	local playerID = selUnit:GetOwner()
	local player = Players[playerID]
	ResultMission(selUnit, player)
	Controls.Libertador_Action_Background:SetHide(true)
	selUnit = nil;
end

Controls.Libertador_Action_Button:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "" .. Atlas .. "", Controls.Libertador_Action_Image )
Controls.Libertador_Action_Background:SetHide(true)

--=====================================
-- Check CP
--=====================================


function IsUsingCP()
    local CPModID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if (mod.ID == CPModID) then
            return true
        end
    end
    return false
end

if IsUsingCP() then
	----print("CP!")
	GameEvents.CustomMissionCompleted.Add(iMissionCompleted)
	GameEvents.CustomMissionStart.Add(iMissionStart)
	GameEvents.CustomMissionPossible.Add(iMissionPossible)
else
	Events.UnitSelectionChanged.Add(iButtonPossible);
	GameEvents.UnitSetXY.Add(SetXYCheck)
end



