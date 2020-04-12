function UpdateTopPanelWithSupply()
	if Controls.SupplyString ~= nil then
		Controls.SupplyString:SetHide(false)
		Controls.SupplyString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		Controls.SupplyString:SetText("[ICON_WAR]" .. Players[Game.GetActivePlayer()]:GetNumUnits() .. "/" .. Players[Game.GetActivePlayer()]:GetNumUnitsSupplied())
		Controls.SupplyString:SetToolTipString("This is your total Unit Supply. Click to go to the Military Overview to see a complete breakdown of your Supply.")
		local function OpenOverview()
			Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW } );
		end
		Controls.SupplyString:RegisterCallback( Mouse.eLClick, OpenOverview );
	end
end

Events.LoadScreenClose.Add(UpdateTopPanelWithSupply);
Events.SerialEventGameDataDirty.Add(UpdateTopPanelWithSupply);
Events.SerialEventTurnTimerDirty.Add(UpdateTopPanelWithSupply);
Events.SerialEventCityInfoDirty.Add(UpdateTopPanelWithSupply);