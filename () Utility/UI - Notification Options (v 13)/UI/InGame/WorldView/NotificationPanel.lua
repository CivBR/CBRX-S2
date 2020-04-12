print("This is the modded NotificationPanel from 'UI - Notification Options'")

-------------------------------------------------
-- Action Info Panel
-------------------------------------------------
include( "IconSupport" );
include( "InstanceManager" );

local g_ActiveNotifications = {};
local g_Instances = {};

local g_Notifications = nil;


-------------------------------------------------------------------------------
-- details for dynamically sizing the small notification stack
-------------------------------------------------------------------------------
local DIPLO_SIZE_GUESS = 120;
local _, screenY = UIManager:GetScreenSizeVal();
local _, offsetY = Controls.OuterStack:GetOffsetVal();
local g_SmallScrollMax = screenY - offsetY - DIPLO_SIZE_GUESS;



-------------------------------------------------
-------------------------------------------------
function GenericLeftClick( Id )
	UI.ActivateNotification( Id )
end


-------------------------------------------------
-------------------------------------------------
-- Right click to remove notification,
-- shift-right click to remove all similar notifications,
-- control-right click to disable subsequent similiar notifications.
function GenericRightClick ( Id )
  local bShift = UIManager:GetShift();
  local bControl = UIManager:GetControl();

  if (g_ActiveNotifications[Id] ~= nil) then
    local type = g_ActiveNotifications[Id]

    if (bControl) then
      LuaEvents.NotificationOptionsShow(type, false, true)
    elseif (bShift) then
      for i,_ in pairs(g_ActiveNotifications) do
        if (g_ActiveNotifications[i] == type) then
          UI.RemoveNotification(i)
        end
      end
    else
      UI.RemoveNotification(Id)
    end
  end
end


