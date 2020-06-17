
-------------------------------------------------
-- SocialPolicy Chooser Popup
-------------------------------------------------

include( "IconSupport" );
include( "InstanceManager" );
include( "CommonBehaviors" );
include( "FLuaVector" );

local g_IsCBRTestActive = Game.IsCBRTesterActive()

local m_PopupInfo = nil;

g_Tabs = {
	["YourGovernment"] = {
		Button = Controls.TabButtonYourGovernment,
		Panel = Controls.YourGovernmentPanel,
		SelectHighlight = Controls.TabButtonYourGovernmentHL,
	},
	
	["YourReforms"] = {
		Button = Controls.TabButtonYourReforms,
		Panel = Controls.YourReformsPanel,
		SelectHighlight = Controls.TabButtonYourReformsHL,
	},
	
	["WorldGovernments"] = {
		Button = Controls.TabButtonWorldGovernments,
		Panel = Controls.WorldGovernmentsPanel,
		SelectHighlight = Controls.TabButtonWorldGovernmentsHL,
	},
}

local g_PoliticalFactionManager 		= InstanceManager:new("FactionInstance", 		  "FactionBase",  Controls.FactionStack)
local g_PoliticalFactionPopupManager 	= InstanceManager:new("FactionPopupInstance", 	  "FactionBase",  Controls.FactionPopupStack)
local g_PoliticalReformsLeftManager 	= InstanceManager:new("ReformInstance", 		  "ReformButton", Controls.PoliticalReformsLeftStack)
local g_PoliticalReformsCentreManager 	= InstanceManager:new("ReformInstance", 		  "ReformButton", Controls.PoliticalReformsCentreStack)
local g_PoliticalReformsRightManager 	= InstanceManager:new("ReformInstance", 		  "ReformButton", Controls.PoliticalReformsRightStack)
local g_YourReformsManager 				= InstanceManager:new("YourReformsInstance", 	  "Base", 		  Controls.YourReformsStack);
local g_WorldGovernmentsManager 		= InstanceManager:new("WorldGovernmentInstance",  "Base", 		  Controls.WorldGovernmentsStack);
--=======================================================================================================================
-- Pedia Callback: Adapted from EUI
--=======================================================================================================================

CivilopediaControl = "/FrontEnd/MainMenu/Other/Civilopedia"

local getPedia

local function getPediaB(...)
	Events.SearchForPediaEntry(...)
end

local function getPediaA(...)
	UIManager:QueuePopup(LookUpControl(CivilopediaControl), PopupPriority.eUtmost)
	getPedia = getPediaB
	getPedia(...)
end

getPedia = CivilopediaControl and getPediaA

-------------------------------------------------------------------------------
-- Sorting Support
-------------------------------------------------------------------------------
g_YourReformsSortOptions = {
	{
		Button = Controls.WGSortByReform,
		ImageControl = Controls.WGSortByReformImage,
		Column = "ReformDesc",
		DefaultDirection = "asc",
		CurrentDirection = nil,
	},
	{
		Button = Controls.WGSortByReformSubBranch,
		ImageControl = Controls.WGSortByReformSubBranchImage,
		Column = "ReformSubBranchDesc",
		DefaultDirection = "desc",
		CurrentDirection = nil,
	},
	{
		Button = Controls.WGSortByReformBranch,
		ImageControl = Controls.WGSortByReformBranchImage,
		Column = "ReformBranchDesc",
		DefaultDirection = "asc",
		CurrentDirection = "asc",
	},
	{
		Button = Controls.WGSortByReformEffect,
		ImageControl = Controls.WGSortByReformEffectImage,
		Column = "ReformEffect",
		DefaultDirection = "desc",
		CurrentDirection = nil,
	},
};
g_YourReformsSortFunction = nil;

g_WorldGovernmentsSortOptions = {
	{
		Button = Controls.WGSortByCivilizationName,
		ImageControl = Controls.WGSortByCivilizationNameImage,
		Column = "CivilizationDesc",
		DefaultDirection = "desc",
		CurrentDirection = "desc",
	},
	{
		Button = Controls.WGSortByLeaderName,
		ImageControl = Controls.WGSortByLeaderNameImage,
		Column = "LeaderDesc",
		DefaultDirection = "desc",
		CurrentDirection = nil,
	},
	{
		Button = Controls.WGSortByFactionType,
		ImageControl = Controls.WGSortByFactionTypeImage,
		Column = "FactionType",
		DefaultDirection = "desc",
		CurrentDirection = nil,
	},
	{
		Button = Controls.WGSortByGovernmentType,
		ImageControl = Controls.WGSortByGovernmentTypeImage,
		Column = "GovernmentType",
		DefaultDirection = "asc",
		CurrentDirection = nil,
	},
	{
		Button = Controls.WGSortByCyclePowerType,
		ImageControl = Controls.WGSortByCyclePowerTypeImage,
		Column = "CyclePowerType",
		DefaultDirection = "desc",
		CurrentDirection = nil,
	},
};

g_WorldGovernmentsSortFunction = nil;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local governmentKingdomID = GameInfoTypes["GOVERNMENT_JFD_MONARCHY"]
local governmentRepublicID = GameInfoTypes["GOVERNMENT_JFD_REPUBLIC"]
local reformBranchGovernmentID = GameInfoTypes["REFORM_BRANCH_JFD_GOVERNMENT"]
local reformAdministrationCommonwealthID = GameInfoTypes["REFORM_JFD_ADMINISTRATION_COMMONWEALTH"]
local reformAdministrationPoliceStateID = GameInfoTypes["REFORM_JFD_ADMINISTRATION_POLICE_STATE"]
local reformFactionsInterestsID = GameInfoTypes["REFORM_JFD_FACTIONS_INTERESTS"]
local reformFactionsMultiPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_MULTI_PARTY"]
local reformFactionsTwoPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_TWO_PARTY"]

