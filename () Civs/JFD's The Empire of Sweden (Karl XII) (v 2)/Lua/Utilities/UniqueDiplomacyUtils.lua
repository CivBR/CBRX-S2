-- ===================================================================================================================================================
-- This Lua file contains functions that are intended to allow for unique responses from AI-controlled leaders depending on what leader the player is.
-- Feel free to make use of this file in your own mods.
-- Thanks to JFD and Ryoga for their work on Unique Cultural Influence, which I based this off.
-- ===================================================================================================================================================

-- ===================================================================================================================================================
-- Response change functions
-- These alter the references in the Diplomacy_Responses table. They do not overwrite diplomacy lines directly.
-- They also don't assume that the ResponseType you've specified is valid. This is so you can account for mods that might add new response types, like
-- Civ IV Diplomatic Features.
-- ===================================================================================================================================================

-- Replaces a response in the Diplomacy_Responses table
-- It checks if the combination of LeaderType, ResponseType and Response exist in the Diplomacy_Responses table, and if there are any Game Text entries
-- in the current locale for the new response. If one of those checks fails, nothing is changed.
function ChangeDiplomacyResponse(leaderType, targetResponseType, targetResponse, newResponse, bias)
	--print("Currently changing " .. leaderType .. "'s " .. targetResponseType .. " with Response " .. targetResponse .. " to use " .. newResponse .. "...");
	if GameInfoTypes[leaderType] then
		local response;
		for _ in DB.Query("SELECT Response FROM Diplomacy_Responses WHERE LeaderType = '" ..leaderType.. "' AND ResponseType = '" ..targetResponseType .. "' AND Response= '" .. targetResponse .. "'") do response = _.Response end
		if response then
			--print(targetResponse .. " exists; now changing it to the new response...");
			local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
			--print("Current locale is " .. locale .. ".");
			local text;
			--print("Querying with: SELECT Text FROM " ..locale .." WHERE Tag LIKE '" ..newResponse.."'");
			for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag LIKE '" ..newResponse.."'") do text = _.Text end
			if text then
				for _ in DB.Query("UPDATE Diplomacy_Responses SET Response = '" .. newResponse .. "', Bias = " .. bias .." WHERE LeaderType = '" ..leaderType.. "' AND ResponseType = '" ..targetResponseType .. "' AND Response= '" .. targetResponse .. "'") do end
				print(leaderType .. "'s " .. targetResponseType .. " with Response " .. targetResponse .. " changed to use " .. newResponse .. "!");
			else
				print(newResponse .. " does not refer to any Game Text entries in " .. locale .. ". No changes made.");		
			end
		else
			print(targetResponseType .. " with Response " .. targetResponse .. " doesn't exist for " .. leaderType .. ". No changes made.");
		end
	else
		print(leaderType .. " is not a valid leader. No changes made.");
	end
end

-- Adds a new response to a set of diplomacy responses. It will only add it if there are any Game Text entries in the current locale for the new response,
-- and the exact response you're trying to add doesn't already exist. If either of those checks fail, nothing is changed.
function AddDiplomacyResponse(leaderType, targetResponseType, newResponse, bias)
	--print ("Currently adding Response " .. targetResponse .. " to " .. leaderType .. "'s " .. targetResponseType .. "...");
	if GameInfoTypes[leaderType] then
		local response;
		for _ in DB.Query("SELECT Response FROM Diplomacy_Responses WHERE LeaderType = '" ..leaderType.. "' AND ResponseType = '" ..targetResponseType .. "' AND Response= '" .. newResponse .. "'") do response = _.Response end
		if response == nil then
			local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
			--print("Current locale is " .. locale .. ".");
			local text;
			--print("Querying with: SELECT Text FROM " ..locale .." WHERE Tag LIKE '" ..newResponse.."'");
			for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag LIKE '" .. newResponse .. "'") do text = _.Text end
			if text and GameInfoTypes[leaderType] then
				for _ in DB.Query("INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('" .. leaderType .. "','" .. targetResponseType.. "','" .. newResponse .. "'," .. bias .. ")") do end
				print(leaderType .. "'s " .. targetResponseType .. " with Response " .. newResponse .. " added!");
			else
				print(newResponse .. " does not refer to any Game Text entries in " .. locale .. ". No changes made.");		
			end
		else
			print(leaderType .. "'s " .. targetResponseType .. " with Response " .. newResponse .. " already exists. No changes made.");
		end	
	else
		print(leaderType .. " is not a valid leader. No changes made.");
	end
