-------------------------------------------------
-- Action Info Panel
-------------------------------------------------
include( "IconSupport" );
include( "InstanceManager" );

-- local g_ActiveNotifications = {};
-- local g_Instances = {};
------------------------------------------------------------------------------------------------------------------------
print("Custom Notification Panel loaded -- Original Author: bc1, adapted by JFD")

-------------------------------------------------------------------------------
-- details for dynamically sizing the small notification stack
-------------------------------------------------------------------------------
local DIPLO_SIZE_GUESS = 120;
local _, screenY = UIManager:GetScreenSizeVal();
local _, offsetY = Controls.OuterStack:GetOffsetVal();
local g_SmallScrollMax = screenY - offsetY - DIPLO_SIZE_GUESS;

local g_ActiveNotifications = {}
local g_Instances = {}
local g_screenWidth , g_screenHeight = UIManager:GetScreenSizeVal()
local g_chatPanelHeight = 170
local g_diploButtonsHeight = 108
local g_maxTotalStackHeight
local g_alertMessages = {}
local g_alertButton
-------------------------------------------------
-- List of notification types we can handle
-------------------------------------------------
local g_notificationNames = {}
local g_notificationBundled = {}
for k, v, w in ([[
	NOTIFICATION_POLICY														SocialPolicy
	NOTIFICATION_MET_MINOR													CityState				B
	NOTIFICATION_MINOR														CityState				B
	NOTIFICATION_MINOR_QUEST												CityState				special
	NOTIFICATION_ENEMY_IN_TERRITORY											EnemyInTerritory		B
	NOTIFICATION_REBELS														EnemyInTerritory		B
	NOTIFICATION_CITY_RANGE_ATTACK											CityCanBombard			B
	NOTIFICATION_BARBARIAN													Barbarian				B
	NOTIFICATION_GOODY														AncientRuins			B
	NOTIFICATION_BUY_TILE													BuyTile	
	NOTIFICATION_CITY_GROWTH												CityGrowth	
	NOTIFICATION_CITY_TILE													CityTile	
	NOTIFICATION_DEMAND_RESOURCE											BonusResource	
	NOTIFICATION_UNIT_PROMOTION												UnitPromoted			B
	NOTIFICATION_WONDER_STARTED												WonderConstructed	
	NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER								WonderConstructed	
	NOTIFICATION_WONDER_COMPLETED											WonderConstructed	
	NOTIFICATION_WONDER_BEATEN												WonderConstructed	
	NOTIFICATION_GOLDEN_AGE_BEGUN_ACTIVE_PLAYER								GoldenAge	
	NOTIFICATION_GOLDEN_AGE_BEGUN											GoldenAge	
	NOTIFICATION_GOLDEN_AGE_ENDED_ACTIVE_PLAYER								GoldenAgeComplete	
	NOTIFICATION_GOLDEN_AGE_ENDED											GoldenAgeComplete	
	NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER									GreatPerson				popup
	NOTIFICATION_GREAT_PERSON												GreatPerson	
	NOTIFICATION_STARVING													Starving				B
	NOTIFICATION_WAR_ACTIVE_PLAYER											War						
	NOTIFICATION_WAR														WarOther				
	NOTIFICATION_PEACE_ACTIVE_PLAYER										Peace					
	NOTIFICATION_PEACE														PeaceOther				
	NOTIFICATION_VICTORY													Victory	
	NOTIFICATION_UNIT_DIED													UnitDied	
	NOTIFICATION_CITY_LOST													CapitalLost	
	NOTIFICATION_CAPITAL_LOST_ACTIVE_PLAYER									CapitalLost	
	NOTIFICATION_CAPITAL_LOST												CapitalLost	
	NOTIFICATION_CAPITAL_RECOVERED											CapitalRecovered	
	NOTIFICATION_PLAYER_KILLED												CapitalLost	
	NOTIFICATION_DISCOVERED_LUXURY_RESOURCE									LuxuryResource			B
	NOTIFICATION_DISCOVERED_STRATEGIC_RESOURCE								StrategicResource		B
	NOTIFICATION_DISCOVERED_BONUS_RESOURCE									BonusResource			B
	NOTIFICATION_POLICY_ADOPTION											Generic					B
	NOTIFICATION_DIPLO_VOTE													Generic	
	NOTIFICATION_RELIGION_RACE												Generic	
	NOTIFICATION_EXPLORATION_RACE											NaturalWonder	
	NOTIFICATION_DIPLOMACY_DECLARATION										Diplomacy				B
	NOTIFICATION_DEAL_EXPIRED_GPT											DiplomacyX				B
	NOTIFICATION_DEAL_EXPIRED_RESOURCE										DiplomacyX				B
	NOTIFICATION_DEAL_EXPIRED_OPEN_BORDERS									DiplomacyX				B
	NOTIFICATION_DEAL_EXPIRED_DEFENSIVE_PACT								DiplomacyX				B
	NOTIFICATION_DEAL_EXPIRED_RESEARCH_AGREEMENT							ResearchAgreementX		B
	NOTIFICATION_DEAL_EXPIRED_TRADE_AGREEMENT								DiplomacyX				B
	NOTIFICATION_TECH_AWARD													TechAward	
	NOTIFICATION_PLAYER_DEAL												Diplomacy	
	NOTIFICATION_PLAYER_DEAL_RECEIVED										Diplomacy				B
	NOTIFICATION_PLAYER_DEAL_RESOLVED										Diplomacy				B
	NOTIFICATION_PROJECT_COMPLETED											ProjectConstructed
								
	NOTIFICATION_TECH														Tech
	NOTIFICATION_PRODUCTION													Production
	NOTIFICATION_FREE_TECH													FreeTech
	NOTIFICATION_SPY_STOLE_TECH												StealTech
	NOTIFICATION_FREE_POLICY												FreePolicy
	NOTIFICATION_FREE_GREAT_PERSON											FreeGreatPerson
						
	NOTIFICATION_DENUNCIATION_EXPIRED										Diplomacy				B
	NOTIFICATION_FRIENDSHIP_EXPIRED											FriendshipX				B
							
	NOTIFICATION_FOUND_PANTHEON												FoundPantheon	
	NOTIFICATION_FOUND_RELIGION												FoundReligion	
	NOTIFICATION_PANTHEON_FOUNDED_ACTIVE_PLAYER								PantheonFounded	
	NOTIFICATION_PANTHEON_FOUNDED											PantheonFounded			
	NOTIFICATION_RELIGION_FOUNDED_ACTIVE_PLAYER								ReligionFounded			B
	NOTIFICATION_RELIGION_FOUNDED											ReligionFounded			
	NOTIFICATION_ENHANCE_RELIGION											EnhanceReligion	
	NOTIFICATION_RELIGION_ENHANCED_ACTIVE_PLAYER							ReligionEnhanced	
	NOTIFICATION_RELIGION_ENHANCED											ReligionEnhanced		
	NOTIFICATION_RELIGION_SPREAD											ReligionSpread			B
							
	NOTIFICATION_SPY_CREATED_ACTIVE_PLAYER									NewSpy					B
	NOTIFICATION_SPY_CANT_STEAL_TECH										SpyCannotSteal			B
	NOTIFICATION_SPY_EVICTED												Spy						B
	NOTIFICATION_TECH_STOLEN_SPY_DETECTED									Spy						B
	NOTIFICATION_TECH_STOLEN_SPY_IDENTIFIED									Spy						B
	NOTIFICATION_SPY_KILLED_A_SPY											SpyKilledASpy			B
	NOTIFICATION_SPY_WAS_KILLED												SpyWasKilled			B
	NOTIFICATION_SPY_REPLACEMENT											Spy						B
	NOTIFICATION_SPY_PROMOTION												SpyPromotion			B
	NOTIFICATION_INTRIGUE_DECEPTION											Spy						B

	NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_ARMY						Spy						B
	NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_AMPHIBIOUS					Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_UNKNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_KNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_UNKNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_KNOWN			Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_UNKNOWN					Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_UNKNOWN	Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_KNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_UNKNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_KNOWN		Spy						B
	NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_UNKNOWN				Spy						B
	NOTIFICATION_INTRIGUE_CONSTRUCTING_WONDER								Spy						B
	
	NOTIFICATION_SPY_RIG_ELECTION_SUCCESS									Spy						B
	NOTIFICATION_SPY_RIG_ELECTION_FAILURE									Spy						B
	NOTIFICATION_SPY_RIG_ELECTION_ALERT										Spy						B
	NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS									Spy						B
	NOTIFICATION_SPY_YOU_STAGE_COUP_FAILURE									SpyWasKilled			B
	NOTIFICATION_SPY_STAGE_COUP_SUCCESS										Spy						B
	NOTIFICATION_SPY_STAGE_COUP_FAILURE										Spy						B
	NOTIFICATION_DIPLOMAT_EJECTED											Diplomat				B
									
	NOTIFICATION_CAN_BUILD_MISSIONARY										EnoughFaith				B
	NOTIFICATION_AUTOMATIC_FAITH_PURCHASE_STOPPED							AutomaticFaithStop		B
	NOTIFICATION_OTHER_PLAYER_NEW_ERA										OtherPlayerNewEra		B
							
	NOTIFICATION_MAYA_LONG_COUNT											FreeGreatPerson	
	NOTIFICATION_FAITH_GREAT_PERSON											FreeGreatPerson	
							
	NOTIFICATION_EXPANSION_PROMISE_EXPIRED									Diplomacy				B
	NOTIFICATION_BORDER_PROMISE_EXPIRED										Diplomacy				B
							
	NOTIFICATION_TRADE_ROUTE												TradeRoute				B
	NOTIFICATION_TRADE_ROUTE_BROKEN											TradeRouteBroken		B
						
	NOTIFICATION_RELIGION_SPREAD_NATURAL									ReligionNaturalSpread	B
						
	NOTIFICATION_MINOR_BUYOUT												CityState				B
						
	NOTIFICATION_REQUEST_RESOURCE											BonusResource
						
	NOTIFICATION_ADD_REFORMATION_BELIEF										AddReformationBelief
	NOTIFICATION_LEAGUE_CALL_FOR_PROPOSALS									LeagueCallForProposals

	NOTIFICATION_CHOOSE_ARCHAEOLOGY											ChooseArchaeology
	NOTIFICATION_LEAGUE_CALL_FOR_VOTES										LeagueCallForVotes
				
	NOTIFICATION_REFORMATION_BELIEF_ADDED_ACTIVE_PLAYER						ReformationBeliefAdded
	NOTIFICATION_REFORMATION_BELIEF_ADDED									ReformationBeliefAdded	B
				
	NOTIFICATION_GREAT_WORK_COMPLETED_ACTIVE_PLAYER							GreatWork
				
	NOTIFICATION_LEAGUE_VOTING_DONE											LeagueVotingDone
	NOTIFICATION_LEAGUE_VOTING_SOON											LeagueVotingSoon
				
	NOTIFICATION_CULTURE_VICTORY_SOMEONE_INFLUENTIAL						CultureVictoryPositive	B
	NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO									CultureVictoryNegative	B
	NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO_ACTIVE_PLAYER					CultureVictoryPositive	B
	NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE									CultureVictoryNegative	B
	NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE_ACTIVE_PLAYER					CultureVictoryPositive	B
	NOTIFICATION_CULTURE_VICTORY_NO_LONGER_INFLUENTIAL						CultureVictoryNegative	B

	NOTIFICATION_CHOOSE_IDEOLOGY											ChooseIdeology			popup
	NOTIFICATION_IDEOLOGY_CHOSEN											IdeologyChosen			popup

	NOTIFICATION_LIBERATED_MAJOR_CITY										CapitalRecovered
	NOTIFICATION_RESURRECTED_MAJOR_CIV										CapitalRecovered

	NOTIFICATION_PLAYER_RECONNECTED											PlayerReconnected
	NOTIFICATION_PLAYER_DISCONNECTED										PlayerDisconnected
	NOTIFICATION_TURN_MODE_SEQUENTIAL										SequentialTurns
	NOTIFICATION_TURN_MODE_SIMULTANEOUS										SimultaneousTurns
	NOTIFICATION_HOST_MIGRATION												HostMigration
	NOTIFICATION_PLAYER_CONNECTING											PlayerConnecting
	NOTIFICATION_PLAYER_KICKED												PlayerKicked
								
	NOTIFICATION_CITY_REVOLT_POSSIBLE										Generic
	NOTIFICATION_CITY_REVOLT												Generic

	NOTIFICATION_LEAGUE_PROJECT_COMPLETE									LeagueProjectComplete
	NOTIFICATION_LEAGUE_PROJECT_PROGRESS									LeagueProjectProgress
	
	--JFD
	NOTIFICATION_JFD_DARK_AGE_BEGUN_ACTIVE_PLAYER							DarkAge	
	NOTIFICATION_JFD_DARK_AGE_BEGUN											DarkAge	
	NOTIFICATION_JFD_DARK_AGE_ENDED_ACTIVE_PLAYER							DarkAgeComplete	
	NOTIFICATION_JFD_DARK_AGE_ENDED											DarkAgeComplete	
	NOTIFICATION_JFD_CYCLE_OF_POWER											CycleOfPower			
	NOTIFICATION_JFD_CYCLE_OF_POWER_ANARCHY									CycleOfPowerAnarchy			
	NOTIFICATION_JFD_CYCLE_OF_POWER_CHOICE									CycleOfPowerChoice		popup		
	NOTIFICATION_JFD_CYCLE_POWER											CyclePower		
	NOTIFICATION_JFD_EPITHET												Epithet		
	NOTIFICATION_JFD_GOVERNMENT												Government				popup			
	NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER								GovernmentActivePlayer	
	NOTIFICATION_JFD_GOVERNMENT_CHOICE										GovernmentChoice		popup		
	NOTIFICATION_JFD_GOVERNMENT_LEGISLATURE									GovernmentLegislature
	NOTIFICATION_JFD_GOVERNMENT_REFORM										GovernmentReform
	NOTIFICATION_JFD_GOVERNMENT_REFORM_ANARCHY								GovernmentReformAnarchy
	NOTIFICATION_JFD_MODERNIZATION											Modernization			
	NOTIFICATION_JFD_MODERNIZATION_CHOICE									ModernizationChoice		popup
	NOTIFICATION_JFD_NATIONALISM_POLICY										NationalismPolicy		
	NOTIFICATION_JFD_PRISONERS_WAR											PrisonersWar			
	NOTIFICATION_JFD_PRISONERS_WAR_CHOICE									PrisonersWarChoice		popup
	NOTIFICATION_JFD_SPIRIT_IDEOLOGY										SpiritIdeology			
	
	--CP
	NOTIFICATION_INSTANT_YIELD												InstantYieldItem		B
	NOTIFICATION_EVENT_CHOICE_CITY											CityEventChoice			popup
	NOTIFICATION_EVENT_CHOICE												EventChoice				popup
	NOTIFICATION_EVENT_CHOICE_CITY_FIN										CityEventChoiceFin		B
	NOTIFICATION_EVENT_CHOICE_FIN											EventChoiceFin			B
	
]]):gmatch("(%S+)[^%S\n\r]*(%S*)[^%S\n\r]*(%S*)[^\n\r]*") do
	local n = NotificationTypes[k]
	if n then
		g_notificationNames[ n ] = v
		g_notificationBundled[ n ] = w ~= ""
	end