local g_CurrentReformBranchID = reformBranchGovernmentID
-------------------------------------------------
-------------------------------------------------
function OnViewGovernmentsButton()
	LuaEvents.UI_ShowChooseGovernmentPopup()
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function RefreshYourGovernment()
	local player = Players[Game.GetActivePlayer()]
	if (not player:IsHasGovernment()) then
		Controls.YourGovernmentStack:SetHide(true)
		Controls.GovtTitleBox:SetHide(true)
		Controls.GovtOverviewTrim:SetHide(true)
		Controls.GovtOverviewDisabledBG:SetHide(false)
		Controls.GovtOverviewDisabledBG:SetTexture("GovtOverview_Background.dds")
		Controls.GovtDisabledText:SetHide(false)
		Controls.DisabledGovtTextLabel:LocalizeAndSetText("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORMS_DISABLED")
	-- elseif player:IsAnarchy() then
		-- Controls.YourGovernmentStack:SetHide(true)
		-- Controls.GovtTitleBox:SetHide(true)
		-- Controls.GovtOverviewTrim:SetHide(true)
		-- Controls.GovtOverviewDisabledBG:SetHide(false)
		-- Controls.GovtOverviewDisabledBG:SetTexture("GovtOverview_BackgroundAnarchy.dds")
		-- Controls.GovtDisabledText:SetHide(false)
		-- Controls.DisabledGovtTextLabel:LocalizeAndSetText("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORMS_DISABLED_ANARCHY", player:GetAnarchyNumTurns())
	else
		Controls.GovtDisabledText:SetHide(true)
		Controls.GovtOverviewDisabledBG:SetHide(true)
		Controls.YourGovernmentStack:SetHide(false)
		Controls.GovtTitleBox:SetHide(false)
		Controls.GovtOverviewTrim:SetHide(false)
		
		--GOVERNMENT INFO
		local governmentID = player:GetCurrentGovernment()
		local government = GameInfo.JFD_Governments[governmentID]
		Controls.GovernmentLabel:SetText("[ICON_JFD_GOVERNMENT] " .. Locale.ConvertTextKey(government.Description))
		Controls.GovernmentLabel:SetToolTipString(Locale.ConvertTextKey(government.Description) .. "[NEWLINE]" .. Locale.ConvertTextKey(government.Help))
		
		--VIEW GOVERNMENTS
		Controls.ViewGovernmentsButton:SetHide(false)
		Controls.ViewGovernmentsButton:RegisterCallback(Mouse.eLClick, OnViewGovernmentsButton)
		
		--CAPITAL
		local playerCapital = player:GetCapitalCity()
		if playerCapital then
			Controls.CapitalLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CAPITAL_STAT", playerCapital:GetName())
		end

		--CYCLE OF POWER
		if Player.GetCyclePower then
			local cyclePowerID = player:GetCyclePower()
			if cyclePowerID > -1 then
				local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
				local strCyclePower = player:GetCyclePowerToolTip(cyclePowerID)
				Controls.CyclePowerLabel:SetText("[ICON_JFD_CYCLE_POWER]")
				Controls.CyclePowerLabel:LocalizeAndSetToolTip(strCyclePower)
			end
		end
		

		--CULTURE
		if Player.GetCultureType then
			local cultureID = player:GetCultureType()
			local culture = GameInfo.JFD_CultureTypes[cultureID]
			Controls.CultureLabel:SetText(culture.FontIcon)
			Controls.CultureLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CULTURE_STAT", culture.ShortDescription)
		end
		
		--IDEOLOGY
		local ideologyID = player:GetLateGamePolicyTree()
		if ideologyID > -1 then
			local ideology = GameInfo.PolicyBranchTypes[ideologyID]
			Controls.IdeologyLabel:SetText(ideology.IconString)
			Controls.IdeologyLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_IDEOLOGY_STAT", ideology.Description)
		end
		
		--RELIGION
		local religionID = player:GetMainReligion()
		if religionID ~= -1 then
			local religion = GameInfo.Religions[religionID]
			Controls.ReligionLabel:SetText(religion.IconString)
			Controls.ReligionLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_RELIGION_STAT", Game.GetReligionName(religionID))
		end
	
		--STATE
		local civDesc = player:GetCivilizationDescription()
		Controls.StateHeaderLabel:SetText(civDesc)
		Controls.StateHeaderLabel:LocalizeAndSetToolTip(civDesc)
		if Locale.Length(civDesc) > 31 then
			Controls.StateHeaderLabel:SetFontByName("TwCenMT14")
		else
			Controls.StateHeaderLabel:SetFontByName("TwCenMT24")
		end
		
		--LEADER
		local strLeader = player:GetName()
		local leaderDesc = player:GetName()
		local _, _, strLeaderTitleStyleText = player:GetLeaderTitle(governmentID, true, true, true, nil, true)
		Controls.LeaderHeaderLabel:LocalizeAndSetText(leaderDesc)
		Controls.LeaderHeaderLabel:LocalizeAndSetToolTip(strLeaderTitleStyleText)
	
		--TITLE
		Controls.FullTitleLabel:SetText(Locale.ConvertTextKey(strLeader) .. " " .. Locale.ConvertTextKey("TXT_KEY_JFD_TITLE_OF") .. " " .. player:GetCivilizationShortDescription())
		
		--COUNCILLORS
		RefreshCouncillors()
		
		--LEGISLATURE
		RefreshLegislature()
		Controls.LegislatureHeaderLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_REFORM_LEGISLATURE_GENERAL_LEGISLATURE_HELP")		
		
		local dominantFactionID, dominantFactionPower, strDominantFactionTT = player:GetDominantFaction(true)
		if player:IsInRevolution() then
			Controls.RevolutionLabel:SetHide(false)
			Controls.HeadOfGovernmentHeader:SetHide(true)
			Controls.GovernmentCooldownImage:SetHide(true)
		elseif dominantFactionID > -1 then
			local dominantFaction = GameInfo.JFD_Factions[dominantFactionID]
			local dominantFactionName = player:GetFactionName(dominantFactionID)
			Controls.HeadOfGovernment:LocalizeAndSetText(dominantFaction.ShortDescription)
			Controls.HeadOfGovernmentHeader:LocalizeAndSetToolTip(strDominantFactionTT)
			Controls.RevolutionLabel:SetHide(true)
			Controls.HeadOfGovernmentHeader:SetHide(false)
			Controls.GovernmentCooldownImage:SetHide(false)
		else
			Controls.HeadOfGovernment:LocalizeAndSetText("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_DOMINANT_FACTION_NONE")
			Controls.HeadOfGovernmentHeader:LocalizeAndSetToolTip(strDominantFactionTT)
			Controls.RevolutionLabel:SetHide(true)
			Controls.HeadOfGovernmentHeader:SetHide(false)
			Controls.GovernmentCooldownImage:SetHide(false)
		end
		
		--ICONS
		local civ = GameInfo.Civilizations[player:GetCivilizationType()]
		local leader = GameInfo.Leaders[player:GetLeaderType()]
		if government.IsGovtOverviewShowsCivIconFirst then
			IconHookup(civ.PortraitIndex, 128, civ.IconAtlas, Controls.LeaderIcon)
			IconHookup(leader.PortraitIndex, 64, leader.IconAtlas, Controls.CivIconImg)
		elseif government.IsGovtOverviewShowsReligiousIconFirst then
			if religionID == -1 then religionID = 0 end
			local religion = GameInfo.Religions[religionID]
			if government.IsGovtOverviewShowsCivIconFirst then 
				IconHookup(religion.PortraitIndex, 128, religion.IconAtlas, Controls.LeaderIcon)
				IconHookup(civ.PortraitIndex, 64, civ.IconAtlas, Controls.CivIconImg)
			else
				IconHookup(leader.PortraitIndex, 128, leader.IconAtlas, Controls.LeaderIcon)
				IconHookup(religion.PortraitIndex, 64, religion.IconAtlas, Controls.CivIconImg)
			end
		else
			IconHookup(leader.PortraitIndex, 128, leader.IconAtlas, Controls.LeaderIcon)
			IconHookup(civ.PortraitIndex, 64, civ.IconAtlas, Controls.CivIconImg)
		end
		
		--REFORMS
		RefreshAvailableReforms(government)
	
		--GOVERNMENT COOLDOWN
		local numGovernmentCooldown, numCurrentGovernmentCooldown, strGovernmentCooldownTT = player:CalculateGovernmentCooldown(true)
		if numGovernmentCooldown < 0 then
			Controls.GovernmentCooldown:SetText(-1)
			Controls.GovernmentCooldownImage:LocalizeAndSetToolTip(strGovernmentCooldownTT)
		else
			Controls.GovernmentCooldown:SetText(numCurrentGovernmentCooldown)
			Controls.GovernmentCooldownImage:LocalizeAndSetToolTip(strGovernmentCooldownTT)
		end
		
		--REFORM CAPACITY
		local numReforms = player:GetNumReforms(true, true)
		local numReformCapacity = player:CalculateReformCapacity()
		local numTotalSovMod = player:GetReformCapacitySovModifier(numReforms, numReformCapacity)
		if numReforms > numReformCapacity then
			Controls.ReformCapacityLabel:LocalizeAndSetText("{3_HL}{1_Num}[ENDCOLOR]/{2_Num} [ICON_JFD_REFORM]", numReforms, numReformCapacity, "[COLOR_WARNING_TEXT]")
			Controls.ReformCapacityLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_NEXT_REFORM_CAPACITY_LABEL_EXCEEDED_TT")
		elseif numReforms == numReformCapacity then
			Controls.ReformCapacityLabel:LocalizeAndSetText("{3_HL}{1_Num}[ENDCOLOR]/{2_Num} [ICON_JFD_REFORM]", numReforms, numReformCapacity, "")
			Controls.ReformCapacityLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_NEXT_REFORM_CAPACITY_LABEL_CAPPED_TT")
		else
			Controls.ReformCapacityLabel:LocalizeAndSetText("{3_HL}{1_Num}[ENDCOLOR]/{2_Num} [ICON_JFD_REFORM]", numReforms, numReformCapacity, "[COLOR_POSITIVE_TEXT]")
			Controls.ReformCapacityLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_NEXT_REFORM_CAPACITY_LABEL_TT")
		end
		
		--REVOLUTIONARY SENTIMENT
		local numRevolutionarySentiment, strRevolutionarySentimentModTT = player:GetTotalRevolutionarySentiment(governmentID, true)
		if numRevolutionarySentiment > 0 then
			Controls.RevSentLabelAni:SetHide(false)
			Controls.RevSentLabel:LocalizeAndSetText("[COLOR_WARNING_TEXT]{1_Num}%[ENDCOLOR] [ICON_JFD_REVOLUTIONARY_SENTIMENT]", numRevolutionarySentiment) 
			Controls.RevSentLabel:LocalizeAndSetToolTip(strRevolutionarySentimentModTT) 
		else
			Controls.RevSentLabelAni:SetHide(true)
			Controls.RevSentLabel:LocalizeAndSetText("{1_Num}% [ICON_JFD_REVOLUTIONARY_SENTIMENT]", numRevolutionarySentiment) 
			Controls.RevSentLabel:LocalizeAndSetToolTip(strRevolutionarySentimentModTT) 
		end
		
		--SOVEREIGNTY
		local numCurrentSov = player:GetCurrentSovereignty()
		local strSovTT = player:GetSovereigntyToolTip()
		Controls.SovLabel:LocalizeAndSetText("{1_Num}%[ICON_JFD_SOVEREIGNTY]", numCurrentSov)
		Controls.SovLabel:LocalizeAndSetToolTip(strSovTT) 
	end