end

-- Removes an existing response. Since a delete statement won't fail by itself if the response doesn't exist, I added a check for the response first for
-- debugging purposes.
function RemoveDiplomacyResponse(leaderType, targetResponseType, targetResponse)
	--print("Currently removing " .. leaderType .. "'s " .. targetResponseType .. " with Response " .. targetResponse .. "...");
	local response;
	for _ in DB.Query("SELECT Response FROM Diplomacy_Responses WHERE LeaderType = '" ..leaderType.. "' AND ResponseType = '" ..targetResponseType .. "' AND Response= '" .. targetResponse .. "'") do response = _.Response end
	if response then
		for _ in DB.Query("DELETE FROM Diplomacy_Responses WHERE LeaderType = '" ..leaderType.. "' AND ResponseType = '" ..targetResponseType .. "' AND Response= '" .. targetResponse .. "'") do end
		print(leaderType .. "'s " .. targetResponseType .. " with Response " .. targetResponse .. " deleted!");
	else
		print(targetResponseType .. " with Response " .. targetResponse .. " doesn't exist for " .. leaderType .. ". No changes made.");
	end
end

-- ===============================================================================================
-- Line change functions
-- These alter Game Text entries directly (i.e. the Language_??_?? entries).
-- Also, these automatically escape apostrophes in the line to avoid errors while parsing the SQL.
-- ===============================================================================================

-- (technically, you could use these to alter Game Text entries not related to diplomacy. I won't stop you if you want to repurpose the code for that!)

-- This function replaces a specific diplomacy line with another from the current locale. It will fail if either the target entry or the new entry do not
-- exist in the current locale. 
-- Please remember that you will lose the line you're replacing, so bear that in mind if you need it later.
function ChangeDiplomacyGameText(targetText, newText)
	--print("Currently changing " .. targetText .. " to " .. newText .. "...");
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	--print("Current locale is " .. locale .. ".");
	local targetTextTest;
	for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. targetText .. "'") do targetTextTest = _.Text end
	if targetTextTest then
		--print(targetText .. " exists in " .. locale .. "...");
		local newTextTest;
		for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. newText .. "'") do newTextTest = _.Text end
		if newTextTest then
			--print(newText .. " exists in " .. locale .. ". Now replacing " .. targetText .. "...");
			-- gsub escapes the apostrophes so that we don't get an error
			for _ in DB.Query("UPDATE " .. locale .. " SET Text = '" .. string.gsub(newTextTest, "'", "''") .."' WHERE Tag='" ..targetText .."'") do end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type );
			print(targetText .. " changed to " .. newText .. " in " .. locale .. "!");
		else
			print(newText .. " doesn't exist in " .. locale .. ". No changes made.");
		end
	else
		print(targetText .. " doesn't exist in " .. locale .. ". No changes made.");
	end
end

-- This function adds a specific diplomacy line from the current locale. It will fail if the target entry already exists in this locale.
-- Essentially it copies the entry. If you want to use a completely new string then use the AddDiplomacyGameTextFromString function.
function AddDiplomacyGameText(targetText, newText)
	--print("Currently adding " .. newText .. " as " .. targetText .. "...");
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	--print("Current locale is " .. locale .. ".");
	local targetTextTest;
	for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. targetText .. "'") do targetTextTest = _.Text end
	if targetTextTest == nil then
		--print(targetText .. " doesn't exist in " .. locale .. "...");
		local newTextTest;
		for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. newText .. "'") do newTextTest = _.Text end
		if newTextTest then
			--print(newText .. " exists in " .. locale .. ". Now copying it to " .. targetText .. "...");
			-- gsub escapes the apostrophes so that we don't get an error
			for _ in DB.Query("INSERT INTO " .. locale .. " (Text, Tag) VALUES ('" .. string.gsub(newTextTest, "'", "''") .."', '" ..targetText .."')") do end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type );
			print(newText .. " copied to " .. targetText .. " in " .. locale .. "!");
		else
			print(newText .. " doesn't exist in " .. locale .. ". No changes made.");
		end
	else
		print(targetText .. " already exists in " .. locale .. ". No changes made.");
	end
