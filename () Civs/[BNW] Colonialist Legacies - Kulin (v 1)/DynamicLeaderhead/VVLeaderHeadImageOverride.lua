-- VVLeaderHeadImageOverride
-- Author: Vicevirtuoso/bc1
-- DateCreated: 3/23/2015 3:24:03 PM
--------------------------------------------------------------

local tLeaderSceneFunctions = {}  --contains custom functions to fetch leaderscene textures, users may add these in manually

--Initialization: prevent duplicates of this script from loading
if not MapModData.g_VVLeaderHeadImageOverrideInit then MapModData.g_VVLeaderHeadImageOverrideInit = false end
if MapModData.g_VVLeaderHeadImageOverrideInit == true then 
	return
else
	MapModData.g_VVLeaderHeadImageOverrideInit = true
	LuaEvents.AddFunctionToLeaderSceneTable.Add(
	function(fFunc)
		tLeaderSceneFunctions[#tLeaderSceneFunctions + 1] = fFunc
		print("Function added to leaderscene table")
	end)
end



-- need to wait until game starts for LookUpControl( "/LeaderHeadRoot" ) to work
Events.LoadScreenClose.Add(
	function()
		MapModData.g_VVLeaderHeadImageOverrideInit = false

		local screenX, screenY = UIManager:GetScreenSizeVal()
		local contexts = {}
		local approaches = {
			[MajorCivApproachTypes.MAJOR_CIV_APPROACH_HOSTILE]	= "VV_LeaderSceneOverrideHostile",
			[MajorCivApproachTypes.MAJOR_CIV_APPROACH_GUARDED]	= "VV_LeaderSceneOverrideGuarded",
			[MajorCivApproachTypes.MAJOR_CIV_APPROACH_AFRAID]	= "VV_LeaderSceneOverrideAfraid",
			[MajorCivApproachTypes.MAJOR_CIV_APPROACH_FRIENDLY] = "VV_LeaderSceneOverrideFriendly",
			[MajorCivApproachTypes.MAJOR_CIV_APPROACH_NEUTRAL]	= "VV_LeaderSceneOverride"
		}

		-- hookup image instances at the root of each leaderhead context
		for _, context in pairs{ LookUpControl( "/LeaderHeadRoot" ), LookUpControl( "/LeaderHeadRoot/DiploTrade" ), LookUpControl( "/LeaderHeadRoot/DiscussionDialog" ) } do
			if context then
				local instance = {}
				ContextPtr:BuildInstanceForControlAtIndex( "Instance", instance, context, 0 )
				table.insert( contexts, {context,instance.Image, instance.Box} )
			end
		end

		Events.AILeaderMessage.Add(
			function( iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1 )

				--Multiplayer games don't use leaderscreens.
				--This is moved into this function now rather than at initialization, since the newest DLL Various Mod Components can change this value mid-game!
				if Game.IsNetworkMultiPlayer() then
					ContextPtr:SetHide(true)
				else
					local chosenTexture;

					--First, go through all functions in the tLeaderSceneFunctions table and see if we can get a leaderscene texture from them.
					if tLeaderSceneFunctions then
						for iKey, fFunc in ipairs(tLeaderSceneFunctions) do
							chosenTexture = fFunc(iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1)
							if chosenTexture ~= nil then break end  --the first function which returns a result will be the one used.
						end
					end

					if chosenTexture == nil and chosenTexture ~= "null" then   --need the ~= "null" check since when running as an MP modpack, null is actually returned as a string by the DB
						--Without any custom functions, the scene will be determined by the AI's attitude.
						local player = Players[iPlayer]
						local pActivePlayer = Players[Game:GetActivePlayer()]
						local playerLeaderInfo;
						local iApproach
						local bWar = false
						if player then
							playerLeaderInfo = GameInfo.Leaders[player:GetLeaderType()];
							iApproach = pActivePlayer:GetApproachTowardsUsGuess(iPlayer);
							bWar = Teams[pActivePlayer:GetTeam()]:IsAtWar(player:GetTeam())
						end

						if (playerLeaderInfo.VV_LeaderSceneOverrideDefeat and (player:IsAlive() == false)) then
							chosenTexture = playerLeaderInfo.VV_LeaderSceneOverrideDefeat
						elseif (playerLeaderInfo.VV_LeaderSceneOverrideWar and (bWar == true)) then
							chosenTexture = playerLeaderInfo.VV_LeaderSceneOverrideWar
						elseif (playerLeaderInfo.VV_LeaderSceneOverrideDenouncing and (player:IsDenouncingPlayer(Game:GetActivePlayer()))) then
							chosenTexture = playerLeaderInfo.VV_LeaderSceneOverrideDenouncing
						elseif (playerLeaderInfo[approaches[iApproach]]) then
							chosenTexture = playerLeaderInfo[approaches[iApproach]]
						end

					end

		--[[		-- test code
					local civ = GameInfo.Civilizations[ PreGame.GetCivilization( iPlayer ) ]
					chosenTexture = civ and civ.DawnOfManImage
					-- /test code ]]
					if chosenTexture and chosenTexture ~= "null" then print(chosenTexture) end

					-- find out which context is active
					local image
					local box
					for _, context in pairs( contexts ) do
						if not context[1]:IsHidden() then
							image = context[2]
							box = context[3]
							break
						end
					end
					-- set and resize image
					if image then
						if chosenTexture and chosenTexture ~= "null" then
							image:SetTextureAndResize( chosenTexture )
							local x, y = image:GetSizeVal()
							x, y = math.min(screenX, screenY*x/y), math.min(screenY, screenX*y/x)
							image:SetSizeVal( x, y )
						end
						image:SetHide( not (chosenTexture and chosenTexture ~= "null") )
					end
				
					-- hide black background box if no texture chosen
					if box then
						box:SetHide( not (chosenTexture and chosenTexture ~= "null") )
					end
				end
			end
		)

		-- unload testures from memory when leaving leader
		Events.LeavingLeaderViewMode.Add(
			function()
				for _, context in pairs( contexts ) do
					context[2]:SetHide(true) --added by VV to hopefully prevent the red screen flashing
					context[3]:SetHide(true)
					context[2]:UnloadTexture()
				end
			end
		)
	end
)