end
g_Tabs["YourGovernment"].RefreshContent = RefreshYourGovernment;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--g_JFD_Councillors_Table
local g_JFD_Councillors_Table = {}
local g_JFD_Councillors_Count = 1
for row in DB.Query("SELECT * FROM JFD_Councillors;") do 	
	g_JFD_Councillors_Table[g_JFD_Councillors_Count] = row
	g_JFD_Councillors_Count = g_JFD_Councillors_Count + 1
end

--g_JFD_Councillors_GreatPeople_Table
local g_JFD_Councillors_GreatPeople_Table = {}
local g_JFD_Councillors_GreatPeople_Count = 1
for row in DB.Query("SELECT * FROM JFD_Councillor_GreatPeople;") do 	
	g_JFD_Councillors_GreatPeople_Table[g_JFD_Councillors_GreatPeople_Count] = row
	g_JFD_Councillors_GreatPeople_Count = g_JFD_Councillors_GreatPeople_Count + 1
end

function RefreshCouncillors()
	local player = Players[Game.GetActivePlayer()]
	
	--g_JFD_Councillors_Table
	local councillorsTable = g_JFD_Councillors_Table
	local numCouncillors = #councillorsTable
	for index = 1, numCouncillors do
		local numString = tostring(index)
		local buttonName = "Councillor"..numString .."Icon"
		local thisButton = Controls[buttonName]
		
		local row = councillorsTable[index]
		local councillorID = row.ID
		local councillorDesc = row.Description
		local strCouncillorTT
		if councillorID and player:IsHasCouncillor(councillorID) then
			local councillorName = player:GetCouncillorName(councillorID) or ""
			strCouncillorTT = "[COLOR_JFD_SOVEREIGNTY]" .. Locale.ConvertTextKey(councillorDesc) .. Locale.ConvertTextKey(" - [COLOR_JFD_SOVEREIGNTY]{1_Desc}[ENDCOLOR][NEWLINE]", councillorName)
			strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey("TXT_KEY_COUNCILLOR_JFD_HELP_FILLED")
			local councillorUnitClass = player:GetCouncillorUnitClassType(councillorID)
			local councillorUnitID = player:GetUniqueUnit(councillorUnitClass)
			local councillorUnit = GameInfo.Units[councillorUnitID]
			local councillorGreatPeopleTable = g_JFD_Councillors_GreatPeople_Table
			local numCouncillorGreatPeople = #councillorGreatPeopleTable
			for index = 1, numCouncillorGreatPeople do
				local row2 = councillorGreatPeopleTable[index]
				if row2.CouncillorType == row.Type then
					local councillorHelp = row2.Help
					if row2.UnitClassType == councillorUnitClass then
						strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey(councillorHelp, "[COLOR_POSITIVE_TEXT]", "")
					else
						strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey(councillorHelp, "[COLOR_FADING_POSITIVE_TEXT]", "[COLOR_JFD_ALPHA]")
					end
				end
			end
			IconHookup(councillorUnit.PortraitIndex, 64, councillorUnit.IconAtlas, thisButton)
		else	
			local councillorGreatPeopleTable = g_JFD_Councillors_GreatPeople_Table
			local numCouncillorGreatPeople = #councillorGreatPeopleTable
			for index = 1, numCouncillorGreatPeople do
				local row2 = councillorGreatPeopleTable[index]
				if row2.CouncillorType == row.Type then
					local councillorHelp = row2.Help
					strCouncillorTT = "[COLOR_JFD_SOVEREIGNTY]" .. Locale.ConvertTextKey(councillorDesc) .. " " .. Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_COUNCILLORS_VACANT")
					strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey("TXT_KEY_COUNCILLOR_JFD_HELP_VACANT") .. Locale.ConvertTextKey(councillorHelp, "[COLOR_FADING_POSITIVE_TEXT]", "[COLOR_JFD_ALPHA]")
					strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey("TXT_KEY_COUNCILLOR_JFD_HELP_VACANT_NOTE")
				end
			end
			IconHookup(22, 64, "LEADER_ATLAS", thisButton)
		end		
		thisButton:LocalizeAndSetToolTip(strCouncillorTT)
	end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--g_JFD_Factions_Table
local g_JFD_Factions_Table = {}
local g_JFD_Factions_Count = 1
for row in DB.Query("SELECT * FROM JFD_Factions WHERE Type != 'FACTION_JFD_REVOLUTIONARIES';") do 	
	g_JFD_Factions_Table[g_JFD_Factions_Count] = row
	g_JFD_Factions_Count = g_JFD_Factions_Count + 1
end

local g_ShowAbsentFactions = false