end
-------------------------------------------------
-- Process Stack Sizes
-------------------------------------------------
local function ProcessStackSizes()

	local maxTotalStackHeight, smallStackHeight
	if g_leaderMode then
		maxTotalStackHeight = g_screenHeight
		smallStackHeight = 0
	else
		Controls.BigStack:CalculateSize()
		Controls.SmallStack:CalculateSize()
		maxTotalStackHeight = g_maxTotalStackHeight - Controls.BigStack:GetSizeY()
		smallStackHeight = Controls.SmallStack:GetSizeY()
	end
	smallStackHeight = math.min( smallStackHeight, maxTotalStackHeight )

	if not g_leaderMode then
		Controls.SmallScrollPanel:SetSizeY( smallStackHeight )
		Controls.SmallScrollPanel:ReprocessAnchoring()
		Controls.SmallScrollPanel:CalculateInternalSize()
		if Controls.SmallScrollPanel:GetRatio() < 1 then
			Controls.SmallScrollPanel:SetOffsetX( 18 )
		else
			Controls.SmallScrollPanel:SetOffsetX( 0 )
		end
		Controls.OuterStack:CalculateSize()
		Controls.OuterStack:ReprocessAnchoring()
	end
end

local diploChatPanel = LookUpControl( "/InGame/WorldView/DiploCorner/ChatPanel" )
if diploChatPanel then
	g_chatPanelHeight = diploChatPanel:GetSizeY()
