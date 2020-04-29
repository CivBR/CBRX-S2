
-------------------------------------------------
-- Choose Ideology Popup
-------------------------------------------------

include( "IconSupport" );
include( "InstanceManager" );
include( "CommonBehaviors" );

-- Used for Piano Keys
local ltBlue = {19/255,32/255,46/255,120/255};
local dkBlue = {12/255,22/255,30/255,120/255};

local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );

local g_ViewTenetsLevel1Manager = InstanceManager:new( "ViewTenetsInstance", "Button", Controls.Level1TenetsStack );
local g_ViewTenetsLevel2Manager = InstanceManager:new( "ViewTenetsInstance", "Button", Controls.Level2TenetsStack );
local g_ViewTenetsLevel3Manager = InstanceManager:new( "ViewTenetsInstance", "Button", Controls.Level3TenetsStack );

local bHidden = true;

local screenSizeX, screenSizeY = UIManager:GetScreenSizeVal()
local spWidth, spHeight = Controls.ItemScrollPanel:GetSizeVal();

-- Original UI designed at 1050px 
local heightOffset = screenSizeY - 1020;

spHeight = spHeight + heightOffset;
Controls.ItemScrollPanel:SetSizeVal(spWidth, spHeight); 
Controls.ItemScrollPanel:CalculateInternalSize();
Controls.ItemScrollPanel:ReprocessAnchoring();

local bpWidth, bpHeight = Controls.BottomPanel:GetSizeVal();
--bpHeight = bpHeight * heightRatio;
print(heightOffset);
print(bpHeight);
bpHeight = bpHeight + heightOffset 
print(bpHeight);

Controls.BottomPanel:SetSizeVal(bpWidth, bpHeight);
Controls.BottomPanel:ReprocessAnchoring();

local g_PopupInfo = nil;
-------------------------------------------------
-------------------------------------------------
function OnPopupMessage(popupInfo)
	  
	local popupType = popupInfo.Type;
	
	g_iUnitIndex = popupInfo.Data2;
	
	if popupType ~= ButtonPopupTypes.BUTTONPOPUP_CHOOSE_IDEOLOGY then
		return;
	end	
	
	g_PopupInfo = popupInfo;
	
   	UIManager:QueuePopup( ContextPtr, PopupPriority.SocialPolicy );