local governmentDictatorshipID = GameInfoTypes["GOVERNMENT_JFD_DICTATORSHIP"]
local governmentHREID = GameInfoTypes["GOVERNMENT_JFD_HOLY_ROMAN_EMPIRE"]
function RefreshLegislature()
	g_PoliticalFactionManager:ResetInstances()
	
	local player = Players[Game.GetActivePlayer()]
	
	if player:IsInRevolution() then
		Controls.FactionScrollPanel:SetHide(true)
	else
		Controls.FactionScrollPanel:SetHide(false)
		
		local theseFactionsTable = {}
		
		--g_JFD_Factions_Table
		local factionsTable = g_JFD_Factions_Table
		local numFactions = #factionsTable
		for index = 1, numFactions do
			local row = factionsTable[index]
			local thisFactionID = row.ID
			if player:IsFactionValid(thisFactionID) then	
				local thisFactionPower = player:GetFactionPower(thisFactionID)
				if g_ShowAbsentFactions then
					table.insert(theseFactionsTable, {FactionID = thisFactionID, Percent = thisFactionPower});
				elseif thisFactionPower > 0 then
					table.insert(theseFactionsTable, {FactionID = thisFactionID, Percent = thisFactionPower});
				end
			end
		end
		
		table.sort(theseFactionsTable, function(a,b) return a.Percent > b.Percent end)
		
		for _, faction in ipairs(theseFactionsTable) do
			local instance = g_PoliticalFactionManager:GetInstance()
			local factionID = faction.FactionID
			local factionInfo = GameInfo.JFD_Factions[factionID]
			local factionName = player:GetFactionName(factionID)
			local factionPower = faction.Percent
			local factionHelp = player:GetFactionHelp(factionID, factionName, factionPower)
			
			if factionPower <= 0 then
				instance.FactionBase:SetAlpha(0.4)
			else
				instance.FactionBase:SetAlpha(1)
			end
			
			instance.FactionName:LocalizeAndSetToolTip(factionHelp)
			instance.Sovereignty:LocalizeAndSetText("[COLOR_JFD_FACTION_POWER]{1_num}%[ICON_JFD_FACTION_POWER][ENDCOLOR]", factionPower)
			instance.Sovereignty:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_FACTION_POWER_TT")) 	
			
			local factionPlayerID = player:GetFactionCivType(factionID)
			if factionPlayerID > -1 then
				local factionPlayer = Players[factionPlayerID]
				if (not factionPlayer:IsMinorCiv()) then
					local civType = GameInfo.Civilizations[factionPlayer:GetCivilizationType()]
					instance.CivIconBox:SetHide(false)
					instance.CivIconFont:SetText(factionInfo.IconString)
					CivIconHookup(factionPlayerID, 32, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true, instance.CivIconHighlight)
					instance.FactionName:SetOffsetVal(34,0)
					instance.FactionName:SetText(" " .. factionName)
				else
					instance.CivIconBox:SetHide(false)
					instance.FactionName:SetText(factionInfo.IconString .. " " .. factionName)
				end
			else
				instance.CivIconBox:SetHide(true)
				instance.FactionName:SetOffsetVal(12,0)
				instance.FactionName:SetText(factionInfo.IconString .. " " .. factionName)
			end	
			
			instance.FactionBox:SetSizeY(instance.FactionName:GetSizeY()+15)
			instance.FactionBase:SetSizeY(instance.FactionName:GetSizeY()+18)
			instance.FactionName:ReprocessAnchoring()
			instance.FactionStack:ReprocessAnchoring()
		end
	
		Controls.FactionStack:CalculateSize()
		Controls.FactionStack:ReprocessAnchoring()
		Controls.FactionScrollPanel:CalculateInternalSize()
		Controls.FactionScrollPanel:SetHide(false)
	end
end
-------------------------------------------------
-------------------------------------------------
function OnShowDetailCheckFaction(isChecked)
	g_ShowAbsentFactions = isChecked
	RefreshLegislature()
end
Controls.ShowDetailCheckFaction:RegisterCheckHandler(OnShowDetailCheckFaction)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local g_Reform_TipControls = {}
TTManager:GetTypeControlTable("ReformHelpToolTip", g_Reform_TipControls)

function GetReformHelpToolTip(control)
	local player = Players[Game.GetActivePlayer()]
	local reformID = control:GetVoid1()
	local reformCost = control:GetVoid2()
	local strReformHelp = player:GetReformInfoTT(reformID, reformCost)
	
	local tipControls = g_Reform_TipControls
	tipControls.Body:SetText(strReformHelp)
	tipControls.Box:DoAutoSize()
end
-------------------------------------------------------------------------------
--g_JFD_Reforms_Table
local g_JFD_Reforms_Table = {}
local g_JFD_Reforms_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ShowInGovernment = 1") do 	
	g_JFD_Reforms_Table[g_JFD_Reforms_Count] = row
	g_JFD_Reforms_Count = g_JFD_Reforms_Count + 1
end

local g_ShowDetailedReforms = false
local g_ShowReformIcons 	= false
local g_ShowNewReform 		= false

