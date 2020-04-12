
-- GTAS_SetCivNames - Part of Really Advanced Setup Mod

include("GTAS_Constants");

local Current_Player = 0;

-------------------------------------------------
-------------------------------------------------
function OnReset()
	local slot = SlotData:GetSlot(Current_Player);

	if slot ~= nil then	
		slot.leaderName, slot.civDescription, slot.civShortDescription, slot.civAdjective = "", "", "", "";
	end	

	LoadDefaults()
end
Controls.ResetButton:RegisterCallback(Mouse.eLClick, OnReset);

-------------------------------------------------
-------------------------------------------------
function OnCancel()
    UIManager:PopModal(ContextPtr);
    ContextPtr:CallParentShowHideHandler(false);
    ContextPtr:SetHide(true);
end
Controls.CancelButton:RegisterCallback(Mouse.eLClick, OnCancel);

-------------------------------------------------
-------------------------------------------------
function OnAccept()	
	local defaultLeaderName = "";
	local defaultDescription = "";
	local defaultShortDescription = "";
	local defaultAdjective = "";
	
	local slot = SlotData:GetSlot(Current_Player);

	if slot ~= nil then		
		local controlsNotSet = true;
		local civ = GameInfo.Civilizations[slot.civType];
		
		if civ ~= nil  and slot.civType ~= RANDOM_CIVILIZATION then
			local civ_leader = GameInfo.Civilization_Leaders("CivilizationType = '" .. civ.Type .. "'")();
			
			if civ_leader ~= nil then
				local leader = GameInfo.Leaders[civ_leader.LeaderheadType];
				
				if leader ~= nil then	
					controlsNotSet = false;					
					defaultLeaderName = Locale.ConvertTextKey(leader.Description);
					defaultDescription = Locale.ConvertTextKey(civ.Description);
					defaultShortDescription = Locale.ConvertTextKey(civ.ShortDescription);
					defaultAdjective = Locale.ConvertTextKey(civ.Adjective);
				end
			end
		end
		
		if controlsNotSet then
			defaultLeaderName = Locale.ConvertTextKey("TXT_KEY_RANDOM_LEADER");
			defaultDescription = Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV");
			defaultShortDescription = Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV");
			defaultAdjective = Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV");
		end
	
		slot.leaderName, slot.civDescription, slot.civShortDescription, slot.civAdjective = "", "", "", "";
				
		if Controls.EditCivLeader:GetText() ~= defaultLeaderName then
			slot.leaderName = Controls.EditCivLeader:GetText();
		end
		
		if Controls.EditCivName:GetText() ~= defaultDescription then
			slot.civDescription = Controls.EditCivName:GetText();
		end
		
		if Controls.EditCivShortName:GetText() ~= defaultShortDescription then
			slot.civShortDescription = Controls.EditCivShortName:GetText();
		end
		
		if Controls.EditCivAdjective:GetText() ~= defaultAdjective then
			slot.civAdjective = Controls.EditCivAdjective:GetText();
		end
	end
    	
	UIManager:PopModal(ContextPtr);
    ContextPtr:CallParentShowHideHandler(false);
    ContextPtr:SetHide(true);
end
Controls.AcceptButton:RegisterCallback(Mouse.eLClick, OnAccept);

----------------------------------------------------------------
-- Input processing
----------------------------------------------------------------
function InputHandler(uiMsg, wParam, lParam)
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE then
            OnCancel();  
        end
        if wParam == Keys.VK_RETURN then
            OnAccept();  
        end
    end
    return true;
end
ContextPtr:SetInputHandler(InputHandler);


----------------------------------------------------------------
----------------------------------------------------------------
function ValidateText(text)
	local isAllWhiteSpace = true;
	for i = 1, #text, 1 do
		if(string.byte(text, i) ~= 32) then
			isAllWhiteSpace = false;
			break;
		end
	end
	
	if(isAllWhiteSpace) then
		return false;
	end
	
	-- don't allow % character
	for i = 1, #text, 1 do
		if string.byte(text, i) == 37 then
			return false;
		end
	end
	
	local invalidCharArray = { '\"', '<', '>', '|', '\b', '\0', '\t', '\n', '/', '\\', '*', '?' };

	for i, ch in ipairs(invalidCharArray) do
		if string.find(text, ch) ~= nil then
			return false;
		end
	end
	
	-- don't allow control characters
	for i = 1, #text, 1 do
		if string.byte(text, i) < 32 then
			return false;
		end
	end

	return true;
