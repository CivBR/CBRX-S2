
-- GTAS_CivBonuses - Part of Really Advanced Setup Mod

include("IconSupport");
include("GTAS_Constants");
include("GTAS_Utilities");
include("GTAS_StartBias");

local MAX_GOLD = 10000;
local MAX_CULTURE = 10000;
local MAX_FAITH = 10000;
local MAX_TECH = 50;

local GOLD_STEP = 10
local CULTURE_STEP = 10
local FAITH_STEP = 10
local TECH_STEP = nil

-- local IsGodsAndKings = ContentManager.IsActive("0E3751A1-F840-4E1B-9706-519BF484E59D", ContentType.GAMEPLAY);
-- local IsBraveNewWorld = ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY);

--------------------------------------------------------------------------------------------------
function BuildBonuses()
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot == nil then
		return
	end

	function OnGoldSlider(fValue)
		slot.startGold = GetSliderValue(fValue, 0, MAX_GOLD, GOLD_STEP);
		Controls.GoldValue:SetText(tostring(slot.startGold));
	end
	Controls.GoldSlider:RegisterSliderCallback(OnGoldSlider);

	function OnCultureSlider(fValue)
		slot.startCulture = GetSliderValue(fValue, 0, MAX_CULTURE, CULTURE_STEP);
		Controls.CultureValue:SetText(tostring(slot.startCulture));
	end
	Controls.CultureSlider:RegisterSliderCallback(OnCultureSlider);

	function OnFaithSlider(fValue)
		slot.startFaith = GetSliderValue(fValue, 0, MAX_FAITH, FAITH_STEP);
		Controls.FaithValue:SetText(tostring(slot.startFaith));
	end
	Controls.FaithSlider:RegisterSliderCallback(OnFaithSlider);

	function OnTechSlider(fValue)
		slot.freeTechs = GetSliderValue(fValue, 0, MAX_TECH, TECH_STEP);
		Controls.TechValue:SetText(tostring(slot.freeTechs));
	end
	Controls.TechSlider:RegisterSliderCallback(OnTechSlider);

	Controls.GoldValue:SetText(tostring(slot.startGold));
	Controls.CultureValue:SetText(tostring(slot.startCulture));
	Controls.FaithValue:SetText(tostring(slot.startFaith));
	Controls.TechValue:SetText(tostring(slot.freeTechs));

	SetSliderValue(Controls.GoldSlider, slot.startGold, 0, MAX_GOLD, GOLD_STEP);
	SetSliderValue(Controls.CultureSlider, slot.startCulture, 0, MAX_CULTURE, CULTURE_STEP);
	SetSliderValue(Controls.FaithSlider, slot.startFaith, 0, MAX_FAITH, FAITH_STEP);
	SetSliderValue(Controls.TechSlider, slot.freeTechs, 0, MAX_TECH, TECH_STEP);

	-- Copy Buttons -----------------------------------------------------------------------------
	function OnCopyGold()
		print("OnCopyGold");
		local currentSlot = SlotData:GetSlot(GlobalData.currentPlayer);

		if currentSlot ~= nil then
			for playerID, slot in SlotData:SlotList() do
				slot.startGold = currentSlot.startGold;
			end
		end
	end
	Controls.CopyGold:RegisterCallback(Mouse.eLClick, OnCopyGold);

	function OnCopyCulture()
		local currentSlot = SlotData:GetSlot(GlobalData.currentPlayer);

		if currentSlot ~= nil then
			for playerID, slot in SlotData:SlotList() do
				slot.startCulture = currentSlot.startCulture;
			end
		end
	end
	Controls.CopyCulture:RegisterCallback(Mouse.eLClick, OnCopyCulture);

	function OnCopyFaith()
		local currentSlot = SlotData:GetSlot(GlobalData.currentPlayer);

		if currentSlot ~= nil then
			for playerID, slot in SlotData:SlotList() do
				slot.startFaith = currentSlot.startFaith;
			end
		end
	end
	Controls.CopyFaith:RegisterCallback(Mouse.eLClick, OnCopyFaith);

	function OnCopyTech()
		local currentSlot = SlotData:GetSlot(GlobalData.currentPlayer);

		if currentSlot ~= nil then
			for playerID, slot in SlotData:SlotList() do
				slot.freeTechs = currentSlot.freeTechs;
			end
		end
	end
	Controls.CopyTech:RegisterCallback(Mouse.eLClick, OnCopyTech);

	if not HasExpansionPack() then
		Controls.FaithSlider:SetDisabled(true);
		Controls.CopyFaith:SetDisabled(true);
	end
end