function RefreshAvailableReforms(government)
	local player = Players[Game.GetActivePlayer()]
	local currentEraID = player:GetCurrentEra()
	if (not government) then
		government = GameInfo.JFD_Governments[player:GetCurrentGovernment()]
	end
	
	g_PoliticalReformsLeftManager:ResetInstances()
	g_PoliticalReformsCentreManager:ResetInstances()
	g_PoliticalReformsRightManager:ResetInstances()
	
	if player:IsHasGovernment() then
		local currentReformBranch = GameInfo.JFD_ReformBranches[g_CurrentReformBranchID]
		local currentReformBranchType = currentReformBranch.Type
		local numCurrentSov = player:GetCurrentSovereignty()
						
		--g_JFD_Reforms_Table
		local reformsTable = g_JFD_Reforms_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row = reformsTable[index]
			if row.ReformBranchType == currentReformBranchType then
				local reformID = row.ID
				local reformAlignment = row.Alignment
				local reformSubBranchDesc = row.ReformSubBranchDescription
				local reformDesc = Locale.ConvertTextKey(row.ShortDescription)
				local reformFocusIcons = row.FocusIconBonus
				
				local instance
				if reformAlignment == "REFORM_LEFT" then
					instance = g_PoliticalReformsLeftManager:GetInstance()
				elseif reformAlignment == "REFORM_RIGHT" then 
					instance = g_PoliticalReformsRightManager:GetInstance()
				else
					instance = g_PoliticalReformsCentreManager:GetInstance()
				end		
				
				local reformAlpha = 1
				local reformCost = player:GetReformCost(reformID)
				local reformHelp = player:GetReformInfoTT(reformID, reformCost)
				instance.ReformTitle:SetTruncateWidth(130)
				instance.ReformTitleDetailed:SetTruncateWidth(100)
				instance.ReformBranch:SetTruncateWidth(120)
				instance.ReformOpinion:SetHide(true)
				instance.ReformHL:SetHide(true)
				instance.ReformCost:SetHide(true)
				instance.VerticalTrim1:SetHide(false)
				instance.VerticalTrim2:SetHide(false)
				
				local playerHasReform = player:HasReform(reformID)
				if playerHasReform then
					instance.ReformButton:SetAlpha(1)
					instance.CenterLine:SetAlpha(0.5)
					instance.ReformButton:SetDisabled(true)
					instance.ReformHL:SetHide(false)
					instance.ReformTitle:SetTruncateWidth(200)
					instance.ReformTitleDetailed:SetTruncateWidth(200)
					local strReformDesc = "[COLOR_POSITIVE_TEXT]" .. reformDesc .. "[ENDCOLOR]"
					instance.ReformTitle:LocalizeAndSetText(strReformDesc)
					instance.ReformTitleDetailed:LocalizeAndSetText(strReformDesc)
					instance.VerticalTrim1:SetHide(true)
					instance.VerticalTrim2:SetHide(true)
				else
					local canHaveReform, isCooldownDisable, strDisabledIcon = player:CanHaveReform(reformID, true, reformCost)
					if (not canHaveReform) then
						instance.ReformButton:SetAlpha(0.5)
						instance.ReformButton:SetDisabled(true)
						instance.ReformCost:LocalizeAndSetText(strDisabledIcon)
						instance.ReformCost:SetHide(false)
						local strReformDesc = "[COLOR_WARNING_TEXT]" .. reformDesc .. "[ENDCOLOR]"
						instance.ReformTitle:LocalizeAndSetText(strReformDesc)
						instance.ReformTitleDetailed:LocalizeAndSetText(strReformDesc)
						instance.ReformBranchDetailed:SetTruncateWidth(150)
						if (g_ShowDetailedReforms and isCooldownDisable) then
							instance.ReformCost:SetHide(false)
							local strReformCost = Locale.ConvertTextKey("[COLOR_JFD_SOVEREIGNTY_FADING]{1_Num}%[ICON_JFD_SOVEREIGNTY][ENDCOLOR]", reformCost)
							instance.ReformCost:LocalizeAndSetText(strReformCost)
						end
					else
						if numCurrentSov < reformCost then
							instance.ReformButton:SetAlpha(0.5)
							instance.CenterLine:SetAlpha(1)
							instance.ReformButton:SetDisabled(true)
							local strReformDesc = "[COLOR_WARNING_TEXT]" .. reformDesc .. "[ENDCOLOR]"
							instance.ReformTitle:LocalizeAndSetText(strReformDesc)
							instance.ReformTitleDetailed:LocalizeAndSetText(strReformDesc)
							if g_ShowDetailedReforms then
								local strReformCost = Locale.ConvertTextKey("[COLOR_JFD_SOVEREIGNTY_FADING]{1_Num}%[ICON_JFD_SOVEREIGNTY][ENDCOLOR]", reformCost)
								instance.ReformCost:SetHide(false)
								instance.ReformCost:LocalizeAndSetText(strReformCost)
							end
						else
							instance.ReformButton:SetAlpha(1)
							instance.CenterLine:SetAlpha(0.5)
							instance.ReformButton:SetDisabled(false)
							instance.ReformTitle:SetText(reformDesc)
							instance.ReformTitleDetailed:SetText(reformDesc)
							if g_ShowDetailedReforms then
								local strReformCost = Locale.ConvertTextKey("[COLOR_JFD_SOVEREIGNTY_FADING]{1_Num}%[ICON_JFD_SOVEREIGNTY][ENDCOLOR]", reformCost)
								instance.ReformCost:SetHide(false)
								instance.ReformCost:LocalizeAndSetText(strReformCost)
							end
						end
					end
					
					if g_ShowDetailedReforms then
						local reformFavoured = player:GetReformOpinionFavoured(reformID)
						local reformOpposed  = player:GetReformOpinionOpposed(reformID)
						if (reformFavoured > 0 or reformOpposed > 0) then
							instance.ReformOpinion:LocalizeAndSetText("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORM_OPINION", reformFavoured, reformOpposed) 
							instance.ReformOpinion:SetHide(false)
							instance.ReformOpinion:SetAlpha(reformAlpha)
							instance.ReformBranchDetailed:SetTruncateWidth(80)
						end
					end
				end	
					
				instance.ReformTitle:SetHide(false)
				instance.ReformTitleDetailed:SetHide(true)
				instance.ReformBranch:SetHide(false)
				instance.ReformBranch:SetText(Locale.ToUpper(reformSubBranchDesc))
				instance.ReformBranchDetailed:SetHide(true)
				instance.ReformBranchDetailed:SetText(Locale.ToUpper(reformSubBranchDesc))			
	
				if g_ShowDetailedReforms then
					instance.ReformTitle:SetHide(true)
					instance.ReformTitleDetailed:SetHide(false)
					instance.ReformBranch:SetHide(true)
					instance.ReformBranchDetailed:SetHide(false)
					instance.ReformBranchDetailed:SetOffsetX(5)
				end
				
				if g_ShowReformIcons then
					instance.ReformTitle:SetHide(true)
					instance.ReformTitleDetailed:SetHide(false)
					instance.ReformBranch:SetHide(true)
					instance.ReformBranchDetailed:SetHide(false)
					if reformFocusIcons then
						instance.ReformBranchDetailed:SetText(Locale.ConvertTextKey(reformFocusIcons) .. "" .. Locale.ToUpper(reformSubBranchDesc))
						instance.ReformBranchDetailed:SetOffsetX(0)
					end
				end		
	
				if g_ShowNewReforms and (not g_ShowDetailedReforms) and (not g_ShowReformIcons) then
					local prereqEraID = GameInfoTypes[row.PrereqEra]					
					if currentEraID == prereqEraID then
						instance.ReformNew:SetHide(false)
					end
				else
					instance.ReformNew:SetHide(true)
				end
				
				if reformAlignment == "REFORM_RIGHT" then
					instance.CenterLine:SetHide(true)
				end
	
				instance.ReformBranch:ReprocessAnchoring()
				-- instance.ReformButton:SetVoids(reformID, reformCost)
				-- instance.ReformButton:SetToolTipCallback(GetReformHelpToolTip)
				instance.ReformButton:LocalizeAndSetToolTip(reformHelp)
				instance.ReformButton:RegisterCallback(Mouse.eLClick, OnReformClicked)
				instance.ReformButton:SetVoid1(reformID)
				local pediaEntry = CivilopediaControl and (row.Pedia)
				if (pediaEntry and (not instance.ReformButton:IsDisabled())) then
					instance.ReformButton:RegisterCallback(Mouse.eRClick, function() getPedia(pediaEntry) end)
				end		
			end
			
		end
	end
	Controls.PoliticalReformsLeftStack:CalculateSize()
	Controls.PoliticalReformsCentreStack:CalculateSize()
	Controls.PoliticalReformsRightStack:CalculateSize()
	Controls.PoliticalReformsScrollPanel:CalculateInternalSize()
	Controls.PoliticalReformsLeftStack:ReprocessAnchoring()
	Controls.PoliticalReformsCentreStack:ReprocessAnchoring()
	Controls.PoliticalReformsRightStack:ReprocessAnchoring()
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ReformBranchButtonSelected(numBranchSelected)
	
	g_CurrentReformBranchID = numBranchSelected
	local currentReformBranch = GameInfo.JFD_ReformBranches[g_CurrentReformBranchID]
	local currentreformSubBranchDesc = string.upper(Locale.ConvertTextKey(currentReformBranch.ShortDescription))
	Controls.ReformBranchHeaderLabel:SetText(currentreformSubBranchDesc)
	Controls.ReformBranchHeaderLabel:LocalizeAndSetToolTip(currentReformBranch.Help)
			
	for i = 1, 10 do
		local numString = tostring(i)
		local buttonReformBranch = "ReformBranchButton" ..numString;
		local controlReformBranch = Controls[buttonReformBranch];
		if i == numBranchSelected then
			controlReformBranch:SetDisabled(true)
		else	
			controlReformBranch:SetDisabled(false)
		end
		local thisReformBranch = GameInfo.JFD_ReformBranches[i]
		controlReformBranch:SetTexture(thisReformBranch.ButtonTexture)
	end
	
	RefreshAvailableReforms()	
end
Controls.ReformBranchButton1:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(1); end);
Controls.ReformBranchButton2:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(2); end);
Controls.ReformBranchButton3:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(3); end);
Controls.ReformBranchButton4:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(4); end);
Controls.ReformBranchButton5:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(5); end);
Controls.ReformBranchButton6:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(6); end);
Controls.ReformBranchButton7:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(7); end);
Controls.ReformBranchButton8:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(8); end);
Controls.ReformBranchButton9:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(9); end);
Controls.ReformBranchButton10:RegisterCallback(Mouse.eLClick, function() ReformBranchButtonSelected(10); end);
-------------------------------------------------
-------------------------------------------------
function OnShowDetailCheckReform(isChecked)
	g_ShowDetailedReforms = isChecked
	RefreshAvailableReforms()
end
Controls.ShowDetailCheckReform:RegisterCheckHandler(OnShowDetailCheckReform)
-------------------------------------------------
-------------------------------------------------
function OnShowIconsCheckReform(isChecked)
	g_ShowReformIcons = isChecked
	RefreshAvailableReforms()
end
Controls.ShowIconsCheckReform:RegisterCheckHandler(OnShowIconsCheckReform)
-------------------------------------------------
-------------------------------------------------
function OnShowNewCheckReform(isChecked)
	g_ShowNewReforms = isChecked
	RefreshAvailableReforms()
end
Controls.ShowNewCheckReform:RegisterCheckHandler(OnShowNewCheckReform)
-------------------------------------------------
-------------------------------------------------
local g_ChosenReformID = nil

