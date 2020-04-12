
-- GTAS_CivUnits - Part of Really Advanced Setup Mod

include("IconSupport");
include("InstanceManager");

include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_ScrollText");

local NO_UNIT = -1;
local MAX_COUNT = 10;
local MAX_EXPERIENCE = 500;
local EXPERIENCE_STEP = 10;

local SHOW_BOTH_UNITS = 1;
local SHOW_COMBAT_UNITS = 2;
local SHOW_NON_COMBAT_UNITS = 3;

local UnitID = NO_UNIT;
local ShowFutureUnits = false;
local ShowUniqueUnits = false;
local UnitRadioButton = SHOW_BOTH_UNITS;
local UnitExperience = 0;
local UnitCount = 1;

local UnitManager = InstanceManager:new("UnitInstance", "UnitRoot", Controls.UnitStack)
local UnitHelpManager = InstanceManager:new("UnitHelpInstance", "UnitHelpRoot", Controls.UnitStack);

local ConvertedUnitNames = { 	UNIT_BARBARIAN_ARCHER = "Barbarian Archer",
								UNIT_BARBARIAN_SPEARMAN = "Barbarian SpearMan", 
								UNIT_BARBARIAN_SWORDSMAN = "Barbarian Swordsman" };

--------------------------------------------------------------------------------------------------
function BuildUnits()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot == nil then
		print("BuildUnits:  Slot Error");
		return
	end

	-- Create a list of units based on current settings ------------------------------------
	units = {}
	for unit in GameInfo.Units() do
		local addThisUnit = true;

		if not ShowFutureUnits and unit.PrereqTech then
			local preTech = GameInfo.Technologies[unit.PrereqTech];
			if preTech and preTech.Era then
				local era = GameInfo.Eras[preTech.Era];
				if era and era.ID > GameData.era then
					addThisUnit = false;
				end
			end
		end

		if addThisUnit then
			if not ShowUniqueUnits then
				for row in GameInfo.Civilization_UnitClassOverrides("UnitType = '" .. unit.Type .. "'") do
					if slot.civType == RANDOM_CIVILIZATION then
						addThisUnit = false;
					elseif row.CivilizationType ~= slot.civType then
						addThisUnit = false;
					end
				end
			end
		end

		if addThisUnit then
			if UnitRadioButton ~= SHOW_BOTH_UNITS then
				if UnitRadioButton == SHOW_COMBAT_UNITS then
					if unit.CombatClass == nil then
						addThisUnit = false;
					end
				else
					if unit.CombatClass ~= nil then
						addThisUnit = false;
					end
				end
			end
		end

		if addThisUnit then
			table.insert(units, { ID = unit.ID, description = GetUnitDescription(unit) });
		end
	end

	table.sort(units, function(a, b) return Locale.Compare(a.description, b.description) == -1; end);

	if UnitID == NO_UNIT then
		UnitID = units[1].ID;
	end
	
	local unitInfo = GameInfo.Units[UnitID];

	-- Unit Portrait -------------------------------------------------------------------
	if unitInfo ~= nil and IconHookup(unitInfo.PortraitIndex, 256, unitInfo.IconAtlas, Controls.Portrait) then
		Controls.PortraitFrame:SetHide(false);
	else
		Controls.PortraitFrame:SetHide(true);
	end

	-- Unit PullDown -------------------------------------------------------------------
	Controls.UnitPulldown:ClearEntries();

	local unitNotFound = true;

	for _, unit in ipairs(units) do
		local control = {};
		Controls.UnitPulldown:BuildEntry("InstanceOne", control);
		control.Button:SetVoid1(unit.ID);
		control.Button:LocalizeAndSetText(unit.description);

		if unit.ID == UnitID then
			unitNotFound = false;
		end
	end

	if units and unitNotFound  then
		UnitID = units[1].ID;
	end

	function SetExperieceStatus()
		if unitInfo ~= nil and unitInfo.CombatClass == nil then
			Controls.UnitExperienceSlider:SetHide(true);
			Controls.UnitExperienceValue:SetHide(true);
			Controls.ExperienceNotAvailable:SetHide(false);
			UnitExperience = 0;
		else
			Controls.UnitExperienceSlider:SetHide(false);
			Controls.UnitExperienceValue:SetHide(false);
			Controls.ExperienceNotAvailable:SetHide(true);
		end
	end

	function OnUnit(id)
		UnitID = id;
		SetExperieceStatus();
		PerformBuild()
	end
	Controls.UnitPulldown:RegisterSelectionCallback(OnUnit)
	Controls.UnitPulldown:GetButton():LocalizeAndSetText(GetUnitDescription(unitInfo));
	Controls.UnitPulldown:CalculateInternals();
	SetExperieceStatus();

	-- ShowFutureUnits CheckBox --------------------------------------------------------------
	function OnShowFutureUnits(isChecked)
		ShowFutureUnits = isChecked;
		PerformBuild();
	end
	Controls.ShowFutureUnits:RegisterCheckHandler(OnShowFutureUnits)
	Controls.ShowFutureUnits:SetCheck(ShowFutureUnits);

	-- ShowUniqueUnits CheckBox --------------------------------------------------------------
	function OnShowUniqueUnits(isChecked)
		ShowUniqueUnits = isChecked;
		PerformBuild();
	end
	Controls.ShowUniqueUnits:RegisterCheckHandler(OnShowUniqueUnits)
	Controls.ShowUniqueUnits:SetCheck(ShowUniqueUnits);

	-- Unit Type Radio Buttons --------------------------------------------------------------
	function OnButtonChanged(button)
		UnitRadioButton = button;
		UnitID = NO_UNIT;
		PerformBuild();
	end
	Controls.ShowCombatUnits:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.ShowCombatUnits:SetVoid1(SHOW_COMBAT_UNITS);
	Controls.ShowCombatUnits:SetCheck(UnitRadioButton == SHOW_COMBAT_UNITS);

	Controls.ShowNonCombatUnits:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.ShowNonCombatUnits:SetVoid1(SHOW_NON_COMBAT_UNITS);
	Controls.ShowNonCombatUnits:SetCheck(UnitRadioButton == SHOW_NON_COMBAT_UNITS);

	Controls.ShowBothUnits:RegisterCallback(Mouse.eLClick, OnButtonChanged);
	Controls.ShowBothUnits:SetVoid1(SHOW_BOTH_UNITS);
	Controls.ShowBothUnits:SetCheck(UnitRadioButton == SHOW_BOTH_UNITS);

	-- UnitCount Slider ----------------------------------------------------------------
	function OnUnitCount(fValue)
		UnitCount = GetSliderValue(fValue, 1, MAX_COUNT);
		Controls.UnitCountValue:SetText(tostring(UnitCount));
	end
	Controls.UnitCountSlider:RegisterSliderCallback(OnUnitCount);
	SetSliderValue(Controls.UnitCountSlider, UnitCount, 1, MAX_COUNT);
	Controls.UnitCountValue:SetText(tostring(UnitCount));

	-- UnitExperienceSlider Slider ----------------------------------------------------------------
	function OnUnitExperience(fValue)
		UnitExperience = GetSliderValue(fValue, 0, MAX_EXPERIENCE);
		Controls.UnitExperienceValue:SetText(tostring(UnitExperience));
	end
	Controls.UnitExperienceSlider:RegisterSliderCallback(OnUnitExperience);
	SetSliderValue(Controls.UnitExperienceSlider, UnitExperience, 1, MAX_EXPERIENCE);
	Controls.UnitExperienceValue:SetText(tostring(UnitExperience));

	-- Add Unit Button -----------------------------------------------------------------------------
	function OnAddUnit()
		if unitInfo ~= nil then
			local slot = SlotData:GetSlot(GlobalData.currentPlayer);

			if slot ~= nil then
				slot:AddUnit(unitInfo.Type, UnitCount, UnitExperience);
			end
		end
		
		PerformBuild();
	end
	Controls.AddUnit:RegisterCallback(Mouse.eLClick, OnAddUnit);

	-- Copy List Button -----------------------------------------------------------------------------
	function OnCopyList()
		local currentSlot = SlotData:GetSlot(GlobalData.currentPlayer);

		if currentSlot ~= nil then
			for playerID, otherSlot in SlotData:SlotList() do
				if otherSlot ~= nil and otherSlot ~= currentSlot then
					otherSlot:ResetUnits();

					for _, unit in currentSlot:UnitList() do
						otherSlot:CopyUnit(unit);
					end
				end
			end
		end

		PerformBuild();
	end
	Controls.CopyList:RegisterCallback(Mouse.eLClick, OnCopyList);

	-- Clear List Button -----------------------------------------------------------------------------
	function OnClearList()
		local slot = SlotData:GetSlot(GlobalData.currentPlayer);

		if slot ~= nil then
			slot:ResetUnits();
		end

		PerformBuild();
	end
	Controls.ClearList:RegisterCallback(Mouse.eLClick, OnClearList);

	-- Build Unit ScrollPanel -------------------------------------------------------------------
	UnitManager:ResetInstances();
	UnitHelpManager:ResetInstances();

	if slot:HasUnits() then
		Controls.ListTitle:SetHide(false);

		for index, unit in slot:UnitList() do
			local instance = UnitManager:GetInstance();
			local info = GameInfo.Units[unit.unitType];

			if info ~= nil then
				IconHookup(info.PortraitIndex, 64, info.IconAtlas, instance.UnitPortrait)
				instance.UnitName:LocalizeAndSetText(info.Description);
			end
			
			instance.UnitCount:SetText(tostring(unit.count));
			instance.UnitExperience:SetText(tostring(unit.experience));

			function OnUnitButton()
				if info ~= nil then
					UnitID = info.ID;
				end
				UnitCount = unit.count;
				UnitExperience = unit.experience;
				PerformBuild();
			end
			instance.UnitButton:RegisterCallback(Mouse.eLClick, OnUnitButton);

			function OnUpdate()
				if unitInfo ~= nil then
					slot:UpdateUnit(index, unitInfo.Type, UnitCount, UnitExperience);
				end
				PerformBuild();
			end
			instance.UpdateUnit:RegisterCallback(Mouse.eLClick, OnUpdate);

			function OnDelete()
				slot:RemoveUnit(index);
				PerformBuild();
			end
			instance.DeleteUnit:RegisterCallback(Mouse.eLClick, OnDelete);
		end

	else
		Controls.ListTitle:SetHide(true);
		CreateScrollText(UnitCivText, UnitHelpManager);
	end

	Controls.UnitStack:CalculateSize();
	Controls.UnitStack:ReprocessAnchoring();
	Controls.UnitScrollPanel:ReprocessAnchoring();
	Controls.UnitScrollPanel:CalculateInternalSize();
end

---------------------------------------------------------------------------------------
function GetUnitDescription(unit)
	if unit == nil then
		return "Unit Error";
	end
	
	for unitType, text in pairs(ConvertedUnitNames) do
		if unit.Type == unitType then
			return text;
		end
	end
	
	return Locale.ConvertTextKey(unit.Description);
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildUnits();
	ValidateControls(); -- This should always get called last.
end

----------------------------------------------------------------
function ShowHideHandler(isHide, isInit)
	local buffer = {};
	LuaEvents.GetDataObjects(buffer);
	SlotData = buffer[DATA_SLOT];
	MapData = buffer[DATA_MAP];
	GameData = buffer[DATA_GAME];
	GlobalData = buffer[DATA_GLOBAL];

	if not isHide and not isInit then
		PerformBuild();
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler);

-----------------------------------------------------------------
function AdjustScreenSize()
    local _, screenY = UIManager:GetScreenSizeVal();
	Controls.UnitPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.UnitBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.UnitBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
	Controls.ScrollBox:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 275);
	Controls.ScrollBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 313);
	Controls.ScrollBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 315);
	Controls.UnitScrollPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 317);
	Controls.UnitScrollPanel:CalculateInternalSize();
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();
