------------------------------------------------------------------------------------
-- set up the exceptions
------------------------------------------------------------------------------------
Controls["TechButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["TechButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["ProductionButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["ProductionButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["FreeTechButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["FreeTechButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["StealTechButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["StealTechButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["FreePolicyButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["FreePolicyButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["FreeGreatPersonButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["FreeGreatPersonButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["FoundPantheonButton"]:RegisterCallback(Mouse.eLClick, GenericLeftClick);
Controls["FoundReligionButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["EnhanceReligionButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["AddReformationBeliefButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["LeagueCallForProposalsButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["ChooseArchaeologyButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["LeagueCallForVotesButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);
Controls["ChooseIdeologyButton"]:RegisterCallback(Mouse.eRClick, GenericRightClick);

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

function OnNotificationOptionsChanged()
  g_Notifications = {}
  LuaEvents.NotificationOptionsGet(g_Notifications)

	for i,_ in pairs(g_ActiveNotifications) do
		RemoveNotificationID(i)
	end

  UI.RebroadcastNotifications()
  ProcessStackSizes()
end
LuaEvents.NotificationOptionsChanged.Add(OnNotificationOptionsChanged)

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--- Actual new notification entry point
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-------------------------------------------------
-------------------------------------------------
function OnNotificationAdded( Id, type, toolTip, strSummary, iGameValue, iExtraGameData, ePlayer )
	if(g_ActiveNotifications[ Id ] ~= nil) then
        return;
    end

    if (g_Notifications == nil) then
      g_Notifications = {}
      LuaEvents.NotificationOptionsGet(g_Notifications)
    end

    local notification = g_Notifications[type]
    local name = (notification ~= nil) and notification.item or "Generic";

    if (notification == nil or notification.show == false) then
      -- print(string.format("No notification wanted for %i %s", type, name))
      return
    elseif (notification.callback ~= nil) then
      -- print(string.format("Notification callback for %i %s", type, name))
      local cbData = {
        parent   = Controls.SmallStack,  -- RO
        id       = Id,  -- RO
        sText    = toolTip,  -- RW
        sHeading = strSummary,  -- RW
        iExtra1  = iGameValue,  -- RO
        iExtra2  = iExtraGameData  -- RO
      }
      notification.callback(cbData)

      if (cbData.instance ~= nil) then
        -- print(string.format("  received an instance"))
        g_Instances[Id] = cbData.instance;

        local button = cbData.instance[name .. "Button"]
        local root   = cbData.instance[name .. "Container"]

        if (cbData.sHeading ~= nil) then
          cbData.instance.FingerTitle:SetText(cbData.sHeading)
        end
        root:BranchResetAnimation()
    
        button:SetHide( false )
        button:SetVoid1( Id )
        button:RegisterCallback( Mouse.eRClick, GenericRightClick )
        if (cbData.sText ~= nil) then
          button:SetToolTipString(cbData.sText);
        end
    
        g_ActiveNotifications[ Id ] = type;
        ProcessStackSizes();
      end

      return
    end
       
    local button;
    local text;
    local bg;
    local fingerTitle;
    local root;
        
    if( name == "Production" or
        name == "Tech" or
        name == "FreeTech" or
        name == "StealTech" or
        name == "FreePolicy" or
		name == "FreeGreatPerson" or
		name == "FoundPantheon" or
		name == "FoundReligion" or
		name == "EnhanceReligion" or
		name == "AddReformationBelief" or
		name == "LeagueCallForProposals" or
		name == "ChooseArchaeology" or
		name == "LeagueCallForVotes" or
		name == "ChooseIdeology") then
        
        button = Controls[name .. "Button"];
        text = Controls[name .. "Text"];
        bg = Controls[name .. "BG"];
        
    else
        if(name == nil) then
            print( "Unknown Notification, Adding generic " .. Id );
            name = "Generic";
        end

        local instance = {};
        ContextPtr:BuildInstanceForControl( name .. "Item", instance, Controls.SmallStack );
        g_Instances[ Id ] = instance;
        
        button = instance[ name .. "Button" ];
        text   = instance[ name .. "Text" ];
        root   = instance[ name .. "Container" ];
        
        
        instance.FingerTitle:SetText( strSummary );
        root:BranchResetAnimation();
        
		if type == NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER
		or type == NotificationTypes.NOTIFICATION_WONDER_COMPLETED
		or type == NotificationTypes.NOTIFICATION_WONDER_BEATEN then
			if iGameValue ~= -1 then
				local portraitIndex = GameInfo.Buildings[iGameValue].PortraitIndex;
				if portraitIndex ~= -1 then
					IconHookup( portraitIndex, 80, GameInfo.Buildings[iGameValue].IconAtlas, instance.WonderConstructedAlphaAnim );				
				end
			end
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.WonderSmallCivFrame:SetHide(false);				
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.WonderSmallCivFrame:SetHide(true);				
			end
		elseif type == NotificationTypes.NOTIFICATION_PROJECT_COMPLETED then
			if iGameValue ~= -1 then
				local portraitIndex = GameInfo.Projects[iGameValue].PortraitIndex;
				if portraitIndex ~= -1 then
					IconHookup( portraitIndex, 80, GameInfo.Projects[iGameValue].IconAtlas, instance.ProjectConstructedAlphaAnim );				
				end
			end
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.ProjectSmallCivFrame:SetHide(false);				
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.ProjectSmallCivFrame:SetHide(true);				
			end
		elseif type == NotificationTypes.NOTIFICATION_DISCOVERED_LUXURY_RESOURCE 
		or type == NotificationTypes.NOTIFICATION_DISCOVERED_STRATEGIC_RESOURCE 
		or type == NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE 
		or type == NotificationTypes.NOTIFICATION_DEMAND_RESOURCE
		or type == NotificationTypes.NOTIFICATION_REQUEST_RESOURCE then
			local thisResourceInfo = GameInfo.Resources[iGameValue];
			local portraitIndex = thisResourceInfo.PortraitIndex;
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisResourceInfo.IconAtlas, instance.ResourceImage );				
			end
		elseif type == NotificationTypes.NOTIFICATION_EXPLORATION_RACE then
			local thisFeatureInfo = GameInfo.Features[iGameValue];
			local portraitIndex = thisFeatureInfo.PortraitIndex;
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisFeatureInfo.IconAtlas, instance.NaturalWonderImage );				
			end
		elseif type == NotificationTypes.NOTIFICATION_TECH_AWARD then
			local thisTechInfo = GameInfo.Technologies[iExtraGameData];
			local portraitIndex = thisTechInfo.PortraitIndex;
			if portraitIndex ~= -1 then
				IconHookup( portraitIndex, 80, thisTechInfo.IconAtlas, instance.TechAwardImage );				
			else
				instance.TechAwardImage:SetHide( true );
			end
		elseif type == NotificationTypes.NOTIFICATION_UNIT_PROMOTION
		or type == NotificationTypes.NOTIFICATION_UNIT_DIED 
		or type == NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER 			
		or type == NotificationTypes.NOTIFICATION_ENEMY_IN_TERRITORY
		or type == NotificationTypes.NOTIFICATION_REBELS then
			local thisUnitType = iGameValue;
			local thisUnitInfo = GameInfo.Units[thisUnitType];
			local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon(thisUnitType, ePlayer);
			if portraitOffset ~= -1 then
				IconHookup( portraitOffset, 80, portraitAtlas, instance.UnitImage );				
			end
		elseif type == NotificationTypes.NOTIFICATION_WAR_ACTIVE_PLAYER then
			local index = iGameValue;
			CivIconHookup( index, 80, instance.WarImage, instance.CivIconBG, instance.CivIconShadow, false, true ); 
		elseif type == NotificationTypes.NOTIFICATION_WAR then
			local index = iGameValue;
			CivIconHookup( index, 45, instance.War1Image, instance.Civ1IconBG, instance.Civ1IconShadow, false, true );
			local teamID = iExtraGameData;
			local team = Teams[teamID];
			index = team:GetLeaderID();
			CivIconHookup( index, 45, instance.War2Image, instance.Civ2IconBG, instance.Civ2IconShadow, false, true );
		elseif type == NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER then
			local index = iGameValue;
			CivIconHookup( index, 80, instance.PeaceImage, instance.CivIconBG, instance.CivIconShadow, false, true );
		elseif type == NotificationTypes.NOTIFICATION_PEACE then
			local index = iGameValue;
			CivIconHookup( index, 45, instance.Peace1Image, instance.Civ1IconBG, instance.Civ1IconShadow, false, true );
			
			local teamID = iExtraGameData;
			local team = Teams[teamID];
			index = team:GetLeaderID();
			CivIconHookup( index, 45, instance.Peace2Image, instance.Civ2IconBG, instance.Civ2IconShadow, false, true );
		elseif type == NotificationTypes.NOTIFICATION_GREAT_WORK_COMPLETED_ACTIVE_PLAYER then
			--if iGameValue ~= -1 then
				--local portraitIndex = GameInfo.Buildings[iGameValue].PortraitIndex;
				--if portraitIndex ~= -1 then
					--IconHookup( portraitIndex, 80, GameInfo.Buildings[iGameValue].IconAtlas, instance.WonderConstructedAlphaAnim );				
				--end
			--end
			if iExtraGameData ~= -1 then
				CivIconHookup( iExtraGameData, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.WonderSmallCivFrame:SetHide(false);				
			else
				CivIconHookup( 22, 45, instance.CivIcon, instance.CivIconBG, instance.CivIconShadow, false, true );
				instance.WonderSmallCivFrame:SetHide(true);				
			end
		end
       
    end
    
    button:SetHide( false );
    button:SetVoid1( Id );
    button:RegisterCallback( Mouse.eLClick, GenericLeftClick );
    button:RegisterCallback( Mouse.eRClick, GenericRightClick );
    if (UI.IsTouchScreenEnabled()) then
        button:RegisterCallback( Mouse.eLDblClick, GenericRightClick );
	end
    
    local strToolTip = toolTip;
    button:SetToolTipString(strToolTip);
    
       
    g_ActiveNotifications[ Id ] = type;
    
    ProcessStackSizes();

end
Events.NotificationAdded.Add( OnNotificationAdded );


-------------------------------------------------
-------------------------------------------------
function RemoveNotificationID( Id )

    if( g_ActiveNotifications[ Id ] == nil )
    then
        print( "Attempt to remove unknown Notification " .. tostring( Id ) );
        return;
    end

    local name = g_Notifications[g_ActiveNotifications[Id]].item;
    
    if( name == "Production" or
        name == "Tech" or
        name == "FreeTech" or
        name == "StealTech" or
        name == "FreePolicy" or
		name == "FreeGreatPerson" or
		name == "FoundPantheon" or
		name == "FoundReligion" or
		name == "EnhanceReligion" or
		name == "AddReformationBelief" or
		name == "LeagueCallForProposals" or
		name == "ChooseArchaeology" or
		name == "LeagueCallForVotes" or
		name == "ChooseIdeology")
    then
        Controls[ name .. "Button" ]:SetHide( true );
    else
     
        if( name == nil ) then
            name = "Generic";
        end
        
        local instance = g_Instances[ Id ];
        if( instance ~= nil ) then
			Controls.SmallStack:ReleaseChild( instance[ name .. "Container" ] );
		    g_Instances[ Id ] = nil;
		end
        
    end
    
	g_ActiveNotifications[ Id ] = nil;    
end

-------------------------------------------------
-------------------------------------------------
function NotificationRemoved( Id )

    --print( "removing Notification " .. Id .. " " .. tostring( g_ActiveNotifications[ Id ] ) .. " " .. tostring( g_NameTable[ g_ActiveNotifications[ Id ] ] ) );
        
	RemoveNotificationID( Id );	
    ProcessStackSizes();

end
Events.NotificationRemoved.Add( NotificationRemoved );

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


-------------------------------------------------
-------------------------------------------------
function ProcessStackSizes()

    Controls.BigStack:CalculateSize();
    local bigY = Controls.BigStack:GetSizeY();
    Controls.SmallScrollPanel:SetSizeY( g_SmallScrollMax - bigY );

    Controls.SmallStack:CalculateSize();
    Controls.SmallStack:ReprocessAnchoring();

	Controls.SmallScrollPanel:CalculateInternalSize();
    if( Controls.SmallScrollPanel:GetRatio() ~= 1 ) then
        Controls.SmallScrollPanel:SetOffsetVal( 20, 0 );
    else
        Controls.SmallScrollPanel:SetOffsetVal( 0, 0 );
    end
    
    Controls.OuterStack:CalculateSize();
    Controls.OuterStack:ReprocessAnchoring();	  
end

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnNotificationsActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	UI.RebroadcastNotifications();
	ProcessStackSizes();
end
Events.GameplaySetActivePlayer.Add(OnNotificationsActivePlayerChanged);


UI.RebroadcastNotifications();
ProcessStackSizes();