function OnReformClicked(reformID)
	g_ChosenReformID = reformID
	
	local player = Players[Game.GetActivePlayer()]
	local reform = GameInfo.JFD_Reforms[reformID]
	
	local numReforms = player:GetNumReforms(true, true)
	local numReformCapacity = player:CalculateReformCapacity()
	local numReformCooldown = player:CalculateReformCooldown(reform.ReformSubBranchType)
	local numTotalSovMod, numTotalSovModBeforeReforms = player:GetReformCapacitySovModifier(numReforms, numReformCapacity)
	
	local strReformPass 
	local controlSize = 340 
	if numReforms == numReformCapacity then
		strReformPass = Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CONFIRM_REFORM_AT_CAPACITY", reform.ShortDescription, reform.ReformSubBranchDescription, numReformCooldown, numTotalSovModBeforeReforms*-1)
		controlSize = 420
	elseif numReforms > numReformCapacity then
		strReformPass = Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CONFIRM_REFORM_OVER_CAPACITY", reform.ShortDescription, reform.ReformSubBranchDescription, numReformCooldown, numTotalSovModBeforeReforms*-1)
		controlSize = 420
	else
		strReformPass = Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CONFIRM_REFORM", reform.ShortDescription, reform.ReformSubBranchDescription, numReformCooldown)
	end
	
	if player:IsReformOpposed(reformID) then
		local numRevSentiment = player:GetTotalRevolutionarySentiment()
		if numRevSentiment > 0 then
			strReformPass = strReformPass .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CONFIRM_REFORM_REVOLUTIONARIES", numRevSentiment)
			controlSize = controlSize + 140
		else
			strReformPass = strReformPass .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_CONFIRM_REFORM_REVOLUTIONARIES_RISK", numRevSentiment)
			controlSize = controlSize + 140
		end
	end
	
	Controls.ReformConfirmLabel:SetText(strReformPass)
	Controls.ConfirmGrid:SetSizeVal(485,controlSize)
	
	Controls.ReformConfirm:SetHide(false)
	Controls.BGBlock:SetHide(true)
end
-------------------------------------------------
function ConfirmYes()
	Controls.ReformConfirm:SetHide(true)
	Controls.BGBlock:SetHide(false)
	
	Players[Game.GetActivePlayer()]:SetHasReform(g_ChosenReformID, nil, true)
	RefreshYourGovernment()
	RefreshYourReforms()
end
Controls.ConfirmYes:RegisterCallback(Mouse.eLClick, ConfirmYes)
-------------------------------------------------
function ConfirmNo()
	Controls.ReformConfirm:SetHide(true)
	Controls.BGBlock:SetHide(false)
