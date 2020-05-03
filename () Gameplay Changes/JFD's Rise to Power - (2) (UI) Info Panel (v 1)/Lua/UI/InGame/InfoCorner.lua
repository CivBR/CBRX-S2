-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local maxIdx = 0;
maxIdx = maxIdx + 1
InfoCornerID["Civilization"] = maxIdx;
maxIdx = maxIdx + 1
InfoCornerID["Tech"] = maxIdx
maxIdx = maxIdx + 1
InfoCornerID["Units"] = maxIdx
maxIdx = maxIdx + 1
InfoCornerID["Cities"] = maxIdx
maxIdx = maxIdx + 1
if( InfoCornerID["Resources"] == nil ) then
    for index, value in pairs(InfoCornerID) do
		maxIdx = maxIdx + 1;
    end
    InfoCornerID["Resources"] = maxIdx;
	maxIdx = maxIdx + 1;
	InfoCornerID["GP"] = maxIdx;
else
    maxIdx = InfoCornerID.GP;
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
m_InfoData = {};
m_InfoData[ InfoCornerID.None ] = {
    ToolTip="TXT_KEY_CLOSE",
    Image="assets/UI/Art/Icons/MainOpen.dds",
    HL="assets/UI/Art/Icons/MainOpenHL.dds" };
	
m_InfoData[ InfoCornerID.Civilization ] = {
    ToolTip="TXT_KEY_IC_CIVILIZATION_INFO",
    Image="MainGovt.dds",
    HL="MainGovtHL.dds" };
	
m_InfoData[ InfoCornerID.Tech ] = {
    ToolTip="TXT_KEY_IC_RESEARCH",
    Image="assets/UI/Art/Icons/MainTechButton.dds",
    HL="assets/UI/Art/Icons/MainTechButtonHL.dds" };
    
m_InfoData[ InfoCornerID.Units ] = {
    ToolTip="TXT_KEY_IC_UNIT",
    Image="assets/UI/Art/Icons/MainUnitButton.dds",
    HL="assets/UI/Art/Icons/MainUnitButtonHL.dds" };
    
m_InfoData[ InfoCornerID.Cities ] = {
    ToolTip="TXT_KEY_IC_CITY",
    Image="assets/UI/Art/Icons/MainCityButton.dds",
    HL="assets/UI/Art/Icons/MainCityButtonHL.dds" };

m_InfoData[ InfoCornerID.Resources ] = {
    ToolTip="TXT_KEY_IC_RESOURCE",
	Image="assets/DLC/Shared/UI/Art/Icons/MainResourceButton.dds",
	HL="assets/DLC/Shared/UI/Art/Icons/MainResourceButtonHL.dds" };
	
m_InfoData[ InfoCornerID.GP ] = {
    ToolTip="TXT_KEY_IC_GP",
    Image="assets/DLC/Shared/UI/Art/Icons/MainGreatPersonButton.dds",
    HL="assets/DLC/Shared/UI/Art/Icons/MainGreatPersonButtonHL.dds" };

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnInfoButton( iInfoType )
    Events.OpenInfoCorner( iInfoType );
end
Controls.LeftPull:RegisterSelectionCallback( OnInfoButton );

local g_CurrentInfoCornerID = -1;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnOpenInfoCorner( iInfoType )
    if( iInfoType ~= InfoCornerID.Diplo ) then 
        Controls.PDButton:SetTexture( m_InfoData[iInfoType].Image );
        Controls.PDImage:SetTexture( m_InfoData[iInfoType].Image );
        Controls.PDAlpha:SetTexture( m_InfoData[iInfoType].HL );
    end
    
    g_CurrentInfoCornerID = iInfoType;
end
Events.OpenInfoCorner.Add( OnOpenInfoCorner );

local g_PerPlayerState = {};
----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnInfoCornerActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	
	-- Restore the state per player
	local bIsHidden = ContextPtr:IsHidden() == true;
	-- Save the state per player
	if (iPrevActivePlayer ~= -1) then
		g_PerPlayerState[ iPrevActivePlayer + 1 ] = g_CurrentInfoCornerID;
	end
	
	if (iActivePlayer ~= -1) then
		if (g_PerPlayerState[ iActivePlayer + 1 ] == nil or g_PerPlayerState[ iActivePlayer + 1 ] == -1) then
			Events.OpenInfoCorner( InfoCornerID.None );
		else
			local iWantInfoCorner = g_PerPlayerState[ iActivePlayer + 1 ];
			if ( iWantInfoCorner ~= g_CurrentInfoCornerID) then
				Events.OpenInfoCorner( iWantInfoCorner );
			end
		end
	end