end

local function OnChatToggle( isChatOpen )
	g_civPanelOffsetY = g_diploButtonsHeight + (isChatOpen and g_chatPanelHeight or 0)
	g_maxTotalStackHeight = g_screenHeight - Controls.OuterStack:GetOffsetY() - g_civPanelOffsetY
	if not g_leaderMode then
		ProcessStackSizes( true )
	end
end
OnChatToggle( PreGame.IsMultiplayerGame() )

if g_alertButton and g_alertButton.SetToolTipString then
	Events.GameplayAlertMessage.Add(
	function( messageText )
		table_insert( g_alertMessages, messageText )
		g_alertButton:SetToolTipString( table_concat(g_alertMessages,"[NEWLINE]") )
	end)
end
-------------------------------------------------
-- Setup Notification
-------------------------------------------------

local function SetupNotification( instance, sequence, Id, type, toolTip, strSummary, iGameValue, iExtraGameData, playerID )
	if type == NotificationTypes.NOTIFICATION_UNIT_DIED and toolTip == "" and strSummary == "" then
		strSummary = Locale.ConvertTextKey("TXT_KEY_UNIT_LOST")
		toolTip = Locale.ConvertTextKey("TXT_KEY_UNIT_LOST_DETAILED", GameInfo.Units[iGameValue].Description)
	end
	if toolTip ~= strSummary then
		toolTip = strSummary .. "[NEWLINE][NEWLINE]" .. toolTip
	end