end
Controls.ConfirmNo:RegisterCallback(Mouse.eLClick, ConfirmNo)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local g_ShowYourReformPenalties = false
local g_ShowYourReformsNotNone = true
function RefreshYourReforms() 
	g_YourReformsManager:ResetInstances()
	
	local player = Players[Game.GetActivePlayer()]
	local reformsListTable = {}
	local reformsListCount = 1
	
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		if row.HelpBonus and row.HelpPenalty then
			local reformID = row.ID
			if player:HasReform(reformID) then
				local reformBranch = GameInfo.JFD_ReformBranches[row.ReformBranchType]
				local reformBranchDesc = reformBranch.ShortDescription
				local reformBranchHelp = reformBranch.Help
				local reformDesc = row.ShortDescription
				local reformSubBranchDesc = row.ReformSubBranchDescription
				local reformSubBranchHelp = row.ReformSubBranchHelp
				local reformEffect = row.HelpBonus
				if g_ShowYourReformPenalties then 
					reformEffect = row.HelpPenalty 
				end
				
				if (g_ShowYourReformsNotNone and reformEffect ~= "TXT_KEY_JFD_REFORM_HELP_NONE") or (not g_ShowYourReformsNotNone) then 
					reformsListTable[reformsListCount] = {
					PlayerID = playerID,
					ReformID = row.ID,
					ReformDesc = Locale.Lookup(reformDesc),
					ReformBranchDesc = Locale.Lookup(reformBranchDesc),
					ReformBranchHelp = Locale.Lookup(reformBranchHelp),
					ReformSubBranchDesc = Locale.Lookup(reformSubBranchDesc),
					ReformSubBranchHelp = Locale.Lookup(reformSubBranchHelp),
					ReformEffect = Locale.Lookup(reformEffect),}
					reformsListCount = reformsListCount + 1
				end
			end
		end
	end

	if(#reformsListTable > 0) then
		Controls.YourReformsScrollPanel:SetHide(false);
		table.sort(reformsListTable, g_YourReformsSortFunction);
		
		for i,v in ipairs(reformsListTable) do
			local reform = GameInfo.JFD_Reforms[v.ReformID]
			local instance = g_YourReformsManager:GetInstance()
			instance.ReformDesc:SetText(v.ReformDesc)
			instance.ReformDesc:LocalizeAndSetToolTip(reform.Pedia)
			instance.ReformSubBranchDesc:SetText(v.ReformSubBranchDesc)
			instance.ReformSubBranchDesc:LocalizeAndSetToolTip(v.ReformSubBranchHelp)
			instance.ReformBranchDesc:SetText(v.ReformBranchDesc)
			instance.ReformBranchDesc:SetToolTipString(v.ReformBranchHelp)
			instance.ReformEffect:SetText(v.ReformEffect)
			instance.ReformEffect:SetToolTipString(v.ReformEffect)
		end
		
		Controls.YourReformsStack:CalculateSize();
		Controls.YourReformsStack:ReprocessAnchoring();
		Controls.YourReformsScrollPanel:CalculateInternalSize();
	end
	
end
g_Tabs["YourReforms"].RefreshContent = RefreshYourReforms;
-------------------------------------------------
-------------------------------------------------
function OnShowYourReformPenaltiesCheck(isChecked)
	g_ShowYourReformPenalties = isChecked
	RefreshYourReforms()
end
Controls.ShowYourReformPenaltiesCheck:RegisterCheckHandler(OnShowYourReformPenaltiesCheck)
-------------------------------------------------
-------------------------------------------------
function OnShowYourReformsNotNoneCheck(isChecked)
	g_ShowYourReformsNotNone = isChecked
	RefreshYourReforms()
end
Controls.ShowYourReformsNotNoneCheck:RegisterCheckHandler(OnShowYourReformsNotNoneCheck)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
function RefreshWorldGovernments()
	g_WorldGovernmentsManager:ResetInstances()
	
	local playerTeam = Teams[Game.GetActiveTeam()]
	
	local worldGovernmentsTable = {}
	local worldGovernmentsCount = 1
		
	for playerID = 0, defineMaxMajorCivs - 1 do	
		local player = Players[playerID];
		local teamID = player:GetTeam()
		if player:IsAlive() and ((playerTeam:IsHasMet(teamID) and (not g_IsCBRTestActive)) or g_IsCBRTestActive) and (not player:IsBarbarian()) then
			local civID = player:GetID()
			local civDesc = player:GetCivilizationDescription()
			local leaderDesc = player:GetName()
			local governmentID = player:GetCurrentGovernment()
			if governmentID ~= -1 then
				local government = GameInfo.JFD_Governments[governmentID] or GameInfo.JFD_Governments["GOVERNMENT_JFD_TRIBE"]
				local governmentType = government.Type
				
				local factionDesc
				local factionTT
				local factionDominantID, factionDominantPower = player:GetDominantFaction()
				if factionDominantID > -1 then	
					local faction = GameInfo.JFD_Factions[factionDominantID]
					local factionName = player:GetFactionName(factionDominantID)
					factionDesc = Locale.ConvertTextKey(factionName)
					factionTT = Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_FACTION_PANEL_TT", factionName, faction.Adjective, faction.IconString)
				else
					factionDesc = Locale.ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_FACTION_PANEL_NONE")
				end
				
				worldGovernmentsTable[worldGovernmentsCount] = {
				PlayerID = playerID,
				CivilizationDesc = Locale.Lookup(civDesc),
				LeaderDesc = Locale.Lookup(leaderDesc),
				GovernmentID = governmentID,
				GovernmentType = governmentType,
				FactionType = factionDominantID,
				FactionDesc = factionDesc,
				FactionTT = factionTT,}
				worldGovernmentsCount = worldGovernmentsCount + 1
			end
		end
	end
			
	if(#worldGovernmentsTable > 0) then
		Controls.WorldGovernmentsScrollPanel:SetHide(false);
		table.sort(worldGovernmentsTable, g_WorldGovernmentsSortFunction);
		
		for i,v in ipairs(worldGovernmentsTable) do
			local instance = g_WorldGovernmentsManager:GetInstance()
			local thisLargestSize = 32
			local playerID = v.PlayerID
			local player = Players[playerID]
			local strStateTitle, strStateTitleText = player:GetStateTitle(governmentID, true)
			local civShortDesc = v.CivilizationDesc
			local governmentID = v.GovernmentID
			local _, _, strLeaderTitleStyleText = player:GetLeaderTitle(governmentID, true, true, true, nil, true)
			local government = GameInfo.JFD_Governments[governmentID]
			local governmentDesc = player:GetGovernmentName(governmentID)
			local faction = GameInfo.JFD_Factions[v.FactionType]
			local strCivName = civShortDesc
			-- strCivName = Locale.ToUpper(player:GetCivilizationShortDescription()) .. "[NEWLINE][ICON_BULLET]" .. strCivName
			-- strCivName = strCivName .. "[NEWLINE][ICON_BULLET]" .. v.LeaderDesc
			instance.CivilizationName:SetText(strCivName)
			instance.CivilizationName:LocalizeAndSetToolTip(strStateTitleText)
			instance.CivilizationName:ReprocessAnchoring()
			instance.LeaderName:SetText(v.LeaderDesc)
			instance.LeaderName:LocalizeAndSetToolTip(strLeaderTitleStyleText)
			instance.LeaderName:ReprocessAnchoring()
			instance.GovernmentType:LocalizeAndSetText(governmentDesc)
			instance.GovernmentType:LocalizeAndSetToolTip(governmentDesc)
			instance.GovernmentType:ReprocessAnchoring()
			if faction then
				instance.FactionType:SetText(faction.IconString .. " " .. v.FactionDesc)
				instance.FactionType:LocalizeAndSetToolTip(v.FactionTT)
				instance.FactionType:ReprocessAnchoring()
			end
			
			local civTypeSize = instance.CivilizationName:GetSizeY()
			if civTypeSize > thisLargestSize then
				thisLargestSize = civTypeSize
				instance.CivilizationNameBox:SetSizeY(thisLargestSize);
			end
			local leaderTypeSize = instance.LeaderName:GetSizeY()
			if leaderTypeSize > thisLargestSize then
				thisLargestSize = leaderTypeSize
				instance.LeaderNameBox:SetSizeY(thisLargestSize);
			end
			local factionTypeSize = instance.FactionType:GetSizeY()
			if factionTypeSize > thisLargestSize then
				thisLargestSize = factionTypeSize
				instance.FactionTypeBox:SetSizeY(thisLargestSize);
			end
			local govtTypeSize = instance.GovernmentType:GetSizeY()
			if govtTypeSize > thisLargestSize then
				thisLargestSize = govtTypeSize
				instance.GovernmentTypeBox:SetSizeY(thisLargestSize+20);
			end
			-- instance.Base:SetSizeY(thisLargestSize+10);
			instance.Base:ReprocessAnchoring();
			instance.WorldGovtStack:CalculateSize();
			instance.WorldGovtStack:ReprocessAnchoring();
			
			CivIconHookup(playerID, 45, instance.CivilizationIcon, instance.CivilizationIconBG, instance.CivilizationIconShadow, true, true )
			IconHookup(government.AlphaIndex, 48, government.AlphaAtlas, instance.GovernmentTypeIcon)
		end
			
		Controls.WorldGovernmentsStack:CalculateSize();
		Controls.WorldGovernmentsStack:ReprocessAnchoring();
		Controls.WorldGovernmentsScrollPanel:CalculateInternalSize();
	end
	
end
g_Tabs["WorldGovernments"].RefreshContent = RefreshWorldGovernments;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowGovernmentOverview()	
	if (not Players[Game.GetActivePlayer()]:IsHuman()) then return end
	UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
end
LuaEvents.UI_ShowGovernmentOverview.Add(ShowGovernmentOverview)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnClose()
	UIManager:DequeuePopup(ContextPtr);
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function InputHandler(uiMsg, wParam, lParam)
  if (uiMsg == KeyEvents.KeyDown) then
    if (wParam == Keys.VK_ESCAPE) then
		if (not Controls.ReformConfirm:IsHidden()) then
			ReformConfirmNo()
		else
			OnClose()
		end
      return true
    end
  end
end
ContextPtr:SetInputHandler(InputHandler)
--------------------------------------------------------------------
function ShowHideHandler(bIsHide, bInitState)
	if (not bInitState and not bIsHide) then
		RefreshYourGovernment()
		RefreshYourReforms()
		RefreshWorldGovernments()
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)
ContextPtr:SetHide(true)
----------------------------------------------------------------
function AlphabeticalSortFunction(field, direction)
	if(direction == "asc") then
		return function(a,b)
			return Locale.Compare(a[field], b[field]) == -1;
		end
	elseif(direction == "desc") then
		return function(a,b)
			return Locale.Compare(a[field], b[field]) == 1;
		end
	end
end
----------------------------------------------------------------
function NumericSortFunction(field, direction)
	if(direction == "asc") then
		return function(a,b)
			return a[field] <= b[field];
		end
	elseif(direction == "desc") then
		return function(a,b)
			return a[field] > b[field];
		end
	end
end
----------------------------------------------------------------
function GetSortFunction(sortOptions)
	local orderBy = nil;
	for i,v in ipairs(sortOptions) do
		if(v.CurrentDirection ~= nil) then
			if(v.SortType == "Numeric") then
				return NumericSortFunction(v.Column, v.CurrentDirection);
			else
				return AlphabeticalSortFunction(v.Column, v.CurrentDirection);
			end
		end
	end
	
	return nil;
end
----------------------------------------------------------------
-- Updates the sort option structure
function UpdateSortOptionState(sortOptions, selectedOption)
	-- Current behavior is to only have 1 sort option enabled at a time 
	-- though the rest of the structure is built to support multiple in the future.
	-- If a sort option was selected that wasn't already selected, use the default 
	-- direction.  Otherwise, toggle to the other direction.
	for i,v in ipairs(sortOptions) do
		if(v == selectedOption) then
			if(v.CurrentDirection == nil) then			
				v.CurrentDirection = v.DefaultDirection;
			else
				if(v.CurrentDirection == "asc") then
					v.CurrentDirection = "desc";
				else
					v.CurrentDirection = "asc";
				end
			end
		else
			v.CurrentDirection = nil;
		end
	end
end
----------------------------------------------------------------
-- Updates the control states of sort options
function UpdateSortOptionsDisplay(sortOptions)
	for i,v in ipairs(sortOptions) do
		local imageControl = v.ImageControl;
		if(imageControl ~= nil) then
			if(v.CurrentDirection == nil) then
				imageControl:SetHide(true);
			else
				local imageToUse = "SelectedUp.dds";
				if(v.CurrentDirection == "desc") then
					imageToUse = "SelectedDown.dds";
				end
				imageControl:SetTexture(imageToUse);
				
				imageControl:SetHide(false);
			end
		end
	end
end
----------------------------------------------------------------
function YourReformsSortOptionSelected(option)
	local sortOptions = g_YourReformsSortOptions;
	UpdateSortOptionState(sortOptions, option);
	UpdateSortOptionsDisplay(sortOptions);
	g_YourReformsSortFunction = GetSortFunction(sortOptions);
	
	RefreshYourReforms();
end
----------------------------------------------------------------
function WorldGovernmentsSortOptionSelected(option)
	local sortOptions = g_WorldGovernmentsSortOptions;
	UpdateSortOptionState(sortOptions, option);
	UpdateSortOptionsDisplay(sortOptions);
	g_WorldGovernmentsSortFunction = GetSortFunction(sortOptions);
	
	RefreshWorldGovernments();
end
----------------------------------------------------------------
-- Registers the sort option controls click events
function RegisterSortOptions()
	
	--for i,v in ipairs(g_PoliticalFactionsSortOptions) do
	--	if(v.Button ~= nil) then
	--		v.Button:RegisterCallback(Mouse.eLClick, function() PoliticalFactionsSortOptionSelected(v); end);
	--	end
	-- end
	
	for i,v in ipairs(g_YourReformsSortOptions) do
		if(v.Button ~= nil) then
			v.Button:RegisterCallback(Mouse.eLClick, function() YourReformsSortOptionSelected(v); end);
		end
	end
	UpdateSortOptionsDisplay(g_YourReformsSortOptions);
	g_YourReformsSortFunction = GetSortFunction(g_YourReformsSortOptions);
	
	for i,v in ipairs(g_WorldGovernmentsSortOptions) do
		if(v.Button ~= nil) then
			v.Button:RegisterCallback(Mouse.eLClick, function() WorldGovernmentsSortOptionSelected(v); end);
		end
	end
	UpdateSortOptionsDisplay(g_WorldGovernmentsSortOptions);
	g_WorldGovernmentsSortFunction = GetSortFunction(g_WorldGovernmentsSortOptions);
	
	--UpdateSortOptionsDisplay(g_PoliticalFactionsSortOptions);
	--
	--g_PoliticalFactionsSortFunction = GetSortFunction(g_PoliticalFactionsSortOptions);
end
-----------------------------------------------------------------
-- Add Government Overview to Dropdown (if enabled)
-----------------------------------------------------------------
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(function(entries)
	table.insert(entries, {
		text=Locale.Lookup("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_SCREEN_TITLE"),
		call=function() 
			ShowGovernmentOverview()
		end,
	});
end);

-- Just in case :)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries();
----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnActivePlayerChanged()
	OnClose();
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged);