--------------------------------------------------------------------------------------------------
function BuildStartBias()
	local regionPulldowns = { Controls.RegionOnePulldown, Controls.RegionTwoPulldown, Controls.RegionThreePulldown };
	local slot = SlotData:GetSlot(GlobalData.currentPlayer);

	if slot ~= nil then
		if GameData.gameOptions["GAMEOPTION_DISABLE_START_BIAS"] == true then
			-- Disable and hide StartBias -----------------------------------------------------------------------------
			slot:ResetStartBias();
			Controls.StartBiasLabel:SetHide(true);
			Controls.StartBiasPulldown:SetHide(true);
			for i = 1, #regionPulldowns, 1 do
				regionPulldowns[i]:SetHide(true);
			end

		else
			-- Build and display StartBias -----------------------------------------------------------------------------
			Controls.StartBiasLabel:SetHide(false);
			Controls.StartBiasPulldown:SetHide(false);
			Controls.StartBiasPulldown:ClearEntries();

			for id = 1, START_BIAS_COUNT, 1 do
				local control = {};
				Controls.StartBiasPulldown:BuildEntry("InstanceOne", control);
				control.Button:SetVoid1(id);
				control.Button:LocalizeAndSetText(GetStartBiasText(id));
			end

			Controls.StartBiasPulldown:GetButton():LocalizeAndSetText(GetStartBiasText(slot.startBias));
			Controls.StartBiasPulldown:CalculateInternals();

			-- Create StartBias menu handler.
			function OnStartBias(id)
				slot.startBias = id;
				Controls.StartBiasPulldown:GetButton():LocalizeAndSetText(GetStartBiasText(slot.startBias));
				BuildStartBias();
			end
			Controls.StartBiasPulldown:RegisterSelectionCallback(OnStartBias)

			-- Update region menus.
			if slot.startBias ~= START_REGION_PRIORITY and slot.startBias ~= START_REGION_AVOID then
				Controls.NoRegionsLine:SetHide(false);
				-- Disable and hide region menus.
				slot.startRegions = {};
				for i = 1, #regionPulldowns, 1 do
					regionPulldowns[i]:SetHide(true);
				end

			else
				Controls.NoRegionsLine:SetHide(true);
				-- Build and display region menus.
				local menusDisabled = false;

				for i = 1, #regionPulldowns, 1 do
					if slot.startRegions[i] == nil then
						slot.startRegions[i] = 0;
					end

					if menusDisabled then
						regionPulldowns[i]:SetHide(true);
						slot.startRegions[i] = 0;

					else
						regionPulldowns[i]:SetHide(false);
						regionPulldowns[i]:ClearEntries();

						-- Add any region that doesn't already exist in one of the other region menus.
						for region in GameInfo.Regions() do
							addRegion = true;

							if region.ID == 0 then
								if slot.startRegions[i] == 0 then
									addRegion = false;
								end

							else
								for j = 1, #slot.startRegions, 1 do
									if region.ID == slot.startRegions[j] then
										addRegion = false;
										break;
									end
								end
							end

							if addRegion then
								local control = {};
								regionPulldowns[i]:BuildEntry("InstanceOne", control);
								control.Button:SetVoids(i, region.ID);
								control.Button:LocalizeAndSetText(region.Description);
							end
						end

						if GameInfo.Regions[slot.startRegions[i]] then
							regionPulldowns[i]:GetButton():LocalizeAndSetText(GameInfo.Regions[slot.startRegions[i]].Description);
						end
						
						regionPulldowns[i]:CalculateInternals();

						-- Create menu handler for this Region ------------------------------------------------------------------
						function OnRegion(i, id)
							slot.startRegions[i] = id;
							BuildStartBias();
						end
						regionPulldowns[i]:RegisterSelectionCallback(OnRegion)

						-- Only display as many menus as needed. Since this menu has no region selected disable adding more menus.
						if slot.startRegions[i] == 0 then
							menusDisabled = true;
						end
					end
				end
			end
		end
	end
end

------------------------------------------------------------------
function ValidateControls()
	LuaEvents.GTAS_ValidateControls();
end

----------------------------------------------------------------
function PerformBuild()
	BuildBonuses();
	BuildStartBias();
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
	Controls.BonusPanel:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET);
	Controls.BonusBorder1:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 4);
	Controls.BonusBorder2:SetSizeY(screenY - PLAYER_PANEL_HEIGHT_OFFSET - 6);
end

-------------------------------------------------
function OnUpdateUI( type )
    if( type == SystemUpdateUIType.ScreenResize ) then
        AdjustScreenSize();
    end
end
Events.SystemUpdateUI.Add( OnUpdateUI );

AdjustScreenSize();





