end
Events.SerialEventGameMessagePopup.Add( OnPopupMessage );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    ----------------------------------------------------------------        
    -- Key Down Processing
    ----------------------------------------------------------------        
    if uiMsg == KeyEvents.KeyDown then
        if (wParam == Keys.VK_ESCAPE) then
			if(not Controls.ViewTenetsPopup:IsHidden()) then
				Controls.ViewTenetsPopup:SetHide(true);
			elseif(not Controls.ChooseConfirm:IsHidden()) then
				Controls.ChooseConfirm:SetHide(true);
			else
				OnClose();
			end
        	return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnClose()
    UIManager:DequeuePopup(ContextPtr);
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function RefreshList()
	g_ItemManager:ResetInstances();
		
	local pPlayer = Players[Game.GetActivePlayer()];
	CivIconHookup( pPlayer:GetID(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	   
	local ideologies 
	ideologies = {
		{
			PolicyBranchType = "POLICY_BRANCH_ORDER",
			VictoryTypes = {"CultureVictory", "DominationVictory", "ScienceVictory"},
			Image = "SocialPoliciesOrder.dds",
			ImageOffsetX = 0,
			ImageOffsetY = 0,
			-- JFD
			IdeologicalValue = "IDEOLOGICAL_VALUE_JFD_EQUALITY",
			-- JFD
		},		
		{
			PolicyBranchType = "POLICY_BRANCH_AUTOCRACY",
			VictoryTypes = {"CultureVictory", "DiplomaticVictory", "DominationVictory"},
			Image = "SocialPoliciesAutocracy.dds",
			ImageOffsetX = 0,
			ImageOffsetY = 20,
			-- JFD
			IdeologicalValue = "IDEOLOGICAL_VALUE_JFD_AUTHORITY",
			-- JFD
		},
		{
			PolicyBranchType = "POLICY_BRANCH_FREEDOM",
			VictoryTypes = {"CultureVictory", "DiplomaticVictory", "ScienceVictory"},
			Image = "SocialPoliciesFreedom.dds",
			ImageOffsetX = 0,
			ImageOffsetY = 0,
			-- JFD
			IdeologicalValue = "IDEOLOGICAL_VALUE_JFD_LIBERTY",
			-- JFD
		},
		{
			PolicyBranchType = "POLICY_BRANCH_JFD_NEUTRALITY",
			VictoryTypes = {"DiplomaticVictory", "CultureVictory", "DominationVictory", "ScienceVictory"},
			Image = "SocialPoliciesNeutrality.dds",
			ImageOffsetX = 0,
			ImageOffsetY = 50,
		}			
	}	
	
	local adoptedIdeologies = {};
	
	for player_num = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[player_num];
		if(player and player:IsAlive()) then
			local branchId = player:GetLateGamePolicyTree();
			local adoptedIdeology = adoptedIdeologies[branchId] or {};
			table.insert(adoptedIdeology, player:GetID());
		
			adoptedIdeologies[branchId] = adoptedIdeology;
		end
	end
	
	local activePlayerTeam = Teams[pPlayer:GetTeam()];
			
	local tick = true;
	for _, ideology in ipairs(ideologies) do
	
		local branch = GameInfo.PolicyBranchTypes[ideology.PolicyBranchType];
		if branch then 
			local branchID = branch.ID;
			local itemInstance = g_ItemManager:GetInstance();
			itemInstance.Name:LocalizeAndSetText(branch.Description);
			
			print(ideology.IdeologicalValue)
			if GameInfoTypes[ideology.IdeologicalValue] then
				local pPreferredIdeologicalValue = GameInfo.JFD_IdeologicalValues[ideology.IdeologicalValue]
				itemInstance.IdeologicalValue:SetHide(false)
				itemInstance.IdeologicalValue:LocalizeAndSetText("TXT_KEY_CHOOSE_IDEOLOGY_IDEOLOGICAL_VALUE", pPreferredIdeologicalValue.IconString, pPreferredIdeologicalValue.Description)
				itemInstance.IdeologicalValue:LocalizeAndSetToolTip("TXT_KEY_CHOOSE_IDEOLOGY_IDEOLOGICAL_VALUE_TT", pPreferredIdeologicalValue.IconString, pPreferredIdeologicalValue.Description)
			else
				itemInstance.IdeologicalValue:SetHide(true)
			end
	
			local iFreePolicies = Game.GetNumFreePolicies(branch.ID);
			local szFreePolicyInfo = Locale.Lookup("TXT_KEY_CHOOSE_IDEOLOGY_NUM_FREE_POLICIES", iFreePolicies);
			if (iFreePolicies > 0) then
				szFreePolicyInfo = "[COLOR_POSITIVE_TEXT]" .. szFreePolicyInfo .. "[ENDCOLOR]";
			end
			itemInstance.FreePolicies:SetText(szFreePolicyInfo);	
			
			itemInstance.CultureVictory:SetHide(true);
			itemInstance.DiplomaticVictory:SetHide(true);
			itemInstance.DominationVictory:SetHide(true);
			itemInstance.ScienceVictory:SetHide(true);
		
			for _, victoryControl in ipairs(ideology.VictoryTypes) do
				print(victoryControl);
				itemInstance[victoryControl]:SetHide(false);
			end
			
			itemInstance.AdoptedByStack1:DestroyAllChildren();
			itemInstance.AdoptedByStack2:DestroyAllChildren();
			
			local adoptedIdeology = adoptedIdeologies[branchID];
			
			
			
			if(adoptedIdeology ~= nil and #adoptedIdeology > 0) then
			
				local adoptedIdeologyCount = #adoptedIdeology;
				
				for i = 1, math.min(adoptedIdeologyCount, 12), 1 do
					local control = {};
					ContextPtr:BuildInstanceForControl( "CivInstance", control, itemInstance.AdoptedByStack1);
					
					local playerID = adoptedIdeology[i];
					
					local player = Players[playerID];
					if(activePlayerTeam:IsHasMet(player:GetTeam())) then
						CivIconHookup(playerID, 32, control.CivIcon, control.CivIconBG, control.CivIconShadow, true, true, control.CivIconHighlight);
					else
						CivIconHookup(-1, 32, control.CivIcon, control.CivIconBG, control.CivIconShadow, true, true, control.CivIconHighlight);
					end
				end
				
				if(adoptedIdeologyCount > 12) then
					for i = 13, math.min(adoptedIdeologyCount, 24), 1 do
						local control = {};
						ContextPtr:BuildInstanceForControl( "CivInstance", control, itemInstance.AdoptedByStack2);
						
						local playerID = adoptedIdeology[i];
						
						local player = Players[playerID];
						if(activePlayerTeam:IsHasMet(player:GetTeam())) then
							CivIconHookup(playerID, 32, control.CivIcon, control.CivIconBG, control.CivIconShadow, true, true, control.CivIconHighlight);
						else
							CivIconHookup(-1, 32, control.CivIcon, control.CivIconBG, control.CivIconShadow, true, true, control.CivIconHighlight);
						end
					end
				end
			
				itemInstance.AdoptedByNobody:SetHide(true);
			else
				itemInstance.AdoptedByNobody:SetHide(false);
			end
		
			itemInstance.AdoptedByStack1:CalculateSize();
			itemInstance.AdoptedByStack1:ReprocessAnchoring();
			itemInstance.AdoptedByStack2:CalculateSize();
			itemInstance.AdoptedByStack2:ReprocessAnchoring();
			itemInstance.AdoptedByStacks:CalculateSize();
			itemInstance.AdoptedByStacks:ReprocessAnchoring();
		
			itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectIdeologyChoice(branch.ID); end);
			
			if ideology.PolicyBranchType == "POLICY_BRANCH_JFD_NEUTRALITY" then
				if (not pPlayer:CanAdoptNeutralityIdeology()) then
					itemInstance.Button:SetAlpha(0.5)
					itemInstance.Button:SetDisabled(true)
					itemInstance.Button:LocalizeAndSetToolTip("TXT_KEY_JFD_IDEOLOGY_NEUTRALITY_DISABLED_TT")
				else
					itemInstance.Button:SetAlpha(1)
					itemInstance.Button:SetDisabled(false)
					itemInstance.Button:LocalizeAndSetToolTip(nil)
				end
			end	
			
			local color = tick and ltBlue or dkBlue;
			tick = not tick;
			
			itemInstance.Box:SetColorVal(unpack(color));
			local buttonWidth, buttonHeight = itemInstance.Button:GetSizeVal();
			local stackWidth, stackHeight = itemInstance.AdoptedByStacks:GetSizeVal();
			
			local newHeight = 170 + stackHeight;	
			
			itemInstance.Button:SetSizeVal(buttonWidth, newHeight);
			itemInstance.Box:SetSizeVal(buttonWidth, newHeight);
			
			itemInstance.BounceAnim:SetSizeVal(buttonWidth, newHeight + 5);
			itemInstance.BounceGrid:SetSizeVal(buttonWidth, newHeight + 5);
			
			itemInstance.IdeologyImage:SetTexture(ideology.Image);
			itemInstance.IdeologyImage:SetTextureOffsetVal(ideology.ImageOffsetX, ideology.ImageOffsetY);
			
			local ideologyImageWidth, ideologyImageHeight = itemInstance.IdeologyImage:GetSizeVal();
			itemInstance.IdeologyImage:SetSizeVal(ideologyImageWidth, newHeight);
			itemInstance.IdeologyImage:SetTextureSizeVal(ideologyImageWidth, newHeight);
			itemInstance.IdeologyImage:NormalizeTexture();
			
			itemInstance.ShowTenets:RegisterCallback(Mouse.eLClick, function()
				ViewTenets(ideology.PolicyBranchType);
			end);
		end
	end
	
	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
end

function SelectIdeologyChoice(iChoice) 
	g_iChoice = iChoice;
	
	local branch = GameInfo.PolicyBranchTypes[iChoice];
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_IDEOLOGY_CONFIRM", branch.Description); 
	Controls.ChooseConfirm:SetHide(false);
end

function OnConfirmYes( )
	Controls.ChooseConfirm:SetHide(true);
	
	Network.SendIdeologyChoice(Game.GetActivePlayer(), g_iChoice);
	Events.AudioPlay2DSound("AS2D_INTERFACE_POLICY");	
	OnClose();
end
Controls.ConfirmYes:RegisterCallback( Mouse.eLClick, OnConfirmYes );

function OnConfirmNo( )
	Controls.ChooseConfirm:SetHide(true);
end
Controls.ConfirmNo:RegisterCallback( Mouse.eLClick, OnConfirmNo );


function ViewTenets(branchType)
	print("branchType", branchType)
	g_ViewTenetsLevel1Manager:ResetInstances();
	g_ViewTenetsLevel2Manager:ResetInstances();
	g_ViewTenetsLevel3Manager:ResetInstances();
	
	local tick = true;	
	
	function PopulateInstance(instance, row, text)
		local pPlayer = Players[Game.GetActivePlayer()]
		
		instance.TenetDescription:LocalizeAndSetText(text);
		instance.Button:SetDisabled(true);
		
		local width,height = instance.TenetDescription:GetSizeVal();
		local newHeight = height + 30;
		instance.Button:SetSizeVal(width, newHeight);
		
		-- JFD
		if Player.HasIdeologicalValuesForTenet then
			local ideologicalValue = pPlayer:GetPolicyIdeologicalValue(row.ID)
			local ideologicalValueReq = row.IdeologicalValueReq
			local hasIdeologicalValuesForTenet = pPlayer:HasIdeologicalValuesForTenet(row.ID)
			if hasIdeologicalValuesForTenet then
				instance.IdeologicalValueLabel:LocalizeAndSetText("{1_Icon} [COLOR_UNIT_TEXT]{2_Num}%[ENDCOLOR]", GameInfo.JFD_IdeologicalValues[ideologicalValue].IconString, ideologicalValueReq)
				instance.Button:SetAlpha(1)
				instance.Button:LocalizeAndSetToolTip("TXT_KEY_CHOOSE_IDEOLOGY_PREVIEW_IDEOLOGICAL_VALUE_POSITIVE_TT")
				instance.IdeologicalValueLabel:LocalizeAndSetToolTip("TXT_KEY_CHOOSE_IDEOLOGY_PREVIEW_IDEOLOGICAL_VALUE_POSITIVE_TT")
			else
				instance.IdeologicalValueLabel:LocalizeAndSetText("{1_Icon} [COLOR_WARNING_TEXT]{2_Num}%[ENDCOLOR]", GameInfo.JFD_IdeologicalValues[ideologicalValue].IconString, ideologicalValueReq)
				instance.Button:SetAlpha(0.5)
				instance.Button:LocalizeAndSetToolTip("TXT_KEY_CHOOSE_IDEOLOGY_PREVIEW_IDEOLOGICAL_VALUE_WARNING_TT")
				instance.IdeologicalValueLabel:LocalizeAndSetToolTip("TXT_KEY_CHOOSE_IDEOLOGY_PREVIEW_IDEOLOGICAL_VALUE_WARNING_TT")
			end
		end
		-- JFD
					
		local width,height = instance.TenetDescription:GetSizeVal();
		local newHeight = height + 30;
		instance.Button:SetSizeVal(width, newHeight);
		
		local boxWidth, boxHeight = instance.Box:GetSizeVal();
		instance.Box:SetSizeVal(boxWidth, newHeight);
		
		local color = tick and ltBlue or dkBlue;
		tick = not tick;
			
		instance.Box:SetColorVal(unpack(color));
	end
	
	-- JFD
	if Player.HasIdeologicalValuesForTenet then
		local pPlayer = Players[Game.GetActivePlayer()]
		
		local level1Tenets = {}
		local level1TenetsCount = 1
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 1} do
			local tenet = {};
			tenet.Tenet = row;
			tenet.Description = Locale.ConvertTextKey(row.Description);
			level1Tenets[level1TenetsCount] = tenet
			level1TenetsCount = level1TenetsCount + 1
			table.sort(level1Tenets, function(a, b) return a.Description < b.Description end);
		end
		local numLevel1Tenets = #level1Tenets
		for index = 1, numLevel1Tenets do
			local row = level1Tenets[index].Tenet
			local instance = g_ViewTenetsLevel1Manager:GetInstance();
			local ideologicalValue = pPlayer:GetPolicyIdeologicalValue(row.ID)
			local ideologicalValueReq = row.IdeologicalValueReq
			if ideologicalValue then
				local helpText = Locale.ConvertTextKey(row.Help)
				PopulateInstance(instance, row, helpText);
			end
		end
		
		local level2Tenets = {}
		local level2TenetsCount = 1
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 2} do
			local tenet = {};
			tenet.Tenet = row;
			tenet.Description = Locale.ConvertTextKey(row.Description);
			level2Tenets[level2TenetsCount] = tenet
			level2TenetsCount = level2TenetsCount + 1
			table.sort(level2Tenets, function(a, b) return a.Description < b.Description end);
		end
		local numLevel2Tenets = #level2Tenets
		for index = 2, numLevel2Tenets do
			local row = level2Tenets[index].Tenet
			local instance = g_ViewTenetsLevel2Manager:GetInstance();
			local ideologicalValue = pPlayer:GetPolicyIdeologicalValue(row.ID)
			local ideologicalValueReq = row.IdeologicalValueReq
			if ideologicalValue then
				local helpText = Locale.ConvertTextKey(row.Help)
				PopulateInstance(instance, row, helpText);
			end
		end
		
		local level3Tenets = {}
		local level3TenetsCount = 1
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 3} do
			local tenet = {};
			tenet.Tenet = row;
			tenet.Description = Locale.ConvertTextKey(row.Description);
			level3Tenets[level3TenetsCount] = tenet
			level3TenetsCount = level3TenetsCount + 1
			table.sort(level3Tenets, function(a, b) return a.Description < b.Description end);
		end
		local numLevel3Tenets = #level3Tenets
		for index = 3, numLevel3Tenets do
			local row = level3Tenets[index].Tenet
			local instance = g_ViewTenetsLevel3Manager:GetInstance();
			local ideologicalValue = pPlayer:GetPolicyIdeologicalValue(row.ID)
			local ideologicalValueReq = row.IdeologicalValueReq
			if ideologicalValue then
				local helpText = Locale.ConvertTextKey(row.Help)
				PopulateInstance(instance, row, helpText);
			end
		end
	-- JFD
	
	else
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 1} do
			local instance = g_ViewTenetsLevel1Manager:GetInstance();
			PopulateInstance(instance, nil, row.Help);
		end
		
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 2} do
			local instance = g_ViewTenetsLevel2Manager:GetInstance();
			PopulateInstance(instance, nil, row.Help);
		end
		
		for row in GameInfo.Policies{PolicyBranchType = branchType, Level = 3} do
			local instance = g_ViewTenetsLevel3Manager:GetInstance();
			PopulateInstance(instance, nil, row.Help);
		end
	end

	Controls.Level1TenetsStack:CalculateSize();
	Controls.Level1TenetsStack:ReprocessAnchoring();
	Controls.Level2TenetsStack:CalculateSize();
	Controls.Level2TenetsStack:ReprocessAnchoring();
	Controls.Level3TenetsStack:CalculateSize();
	Controls.Level3TenetsStack:ReprocessAnchoring();
	Controls.ViewTenetsStack:CalculateSize();
	Controls.ViewTenetsStack:ReprocessAnchoring();
	
	Controls.ViewTenetsScrollPanel:CalculateInternalSize();
	
	Controls.ViewTenetsPopup:SetHide(false);