RegisterSortOptions();

-- Register tabbing behavior and assign global TabSelect routine.
TabSelect = RegisterTabBehavior(g_Tabs, g_Tabs["YourGovernment"]);

UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)

-------------------------------------------------
-------------------------------------------------
local tipControlTable = {};
TTManager:GetTypeControlTable( "FactionNameTT", tipControlTable );

function ShowNewLegislaturePopup( playerID, governmentID, isRevolution)
	
	
	playerID = playerID or Game.GetActivePlayer()
	local player = Players[playerID]
	
	if isRevolution then 
		IconHookup(15, 64, "JFD_SOVEREIGNTY_NOTIFICATION_ATLAS", Controls.RevolutionIcon)
		Controls.RevolutionBox:SetHide(false)
		Controls.NewLegislature:SetHide(true)
	else
		IconHookup(13, 64, "JFD_SOVEREIGNTY_NOTIFICATION_ATLAS", Controls.Icon)
		
		local government = GameInfo.JFD_Governments[governmentID]
		if government.GovernmentNewLegislatureImage then
			Controls.BgImage:SetTexture(government.GovernmentNewLegislatureImage)
		end
		if player:HasReform(reformFactionsMultiPartyID) then
			Controls.BgImage:SetTexture("NewLegislatureMultiParty.dds")
		elseif player:HasReform(reformFactionsTwoPartyID) then
			Controls.BgImage:SetTexture("NewLegislatureTwoParty.dds")
		end
				
		local strResultsTT 
		
		g_PoliticalFactionPopupManager:ResetInstances()
		
		local theseFactionsTable = {}
		
		--g_JFD_Factions_Table
		local factionsTable = g_JFD_Factions_Table
		local numFactions = #factionsTable
		for index = 1, numFactions do
			local row = factionsTable[index]
			local thisFactionID = row.ID
			if player:IsFactionValid(thisFactionID) then	
				local thisFactionPower = player:GetFactionPower(thisFactionID)
				-- if thisFactionPower > 0 then
					table.insert(theseFactionsTable, {FactionID = thisFactionID, Percent = thisFactionPower});
				-- end
			end
		end
		
		table.sort(theseFactionsTable, function(a,b) return a.Percent > b.Percent end)
		
		for _, faction in ipairs(theseFactionsTable) do
			local instance = g_PoliticalFactionPopupManager:GetInstance()
			local factionID = faction.FactionID
			local factionInfo = GameInfo.JFD_Factions[factionID]
			local factionName = player:GetFactionName(factionID)
			local factionPower = faction.Percent
			local factionHelp = player:GetFactionHelp(factionID, factionName, factionPower)
			instance.FactionName:LocalizeAndSetToolTip(factionHelp)
			instance.Sovereignty:LocalizeAndSetText("[COLOR_JFD_FACTION_POWER]{1_num}%[ICON_JFD_FACTION_POWER][ENDCOLOR]", factionPower)
			instance.Sovereignty:LocalizeAndSetToolTip("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_FACTION_POWER_TT")		
			if factionPower <= 0 then
				instance.FactionBase:SetAlpha(0.4)
			else
				instance.FactionBase:SetAlpha(1)
			end
			
			local factionPlayerID = player:GetFactionCivType(factionID)
			if factionPlayerID > -1 then
				local factionPlayer = Players[factionPlayerID]
				if (not factionPlayer:IsMinorCiv()) then
					local civType = GameInfo.Civilizations[factionPlayer:GetCivilizationType()]
					instance.CivIconBox:SetHide(false)
					instance.CivIconFont:SetText(factionInfo.IconString)
					CivIconHookup(factionPlayerID, 32, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true, instance.CivIconHighlight)
					instance.FactionName:SetOffsetVal(34,0)
					instance.FactionName:SetText(" " .. factionName)
				else
					instance.FactionName:SetText(factionInfo.IconString .. " " .. factionName)
				end
			else
				instance.CivIconBox:SetHide(true)
				instance.FactionName:SetOffsetVal(12,0)
				instance.FactionName:SetText(factionInfo.IconString .. " " .. factionName)
				local nameSizeX = instance.FactionName:GetSizeX()
				if nameSizeX > 300 then
					instance.FactionName:SetFontByName("TwCenMT14")
				elseif nameSizeX > 250 then
					instance.FactionName:SetFontByName("TwCenMT16")
				else
					instance.FactionName:SetFontByName("TwCenMT18")
				end
			end
		end
		
		Controls.Stats:LocalizeAndSetText("TXT_KEY_JFD_NEW_LEGISLATURE_POPUP_TEXT")	
		Controls.FactionPopupStack:CalculateSize()
		Controls.FactionPopupStack:ReprocessAnchoring()
		Controls.FactionPopupScrollPanel:CalculateInternalSize()
		Controls.FactionPopupScrollPanel:SetHide(false)
		Controls.RevolutionBox:SetHide(true)
		Controls.NewLegislature:SetHide(false)
	end
end
LuaEvents.UI_ShowNewLegislaturePopup.Add(ShowNewLegislaturePopup) 
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnCloseNewLegislatureButtonClicked()
   Controls.NewLegislature:SetHide(true)
end
Controls.CloseNewLegislatureButton:RegisterCallback( Mouse.eLClick, OnCloseNewLegislatureButtonClicked );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnCloseRevolutionButtonClicked()
   Controls.RevolutionBox:SetHide(true)
end
Controls.CloseRevolutionButton:RegisterCallback( Mouse.eLClick, OnCloseRevolutionButtonClicked );