end

-- This function removes a specfiic diplomacy line from the current locale. It will fail if the target entry doesn't exist in the current locale.
-- Please remember that you will lose the line you're removing, so bear that in mind if you need it later.
function RemoveDiplomacyGameText(targetText)
	--print("Currently removing " .. targetText .. "...");
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	--print("Current locale is " .. locale .. ".");
	local targetTextTest;
	for _ in DB.Query("SELECT Text FROM " .. locale .. " WHERE Tag='" .. targetText .."'") do targetTextTest = _.Text end
	if targetTextTest then
		--print(targetText .. " exists in " .. locale .. "...");
		for _ in DB.Query("DELETE FROM " .. locale .. " WHERE Tag='" .. targetText .. "'") do end
		print(targetText .. " deleted from " .. locale .. "!");
	else
		print(targetText .. " doesn't exist in " .. locale .. ". No changes made.");
	end
end

-- This function replaces a specific diplomacy line from the specified locale with a string. It will fail if the target entry doesn't exist in the specified
-- locale. You need to specify the locale while calling this since it is impossible to get it from a string. It is assumed you will pass a valid one (it expects
-- it in the form "Language_??_??").
-- Please remember that you will lose the line you're replacing, so bear that in mind if you need it later.
function ChangeDiplomacyGameTextToString(targetText, newString, locale)
	--print("Currently changing " .. targetText .. " in " .. locale .. " to contain the string " .. newString .. "...");
	--local testLocale = Locale.LookupLanguage(string.gsub(locale, "Language_", ""), "TXT_KEY_MAIN_MENU");
	--	if testLocale then
	if type(newString) == "string" then
		local targetTextTest;
		for _ in DB.Query("SELECT Text FROM " .. locale .." WHERE Tag='" .. targetText .. "'") do targetTextTest = _.Text end
		if targetTextTest then
			--print(targetText .. " exists in " .. locale .. ". Now setting the new line...");
			-- gsub escapes the apostrophes so that we don't get an error
			for _ in DB.Query("UPDATE " .. locale .. " SET Text = '" .. string.gsub(newString, "'", "''") .."' WHERE Tag='" ..targetText .."'") do end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type );
			print(targetText .. " changed to " .. newString .. " in " .. locale .. "!");
		else
			print(targetText .. " doesn't exist in " .. locale .. ". No changes made.");
		end
	else
		print("The value of newString not a string. No changes made.");
	end
	--else
	--	print(locale .. " is invalid. No changes made.");
	--end
end

-- This function adds a specific diplomacy line from a string in the specified locale. It will fail if the target entry already exists in the specified
-- locale. You need to specify the locale while calling this since it is impossible to get it from a string. It is assumed you will pass a valid one (it expects
-- it in the form "Language_??_??").
function AddDiplomacyGameTextFromString(targetText, newString, locale)
	--print("Currently adding " .. newText .. " as " .. targetText .. " in " .. locale .. "...");
	--local testLocale = Locale.LookupLanguage(string.gsub(locale, "Language_", ""), "TXT_KEY_MAIN_MENU");
	--if testLocale then
	if type(newString) == "string" then
		local targetTextTest;
		for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. targetText .. "'") do targetTextTest = _.Text end
		if targetTextTest == nil then
			--print(targetText .. " doesn't exist in " .. locale .. "...");
			-- gsub escapes the apostrophes so that we don't get an error
			for _ in DB.Query("INSERT INTO " .. locale .. " (Text, Tag) VALUES ('" .. string.gsub(newString, "'", "''") .."', '" ..targetText .."')") do end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type );
			print(newString .. " added to " .. locale .. " in " .. targetText .. "!");
		else
			print(targetText .. " already exists in " .. locale .. ". No changes made.");
		end
	else
		print("The value of newString not a string. No changes made.");
	end
	--else
	--	print(locale .. " is invalid. No changes made.");
	--end
end