--DEBUG analysis ONLY
--for k,v in pairs(NotificationTypes) do if v==type then toolTip = "[COLOR_RED]" .. k .. "[/COLOR][NEWLINE]" .. toolTip break end end
--toolTip = " [COLOR_YELLOW]Id = "..Id..", data1 = "..tostring(iGameValue)..", data2 = "..tostring(iExtraGameData).."[/COLOR][NEWLINE]"..toolTip

	if #instance > 1 then
		toolTip = "#" .. instance.Button:GetVoid2() .. "/" .. #instance .. " - " .. toolTip
	end
	if instance.Container then
-- todo reset finger animation - requires style modification
		if type == NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER
		or type == NotificationTypes.NOTIFICATION_WONDER_COMPLETED
		or type == NotificationTypes.NOTIFICATION_WONDER_BEATEN
		then
			if iGameValue ~= -1 then
				local portraitIndex = GameInfo.Buildings[iGameValue].PortraitIndex
				if portraitIndex ~= -1 then
					IconHookup( portraitIndex, 80, GameInfo.Buildings[iGameValue].IconAtlas, instance.WonderConstructedAlphaAnim )
				end
			end
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.WonderSmallCivFrame:SetHide(false)
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.WonderSmallCivFrame:SetHide(true)
			end
		elseif type == NotificationTypes.NOTIFICATION_PROJECT_COMPLETED then
			if iGameValue ~= -1 then
				local portraitIndex = GameInfo.Projects[iGameValue].PortraitIndex
				if portraitIndex ~= -1 then
					IconHookup( portraitIndex, 80, GameInfo.Projects[iGameValue].IconAtlas, instance.ProjectConstructedAlphaAnim )
				end
			end
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.ProjectSmallCivFrame:SetHide(false)
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.ProjectSmallCivFrame:SetHide(true)
			end
		elseif type == NotificationTypes.NOTIFICATION_DISCOVERED_LUXURY_RESOURCE
		or type == NotificationTypes.NOTIFICATION_DISCOVERED_STRATEGIC_RESOURCE
		or type == NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE
		or type == NotificationTypes.NOTIFICATION_DEMAND_RESOURCE
		or type == NotificationTypes.NOTIFICATION_REQUEST_RESOURCE
		then
			local thisResourceInfo = GameInfo.Resources[iGameValue]
			local portraitIndex = thisResourceInfo.PortraitIndex
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisResourceInfo.IconAtlas, instance.ResourceImage )
			end
		elseif type == NotificationTypes.NOTIFICATION_CITY_TILE then
			local plot = Map.GetPlotByIndex( iGameValue )
			local info = plot and plot:GetResourceType( g_activeTeamID )
			info = info and GameInfo.Resources[info]	-- or GameInfo.Terrains[info]
			local offset, texture
			if info then
				offset, texture = IconLookup( info.PortraitIndex, 80, info.IconAtlas )
				if texture then
					instance.ResourceImage:SetTextureOffsetVal( offset.x, offset.y +2 )
					instance.ResourceImage:SetTexture( texture or "NotificationTileGlow.dds" )
				end
			end
			instance.ResourceImage:SetHide( not texture )
		elseif type == NotificationTypes.NOTIFICATION_EXPLORATION_RACE then
			local thisFeatureInfo = GameInfo.Features[iGameValue]
			local portraitIndex = thisFeatureInfo.PortraitIndex
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisFeatureInfo.IconAtlas, instance.NaturalWonderImage )
			end
		elseif type == NotificationTypes.NOTIFICATION_TECH_AWARD then
			local thisTechInfo = GameInfo.Technologies[iExtraGameData]
			local portraitIndex = thisTechInfo.PortraitIndex
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisTechInfo.IconAtlas, instance.TechAwardImage )
			else
				instance.TechAwardImage:SetHide( true )
			end
		elseif type == NotificationTypes.NOTIFICATION_UNIT_PROMOTION
		or type == NotificationTypes.NOTIFICATION_UNIT_DIED
		or type == NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER
		or type == NotificationTypes.NOTIFICATION_ENEMY_IN_TERRITORY
		or type == NotificationTypes.NOTIFICATION_REBELS
		then
			-------------------------------------------------
			-- JFD
			-------------------------------------------------
			if type == NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER then
				instance.Button:RegisterCallback( Mouse.eLClick, function() 
					local popupInfo = 
					{
						Type  = ButtonPopupTypes.BUTTONPOPUP_GREAT_PERSON_REWARD,
						Data1  = iGameValue
					};
					Events.SerialEventGameMessagePopup(popupInfo) 
				end )
			end
			-------------------------------------------------
			-- JFD
			-------------------------------------------------
			
			local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon( iGameValue, playerID )
			if portraitOffset ~= -1 then
				IconHookup( portraitOffset, 80, portraitAtlas, instance.UnitImage )
			end

		-------------------------------------------------
		-- JFD
		-------------------------------------------------
		elseif type == NotificationTypes.NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER then
			if iGameValue == -1 then iGameValue = 1 end
			local government = GameInfo.JFD_Governments[iGameValue]
			IconHookup( government.PortraitIndex, 80, government.IconAtlas, instance.NotificationImage )
			IconHookup( government.PortraitIndex, 80, government.IconAtlas, instance.NotificationAnim )
		-------------------------------------------------
		-- JFD
		-------------------------------------------------

		elseif type == NotificationTypes.NOTIFICATION_WAR_ACTIVE_PLAYER then
			CivIconHookup( iGameValue, 80, instance.WarImage, instance.CivIconBG, instance.CivIconShadow, false, true )

		elseif type == NotificationTypes.NOTIFICATION_WAR then
			CivIconHookup( iGameValue, 45, instance.War1Image, instance.Civ1IconBG, instance.Civ1IconShadow, false, true )
			local team = Teams[iExtraGameData]
			CivIconHookup( team and team:GetLeaderID() or -1, 45, instance.War2Image, instance.Civ2IconBG, instance.Civ2IconShadow, false, true )

		elseif type == NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER then
			CivIconHookup( iGameValue, 80, instance.PeaceImage, instance.CivIconBG, instance.CivIconShadow, false, true )

		elseif type == NotificationTypes.NOTIFICATION_PEACE then
			CivIconHookup( iGameValue, 45, instance.Peace1Image, instance.Civ1IconBG, instance.Civ1IconShadow, false, true )
			local team = Teams[iExtraGameData]
			CivIconHookup( team and team:GetLeaderID() or -1, 45, instance.Peace2Image, instance.Civ2IconBG, instance.Civ2IconShadow, false, true )

		elseif type == NotificationTypes.NOTIFICATION_GREAT_WORK_COMPLETED_ACTIVE_PLAYER then
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.WonderSmallCivFrame:SetHide(false)
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true )
				instance.WonderSmallCivFrame:SetHide(true)
			end
		end
		instance.FingerTitle:SetText( strSummary )
	end
	instance.Button:SetVoids( Id, sequence )
	instance.Button:SetToolTipString( toolTip )