end

function OnViewTenetsPopupCloseButton()
	Controls.ViewTenetsPopup:SetHide(true);
end
Controls.ViewTenetsCloseButton:RegisterCallback(Mouse.eLClick, OnViewTenetsPopupCloseButton);


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

	bHidden = bIsHide;
    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
        	Events.SerialEventGameMessagePopupShown(g_PopupInfo);
        	
        	RefreshList();
        
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide( true );
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide( true );
			end
               	
        else
      
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide(false);
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide(false);
			end
			
			if(g_PopupInfo ~= nil) then
				Events.SerialEventGameMessagePopupProcessed.CallImmediate(g_PopupInfo.Type, 0);
			end
            UI.decTurnTimerSemaphore();
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );

function OnDirty()
	-- If the user performed any action that changes selection states, just close this UI.
	if not bHidden then
		OnClose();
	end
end
Events.UnitSelectionChanged.Add( OnDirty );

-------------------------------
-- Collapse/Expand Behaviors --
-------------------------------
function OnCollapseExpand()
	Controls.Level1TenetsStack:CalculateSize();
	Controls.Level1TenetsStack:ReprocessAnchoring();
	Controls.Level2TenetsStack:CalculateSize();
	Controls.Level2TenetsStack:ReprocessAnchoring();
	Controls.Level3TenetsStack:CalculateSize();
	Controls.Level3TenetsStack:ReprocessAnchoring();
	Controls.ViewTenetsStack:CalculateSize();
	Controls.ViewTenetsStack:ReprocessAnchoring();
	
	Controls.ViewTenetsScrollPanel:CalculateInternalSize();