end

---------------------------------------------------------------
function Validate()
	if	ValidateText(Controls.EditCivShortName:GetText()) and
		ValidateText(Controls.EditCivLeader:GetText()) and
		ValidateText(Controls.EditCivName:GetText()) and
		ValidateText(Controls.EditCivAdjective:GetText()) then
			Controls.AcceptButton:SetDisabled(false);
	else
			Controls.AcceptButton:SetDisabled(true);
	end
end
---------------------------------------------------------------
Controls.EditCivName:RegisterCallback(Validate);
Controls.EditCivLeader:RegisterCallback(Validate);
Controls.EditCivShortName:RegisterCallback(Validate);
Controls.EditCivAdjective:RegisterCallback(Validate);

----------------------------------------------------------------
----------------------------------------------------------------
function LoadDefaults()
	local slot = SlotData:GetSlot(Current_Player);
	
	if slot ~= nil then		
		local controlsNotSet = true;
		local civ = GameInfo.Civilizations[slot.civType];
		
		if civ ~= nil  and slot.civType ~= RANDOM_CIVILIZATION then
			local civ_leader = GameInfo.Civilization_Leaders("CivilizationType = '" .. civ.Type .. "'")();
			
			if civ_leader ~= nil then
				local leader = GameInfo.Leaders[civ_leader.LeaderheadType];
				
				if leader ~= nil then	
					controlsNotSet = false;					
					Controls.EditCivLeader:SetText(Locale.ConvertTextKey(leader.Description));
					Controls.EditCivName:SetText(Locale.ConvertTextKey(civ.Description));
					Controls.EditCivShortName:SetText(Locale.ConvertTextKey(civ.ShortDescription));
					Controls.EditCivAdjective:SetText(Locale.ConvertTextKey(civ.Adjective));
				end
			end
		end
		
		if controlsNotSet then
			Controls.EditCivLeader:SetText(Locale.ConvertTextKey("TXT_KEY_RANDOM_LEADER"));
			Controls.EditCivName:SetText(Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV"));
			Controls.EditCivShortName:SetText(Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV"));
			Controls.EditCivAdjective:SetText(Locale.ConvertTextKey("TXT_KEY_RANDOM_CIV"));
		end

		if slot.leaderName ~= "" then
			Controls.EditCivLeader:SetText(slot.leaderName);
		end
		
		if slot.civDescription ~= "" then
			Controls.EditCivName:SetText(slot.civDescription);
		end
		
		if slot.civShortDescription ~= "" then
			Controls.EditCivShortName:SetText(slot.civShortDescription);
		end
		
		if slot.civAdjective ~= "" then
			Controls.EditCivAdjective:SetText(slot.civAdjective);
		end
	end		
end

-------------------------------------------------
-------------------------------------------------
function ShowHideHandler(bIsHide, bIsInit)
 	local buffer = {};
	LuaEvents.GetDataObjects(buffer);
	SlotData = buffer[DATA_SLOT];
   
    if not bIsHide then
		if Current_Player == 0 then
			Controls.ScreenTitle:LocalizeAndSetText("TXT_KEY_GTAS_NAME_YOUR_CIV");
		else
			Controls.ScreenTitle:LocalizeAndSetText("TXT_KEY_GTAS_NAME_OTHER_CIV");
		end
		
		LoadDefaults();
		Controls.EditCivLeader:TakeFocus();
   	end

end
ContextPtr:SetShowHideHandler(ShowHideHandler);

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnSetCivNameEditSlot(slot)
	if slot > -1 then
		Current_Player = slot;
	end
end
LuaEvents.SetCivNameEditSlot.Add(OnSetCivNameEditSlot);
       