end

-------------------------------------------------
-- Notification Click Handlers
-------------------------------------------------

local function GenericLeftClick( Id )
	local index = g_ActiveNotifications[ Id ]
	local instance = g_Instances[ index ]
	if instance and #instance > 0 then
		local sequence = instance.Button:GetVoid2() % #instance + 1
		local data = instance[ sequence ]
		SetupNotification( instance, sequence, unpack( data ) )
		-- Special kludge to work around DLL's stupid city state popups
		if data[2] == NotificationTypes.NOTIFICATION_MINOR_QUEST then
			local minorPlayer = Players[ data[5] ]
			if minorPlayer then
				local city = minorPlayer:GetCapitalCity()
-- todo: doesn't seem to work
				local plot = Map.GetPlot( minorPlayer:GetQuestData1( data[7], data[6] ),
							  minorPlayer:GetQuestData2( data[7], data[6] ) )
						or ( city and city:Plot() )
				if plot then
					UI.LookAt(plot, 0)
					local hex = ToHexFromGrid{ x=plot:GetX(), y=plot:GetY() }
					Events.GameplayFX( hex.x, hex.y, -1 )
					return
				end
			end
		end
		-- Popups @ previous Id / Lookat @ next Id
		if not Controls[ index ] then
			Id = data[1]
		end
	end
	UI.ActivateNotification( Id )