end

local ViewTenetsLevel1HeaderText = Locale.Lookup("TXT_KEY_POLICYSCREEN_L1_TENET");
RegisterCollapseBehavior{	
	Header = Controls.Level1TenetsHeader, 
	HeaderLabel = Controls.Level1TenetsHeaderLabel, 
	HeaderExpandedLabel = "[ICON_MINUS] " .. ViewTenetsLevel1HeaderText,
	HeaderCollapsedLabel = "[ICON_PLUS] " .. ViewTenetsLevel1HeaderText,
	Panel = Controls.Level1TenetsStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
};

local ViewTenetsLevel2HeaderText = Locale.Lookup("TXT_KEY_POLICYSCREEN_L2_TENET");
RegisterCollapseBehavior{	
	Header = Controls.Level2TenetsHeader, 
	HeaderLabel = Controls.Level2TenetsHeaderLabel, 
	HeaderExpandedLabel = "[ICON_MINUS] " .. ViewTenetsLevel2HeaderText,
	HeaderCollapsedLabel = "[ICON_PLUS] " .. ViewTenetsLevel2HeaderText,
	Panel = Controls.Level2TenetsStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
};

local ViewTenetsLevel3HeaderText = Locale.Lookup("TXT_KEY_POLICYSCREEN_L3_TENET");
RegisterCollapseBehavior{	
	Header = Controls.Level3TenetsHeader, 
	HeaderLabel = Controls.Level3TenetsHeaderLabel, 
	HeaderExpandedLabel = "[ICON_MINUS] " .. ViewTenetsLevel3HeaderText,
	HeaderCollapsedLabel = "[ICON_PLUS] " .. ViewTenetsLevel3HeaderText,
	Panel = Controls.Level3TenetsStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
};