end

Events.GameplaySetActivePlayer.Add(OnInfoCornerActivePlayerChanged);

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local controlTable;

for i = 0, maxIdx do
    local value = m_InfoData[i];

	if( value ~= nil ) then
		 controlTable = {};
        Controls.LeftPull:BuildEntry( "InstanceOne", controlTable );

        controlTable.Button:LocalizeAndSetToolTip( value.ToolTip );
		
		 if( i == InfoCornerID.None ) then
            controlTable.Button:SetTexture(  "assets/UI/Art/Icons/MainClose.dds" );
            controlTable.MOImage:SetTexture( "assets/UI/Art/Icons/MainClose.dds" );
            controlTable.MOAlpha:SetTexture( "assets/UI/Art/Icons/MainCloseHL.dds" );
        else
            controlTable.Button:SetTexture( value.Image );
            controlTable.MOImage:SetTexture( value.Image );
            controlTable.MOAlpha:SetTexture( value.HL );
        end
        controlTable.Button:SetVoid1( i );
	end
end
Controls.LeftPull:CalculateInternals();
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- local playerID = Game.GetActivePlayer()
-- local player = Players[playerID]
-- function UpdateData()
	-- if player:GetCapitalCity() then
		-- Controls.AdministratorsLabel:SetHide(false)
		-- Controls.AdministratorsLabel:LocalizeAndSetText("TXT_KEY_ADMINISTRATORS_PANEL_JFD_ADMINISTRATORS")
		-- Controls.AdministratorsIcons:SetHide(false)
		-- local adminText = ""
		-- local adminTT = Locale.ConvertTextKey("TXT_KEY_ADMINISTRATORS_PANEL_JFD_ADMINISTRATORS") .. "[NEWLINE]"
		-- local admins = {}
		-- local numAdmins = 0
		-- for resource in GameInfo.Resources("ResourceClassType = 'RESOURCECLASS_JFD_DECISION'") do
			-- local element = {};
			-- element.ID = resource.ID;
			-- element.Desc = Locale.ConvertTextKey( resource.Description );
			-- element.FontIcon = Locale.ConvertTextKey( resource.IconString );
			-- admins[numAdmins] = element;
			-- numAdmins = numAdmins + 1
		-- end
		-- table.sort(admins, function(a, b) return a.Desc < b.Desc end);
		-- for _, thisAdmin in pairs(admins) do
			-- local numAdmins =player:GetNumResourceAvailable(thisAdmin.ID, false)
			-- if numAdmins > 0 then
				-- adminText = adminText .. " " .. Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]{2_Num}[ENDCOLOR]{1_Icon}", thisAdmin.FontIcon, numAdmins)
				-- adminTT = adminTT .. "[NEWLINE]" .. Locale.ConvertTextKey("{1_Icon} {2_Desc}: [COLOR_POSITIVE_TEXT]{3_Num}[ENDCOLOR]", thisAdmin.FontIcon, thisAdmin.Desc, numAdmins)
			-- else
				-- adminText = adminText .. " " .. Locale.ConvertTextKey("{2_Num}{1_Icon}", thisAdmin.FontIcon, numAdmins)
				-- adminTT = adminTT .. "[NEWLINE]" .. Locale.ConvertTextKey("{1_Icon} {2_Desc}: {3_Num}", thisAdmin.FontIcon, thisAdmin.Desc, numAdmins)
			-- end
		-- end
		-- Controls.AdministratorsIcons:SetText(adminText)
		-- Controls.AdministratorsIcons:SetToolTipString(adminTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_ADMINISTRATORS_PANEL_JFD_ADMINISTRATORS_TT"))
	-- end
-- end

-- Register Events
--Events.SerialEventGameDataDirty.Add(OnInfoCornerDirty);
--Events.SerialEventTurnTimerDirty.Add(OnInfoCornerDirty);
--Events.SerialEventCityInfoDirty.Add(OnInfoCornerDirty);

-- Update data at initialization
-- UpdateData();
