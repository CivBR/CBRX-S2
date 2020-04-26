-- ============================================================================================================================================================
-- File structure taken from Typhlomence's Super Mario Brothers - The Koopa Trooper

-- Diplomacy Responses - converted from XML using Artisanix's XML to SQL converter
-- based off of the Diplomacy XML used in the Touhou - Eientei mod by Paul "Huitzil"  Durant.
--
-- LeaderType: The leader that will use this response
-- ResponseType: The type of response your text will be used for
-- Response: The reference to the text entry
-- Bias: How likely this response is to be used
--
-- Only one reference needs to exist for each type of response. The % sign indicates that multiple responses can be picked if they exist. This works
-- in game using a process similar to an SQL LIKE query, meaning that responses do not have to end with sequential numbers, or even a number at all.
-- Anything that fits the specified pattern will be used.
--
-- If you do not wish to have a unique line for a certain response type, simply omit the INSERT statement for that response type. Note that even if you do
-- define a unique line, the game will display the generic entries on occasion. To avoid this, define a very large bias like in this template.
-- ============================================================================================================================================================

-- When you first meet this AI player.
-- No generic statement - will appear blank if none is defined
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PG_BOLIVAR', 'RESPONSE_FIRST_GREETING', 'TXT_KEY_LEADER_PG_BOLIVAR_FIRSTGREETING%', 500);

-- When you've defeated this AI player through conquest.
-- No generic statement - will appear blank if none is defined
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PG_BOLIVAR', 'RESPONSE_DEFEATED', 'TXT_KEY_LEADER_PG_BOLIVAR_DEFEATED%', 500);

-- ============================================================================
-- Cultural Influence
-- ============================================================================
-- Player is influential on the AI (Our people are wearing your blue jeans...)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PG_BOLIVAR', 'RESPONSE_INFLUENTIAL_ON_AI', 'TXT_KEY_LEADER_PG_BOLIVAR_INFLUENTIAL_ON_AI%', 500);
-- AI is influential on the player
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PG_BOLIVAR', 'RESPONSE_INFLUENTIAL_ON_HUMAN', 'TXT_KEY_LEADER_PG_BOLIVAR_INFLUENTIAL_ON_HUMAN%', 500);

--==========================================================================================================================			
--==========================================================================================================================						
