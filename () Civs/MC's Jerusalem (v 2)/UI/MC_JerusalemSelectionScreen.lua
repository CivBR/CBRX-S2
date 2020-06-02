-- Enact Decisions Popup
--=======================================================================================================================

include("IconSupport")
include("InfoTooltipInclude")
include("InstanceManager")
include("MC_JerusalemKnightlyOrders.lua")
print("loaded")
print("Hello yes this is new UI version are you loading?")

-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end

--=======================================================================================================================
-- Globals
--=======================================================================================================================

local tValidOrders = {}
for k, v in ipairs(tKnightlyOrders) do
	if not v.Policy then
		table.insert(tValidOrders, v)
	end
end

function C15_RefreshOrders(pPlayer)
	tValidOrders = {}
	for k, v in ipairs(tKnightlyOrders) do
		if v.Policy and (not pPlayer:HasPolicy(v.Policy)) then
			break
		end
		table.insert(tValidOrders, v)
	end
	RefreshPanel()
end

LuaEvents.MC_Jerusalem_OrderRefresh.Add(C15_RefreshOrders)

local pKnightlyStack = InstanceManager:new("KnightlyInstance", "KnightlyButton", Controls.KnightlyStack)
local iScreenX, iScreenY = UIManager:GetScreenSizeVal()
local iPanelX = 230
local iNum = 1