end

local function GenericRightClick ( Id )
	local instance = g_Instances[ g_ActiveNotifications[ Id ] ]
	if instance and #instance > 0 then
		for sequence = 1, #instance do
			UI.RemoveNotification( instance[sequence][1] )
		end
	else
		UI.RemoveNotification( Id )
	end
end
LuaEvents.NotificationButtonRemoved.Add(GenericRightClick)

for _, button in pairs( Controls ) do
	if button.ClearCallback then
		button:RegisterCallback( Mouse.eLClick, GenericLeftClick )
		button:RegisterCallback( Mouse.eRClick, GenericRightClick )
		if UI.IsTouchScreenEnabled() then
			button:RegisterCallback( Mouse.eLDblClick, GenericRightClick )
		end
	end
end

-------------------------------------------------
-- Notification Added
-------------------------------------------------
Events.NotificationAdded.Add(
function( Id, type, ... ) -- toolTip, strSummary, iGameValue, iExtraGameData, playerID )
	local name = not g_ActiveNotifications[ Id ] and (g_notificationNames[ type ] or "Generic")
	if name then
		local button = Controls[ name ]
		local bundled = button or g_notificationBundled[ type ]
		local index = bundled and name or Id
		g_ActiveNotifications[ Id ] = index
		local instance = g_Instances[ index ]
		if not instance then
			instance = {}
			g_Instances[ index ] = instance
			if button then
				button:SetHide( false )
				instance.Button = button
				if type == NotificationTypes.NOTIFICATION_FOUND_RELIGION
				   or type == NotificationTypes.NOTIFICATION_ENHANCE_RELIGION
				   or type == NotificationTypes.NOTIFICATION_ADD_REFORMATION_BELIEF
				then
					UI.ActivateNotification( Id )
				end
			else
				ContextPtr:BuildInstanceForControl( name, instance, Controls.SmallStack )
				instance.Container:BranchResetAnimation()
				button = instance.Button
				button:RegisterCallback( Mouse.eLClick, GenericLeftClick )
				button:RegisterCallback( Mouse.eRClick, GenericRightClick )
				if UI.IsTouchScreenEnabled() then
					button:RegisterCallback( Mouse.eLDblClick, GenericRightClick )
				end

				----------------------------------------------------------------
				-- JFD
				----------------------------------------------------------------
				if type == NotificationTypes.NOTIFICATION_JFD_GOVERNMENT 
				or type == NotificationTypes.NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER
				or type == NotificationTypes.NOTIFICATION_JFD_GOVERNMENT_REFORM
				or type == NotificationTypes.NOTIFICATION_JFD_GOVERNMENT_LEGISLATURE
				then
					button:RegisterCallback( Mouse.eLClick, function() LuaEvents.UI_ShowGovernmentOverview() end )
				end
				----------------------------------------------------------------
				-- JFD
				----------------------------------------------------------------

			end
		end
		if name == "Production" then
			local activePlayer = Players[Game.GetActivePlayer()]
			local isCityForProduction = false
			for city in activePlayer:Cities() do
				if city:GetProductionProject() == -1 and city:GetProductionUnit() == -1 and city:GetProductionBuilding() == -1 then
					isCityForProduction = true
					break
				end
			end
			if isCityForProduction then
				if bundled then
					table.insert( instance, { Id, type, ... } )
				end
				SetupNotification( instance, #instance, Id, type, ... )
		
				ProcessStackSizes( true )
			end
		
		----------------------------------------------------------------
		-- JFD
		----------------------------------------------------------------
		elseif name == "GovernmentChoice" then
			local activePlayer = Players[Game.GetActivePlayer()]
			button:RegisterCallback( Mouse.eLClick, function() LuaEvents.UI_ShowChooseGovernmentPopup() end )		
			if bundled then
				table.insert( instance, { Id, type, ... } )
			end
			SetupNotification( instance, #instance, Id, type, ... )
		
			ProcessStackSizes( true )
		elseif name == "CycleOfPowerChoice" then
			local activePlayer = Players[Game.GetActivePlayer()]
			if (not activePlayer:IsHasCycleOfPowerBegun()) then
				button:RegisterCallback( Mouse.eLClick, function() LuaEvents.UI_ShowChooseCycleOfPowerPopup() end )
			end
			if bundled then
				table.insert( instance, { Id, type, ... } )
			end
			SetupNotification( instance, #instance, Id, type, ... )
		
			ProcessStackSizes( true )
		----------------------------------------------------------------
		-- JFD
		----------------------------------------------------------------
		
		else
			if bundled then
				table.insert( instance, { Id, type, ... } )
			end
			SetupNotification( instance, #instance, Id, type, ... )
		
			ProcessStackSizes( true )
		end

		--JFD
		LuaEvents.NotificationButtonAdded(button, Id, type, toolTip, strSummary, iGameValue, iExtraGameData, playerID)
	end
end)

function NotificationInfoAdded(player, data1)
	print(player, data1)
end
LuaEvents.NotificationInfoAdded.Add(NotificationInfoAdded)

-------------------------------------------------
-- Remove Notification
-------------------------------------------------

local function RemoveNotificationID( Id )

	local index = g_ActiveNotifications[ Id ]
	g_ActiveNotifications[ Id ] = nil
	local instance = g_Instances[ index ]
	if instance then
		for i = 1, #instance do
			if instance[i][ 1 ] == Id then
				table.remove( instance, i )
				break
			end
		end
		local button = instance.Button
		-- Is bundle now empty ?
		if #instance == 0 then
			if instance.Container then
				Controls.SmallStack:ReleaseChild( instance.Container )
			else
				button:SetHide( true )
			end
			g_Instances[ index ] = nil
		-- Update visible notification if it was removed
		elseif Id == button:GetVoid1() then
			local sequence = button:GetVoid2()
			if sequence > #instance then
				sequence = 1
			end
			SetupNotification( instance, sequence, unpack( instance[sequence] ) )
		end
	end
end

Events.NotificationRemoved.Add(
function( Id )

--print( "removing Notification " .. Id .. " " .. tostring( g_ActiveNotifications[ Id ] ) .. " " .. tostring( g_notificationNames[ g_ActiveNotifications[ Id ] ] ) )

	RemoveNotificationID( Id )
	ProcessStackSizes()

end)

-------------------------------------------------
-- Additional notifications
-------------------------------------------------
GameEvents.SetPopulation.Add(
function( x, y, oldPopulation, newPopulation )
	local plot = Map.GetPlot( x, y )
	local city = plot and plot:GetPlotCity()
	local playerID = city and city:GetOwner()
	--print("Player#", playerID, "City:", city and city:GetName(), x, y, plot)
	if playerID == g_activePlayerID	-- active player only
		and newPopulation > 5			-- game engine already does up to 5 pop
		and newPopulation > oldPopulation	-- growth only
		and not city:IsPuppet()			-- who cares ? nothing to be done
		and not city:IsResistance()		-- who cares ? nothing to be done
		and Game.GetGameTurn() > city:GetGameTurnAcquired() -- inhibit upon city creation & capture
	then
		g_activePlayer:AddNotification(NotificationTypes.NOTIFICATION_CITY_GROWTH,
			L("TXT_KEY_NOTIFICATION_CITY_GROWTH", city:GetName(), newPopulation ),
			L("TXT_KEY_NOTIFICATION_SUMMARY_CITY_GROWTH", city:GetName() ),
			x, y, plot:GetPlotIndex() )	--iGameDataIndex, int iExtraGameData
		--print( "Notification sent:", NotificationTypes.NOTIFICATION_CITY_GROWTH, sTip, sTitle, x, y )
	end
end)

GameEvents.CityBoughtPlot.Add(
function( playerID, cityID, x, y, isWithGold, isWithFaithOrCulture )

	if isWithFaithOrCulture and playerID == g_activePlayerID then
		--print( "Border growth at coordinates: ", x, y, "playerID:", playerID, "isWithGold", isWithGold, "isWithFaithOrCulture", isWithFaithOrCulture )
		local plot = Map.GetPlot( x, y )
		local city = g_activePlayer:GetCityByID( cityID )
		--print( "CityTileNotification:", city and city:GetName(), x, y, plot, city and city:GetCityPlotIndex(plot) )

		if plot and city and ( ( plot:GetWorkingCity() and not city:IsPuppet() ) or Game.GetResourceUsageType( plot:GetResourceType( g_activeTeamID ) ) > 0 )
		-- valid plot, either worked by city which is not a puppet, or has some kind of resource we can use
		then
			g_activePlayer:AddNotification( NotificationTypes.NOTIFICATION_CITY_TILE,
				L( "TXT_KEY_NOTIFICATION_CITY_CULTURE_ACQUIRED_NEW_PLOT", city:GetName() ),
				L( "TXT_KEY_NOTIFICATION_SUMMARY_CITY_CULTURE_ACQUIRED_NEW_PLOT", city:GetName() ),
				x, y, plot:GetPlotIndex() )	--iGameDataIndex, int iExtraGameData
			--print( "CityTileNotification sent:", NotificationTypes.NOTIFICATION_CITY_TILE, city:GetName(), x, y )
		end
	end
end)
----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnNotificationPanelActivePlayerChanged( iActivePlayer, iPrevActivePlayer )

	-- Remove all the UI notifications.  The new player will rebroadcast any persistent ones from their last turn	
	for thisID, thisType in pairs(g_ActiveNotifications) do
		RemoveNotificationID(thisID);
	end

end
Events.GameplaySetActivePlayer.Add(OnNotificationPanelActivePlayerChanged);

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnNotificationsActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	UI.RebroadcastNotifications();
	ProcessStackSizes();
end
Events.GameplaySetActivePlayer.Add(OnNotificationsActivePlayerChanged);
----------------------------------------------------------------
--OnClearNotification
function OnClearNotification(notificationType)
	for thisID, thisType in pairs(g_ActiveNotifications) do
		if thisType == notificationType then
			RemoveNotificationID(thisID);
		end
	end
end
LuaEvents.UI_ClearNotification.Add(OnClearNotification)
----------------------------------------------------------------
UI.RebroadcastNotifications();
ProcessStackSizes();