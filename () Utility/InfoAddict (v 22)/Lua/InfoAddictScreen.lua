-- Lua Script1
-- Author: robk
-- DateCreated: 10/7/2010 10:35:53 PM
--------------------------------------------------------------

include("InfoAddictLib");
include("IconSupport");

logger:debug("Processing InfoAddictScreen");


-- Main function to select panels, called by the OnStuff() functions
-- below.

function PanelSelector(panel)

  logger:debug("Switching to " .. panel .. " panel");

  if (panel == "historical") then
    Controls.HistoricalSelectHighlight:SetHide(false);
    Controls.HistoricalPanel:SetHide(false);
  else
    Controls.HistoricalSelectHighlight:SetHide(true);
    Controls.HistoricalPanel:SetHide(true);
  end;

  if (panel == "relations") then
    Controls.CivRelationsSelectHighlight:SetHide(false);
    Controls.CivRelationsPanel:SetHide(false);
  else
    Controls.CivRelationsSelectHighlight:SetHide(true);
    Controls.CivRelationsPanel:SetHide(true);
  end;

  if (panel == "factbook") then
    Controls.FactBookSelectHighlight:SetHide(false);
    Controls.FactBookPanel:SetHide(false);
  else
    Controls.FactBookSelectHighlight:SetHide(true);
    Controls.FactBookPanel:SetHide(true);
  end;

  if (panel == "options") then
    Controls.OptionsSelectHighlight:SetHide(false);
    Controls.OptionsPanel:SetHide(false);
  else
    Controls.OptionsSelectHighlight:SetHide(true);
    Controls.OptionsPanel:SetHide(true);
  end;

end


-- Display the historical graph panel when the historical button
-- is selected.

function OnHistorical()
  PanelSelector("historical");    
end
Controls.HistoricalButton:RegisterCallback( Mouse.eLClick, OnHistorical );


-- Display the Civ relations graph panel when the civ relations button
-- is selected.

function OnCivRelations()
  PanelSelector("relations");    
end
Controls.CivRelationsButton:RegisterCallback( Mouse.eLClick, OnCivRelations );


-- Display the Factbook when the, you guessed it, FAACTBOOOK button
-- is selected.

function OnFactBook()
  PanelSelector("factbook");    
end
Controls.FactBookButton:RegisterCallback( Mouse.eLClick, OnFactBook );


-- I'm not sure what this ... oh, yeah, it displays the, um, options panel.

function OnOptions()
  PanelSelector("options");    
end
Controls.OptionsButton:RegisterCallback( Mouse.eLClick, OnOptions );


-- Close it down

function OnClose()
  UIManager:PopModal(ContextPtr);
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose);


-- InputHandler: let's hit ESC to close the window.

function InputHandler( uiMsg, wParam, lParam )
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
            OnClose();
            return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );


local oldCursor = 0;

function ShowHideHandler( bIsHide, bInitState )
	
  if (not bHide) then

    oldCursor = UIManager:SetUICursor(0);   -- remember the cursor state

    -- Modify the title if we're in cheat mode
    if (seeEveryone()) then
      Controls.TitleLabel:SetText("Info Addict: Cheat Mode");
    end;

    -- Set player icon at top of screen
	  CivIconHookup( Game.GetActivePlayer(), 64, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true );

  else
    UIManager:SetUICursor(oldCursor);  -- restore the cursor state
  end;

end
ContextPtr:SetShowHideHandler( ShowHideHandler );


-- Trigger the historical panel so that's the default when the panel
-- first pops up.

OnHistorical();