while ((iScreenX - (iPanelX + 35)) > 100) and (iNum < #tValidOrders) do
	iPanelX = iPanelX + 235
	iNum = iNum + 1
end

Controls.KnightlyScrollPanel:SetSizeX(iPanelX)
Controls.KnightlyPanel:SetSizeX(iPanelX + 35)

local tInstances = {}
iSelected = math.ceil(#tValidOrders/2)
g_Dummy = nil
g_City = nil

function RefreshPanel_Minor()
	for iKey, pInstance in pairs(tInstances) do
		pInstance.TransparentOverlay:SetHide(iKey ~= iSelected)
	end

	Controls.CloseButton:SetDisabled(not(g_Dummy))
end

Controls.TrueCloseButton:RegisterCallback(Mouse.eLClick, function() 
	Controls.FullScreenOverlay:SetHide(true)
	LuaEvents.MC_Jerusalem_MCISRefresh()
	end
	)

function RefreshPanel()

	tInstances = {}
	pKnightlyStack:ResetInstances()

	local bFirst = true
	for iKey, tTable in ipairs(tValidOrders) do

		--print(tTable.Head)

		if bFirst then
			bFirst = false
		else
			-- Create Trim
			pKnightlyStack:BuildInstance()
			local pTrim = pKnightlyStack:GetInstance()
			pTrim.KnightlyButton:SetSizeVal(5,548)
			pTrim.KnightlyBanner:SetHide(true)		
			pTrim.VerticalTrim:SetHide(false)
		end

		--Create Banner
		pKnightlyStack:BuildInstance()
		local pInstance = pKnightlyStack:GetInstance()
		pInstance.KnightlyButton:SetSizeVal(230,548)
		pInstance.KnightlySplash:SetTexture(tTable.Banner)
		pInstance.KnightlyBanner:SetHide(false)
		pInstance.KnightlyButton:RegisterCallback(Mouse.eLClick,
			function()
				iSelected = iKey
				g_Dummy = tTable.Dummy
				RefreshPanel_Minor()
			end
		)
		pInstance.VerticalTrim:SetHide(true)
		
		IconHookup(tTable.IconIndex, 256, "MC_JERUSALEM_BANNERS_ATLAS", pInstance.Portrait)
		
		pInstance.TransparentOverlay:SetHide(iKey ~= iSelected)

		pInstance.KnightlyHead:LocalizeAndSetText(tTable.Head)
		if tTable.Head2 then
			pInstance.KnightlyHead2:LocalizeAndSetText(tTable.Head2)
		else
			pInstance.KnightlyHead2:SetHide(true)
		end

		pInstance.KnightlyBody:LocalizeAndSetText(tTable.Body)

		pInstance.UnitFrame:LocalizeAndSetToolTip(GetHelpTextForUnit(tTable.Unit, false))
		local tUnit = GameInfo.Units[tTable.Unit]
		IconHookup(tUnit.PortraitIndex, 64, tUnit.IconAtlas, pInstance.Unit)

		pInstance.BuildingFrame:LocalizeAndSetToolTip(GetHelpTextForBuilding(tTable.Building))
		local tBuilding = GameInfo.Buildings[tTable.Building]
		IconHookup(tBuilding.PortraitIndex, 64, tBuilding.IconAtlas, pInstance.Building)

		table.insert(tInstances, iKey, pInstance)
	end

	Controls.CloseButton:SetDisabled(not(g_Dummy))
	
	Controls.KnightlyStack:ReprocessAnchoring()
	Controls.KnightlyScrollPanel:CalculateInternalSize()
	Controls.KnightlyScrollBar:SetSizeX(Controls.KnightlyScrollPanel:GetSizeX() - 36)
end
RefreshPanel()

if Controls.KnightlyScrollPanel:GetRatio() == 1 then
	Controls.KnightlyPanel:SetSizeY(Controls.KnightlyPanel:GetSizeY() - 19)
	Controls.KnightlyStack:SetOffsetVal(0, 0)
end

Controls.CloseButton:RegisterCallback(Mouse.eLClick, function()
	--g_City:SetNumRealBuilding(g_Dummy, 1)
	C15_ChangeOrder(g_City, g_Dummy)
	g_Dummy = nil
	g_City = nil
	Controls.FullScreenOverlay:SetHide(true)
	LuaEvents.MC_Jerusalem_MCISRefresh()
end)
--=======================================================================================================================
-- Gameplay
--=======================================================================================================================
local iCiv = GameInfoTypes.CIVILIZATION_MC_JERUSALEM
local iCooldownCounter = GameInfoTypes["BUILDING_MC_JERUSALEM_COOLDOWN_COUNTER"]

function OnCity(iPlayer, iX, iY)

	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end

	local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()

	if pCity:IsHasBuilding(iCooldownCounter) then return end
	
	g_City = pCity
	g_Dummy = nil
	
	C15_RefreshOrders(pPlayer)

	if not (pPlayer:IsHuman()) then
		local iDummy = tValidOrders[GetRandom(1, #tValidOrders)].Dummy
		--pCity:SetNumRealBuilding(iDummy, 1)
		C15_ChangeOrder(pCity, iDummy)
		g_City = nil
		return
	end
	

	Controls.FullScreenOverlay:SetHide(false)

end

function C15_SendOrderNotification(playerID, iX, iY)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	if pPlayer:IsHuman() then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot then
			local pCity = pPlot:GetPlotCity()
			if pCity then
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("MC_JERUSALEM_ORDER_NOTE_BODY", pCity:GetName()), Locale.ConvertTextKey("MC_JERUSALEM_ORDER_NOTE_HEAD"), false, iX, iY)
			end
		end
	end
end

function C15_Jerusalem_AI(playerID)
	local pPlayer = Players[playerID]
	if not pPlayer:IsHuman() and pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iCiv then
		for pCity in pPlayer:Cities() do
			local bOrder = false
			for k, v in ipairs(tKnightlyOrders) do
				if pCity:IsHasBuilding(v.Dummy) then
					bOrder = true
					break
				end
			end
			if not bOrder then
				OnCity(playerID, pCity:GetX(), pCity:GetY())
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Jerusalem_AI)

GameEvents.PlayerCityFounded.Add(C15_SendOrderNotification)
GameEvents.CityCaptureComplete.Add(
function(iOldOwner, bIsCapital, iCityX, iCityY, iOwner, iPop, bConquest)
	C15_SendOrderNotification(iOwner, iCityX, iCityY)
end
)
LuaEvents.MC_Jerusalem_MCISOrders.Add(OnCity)
--=======================================================================================================================
--=======================================================================================================================