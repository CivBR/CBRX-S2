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
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_FIRST_GREETING', 'TXT_KEY_LEADER_PB_HONG_FIRSTGREETING%', 500);

-- When you've defeated this AI player through conquest.
-- No generic statement - will appear blank if none is defined
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DEFEATED', 'TXT_KEY_LEADER_PB_HONG_DEFEATED%', 500);

-- Trying to contact or trade with the AI too many times; "REPEAT" appears first, and then "TOO_MUCH" if you continue (regardless of AI feelings)
-- Repeatedly contacting the AI
-- AI has no strong feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_REPEAT', 'TXT_KEY_LEADER_PB_HONG_GREETING_REPEAT%', 500);
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_REPEAT', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_REPEAT%', 500);
-- You have contacted them for a fifth time
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_REPEAT_TOO_MUCH', 'TXT_KEY_LEADER_PB_HONG_GREETING_REPEAT_TOO_MUCH%', 500);
-- Repeatedly trying to trade with the AI
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_REPEAT_TRADE', 'TXT_KEY_LEADER_PB_HONG_REPEAT_TRADE%', 500);
-- You have tried for a fifth time (?)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_REPEAT_TRADE_TOO_MUCH', 'TXT_KEY_LEADER_PB_HONG_REPEAT_TRADE_TOO_MUCH%', 500);

-- ============================================================================
-- Greetings
-- ============================================================================
-- Generic greetings depending on how the AI feels about you
-- AI likes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_POLITE_HELLO', 'TXT_KEY_LEADER_PB_HONG_GREETING_POLITE_HELLO%', 500);
-- AI has no strong feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_NEUTRAL_HELLO', 'TXT_KEY_LEADER_PB_HONG_GREETING_NEUTRAL_HELLO%', 500);
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_HELLO', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_HELLO%', 500);

-- Greetings while at war
-- All other times
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_AT_WAR_HOSTILE', 'TXT_KEY_LEADER_PB_HONG_GREETING_AT_WAR_HOSTILE%', 500);

-- Situational greetings
-- You have a Declaration of Friendship with _
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_WORKING_WITH', 'TXT_KEY_LEADER_PB_HONG_GREETING_WORKING_WITH%', 500);
-- The human is at war
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_HUMAN_AT_WAR', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_HUMAN_AT_WAR%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HUMAN_AT_WAR', 'TXT_KEY_LEADER_PB_HONG_GREETING_HUMAN_AT_WAR%', 500);
-- The human has an aggressive military posture
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_AGGRESSIVE_MILITARY', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_AGGRESSIVE_MILITARY%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_AGGRESSIVE_MILITARY', 'TXT_KEY_LEADER_PB_HONG_GREETING_AGGRESSIVE_MILITARY%', 500);
-- The human is aggressively setting cities
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_AGGRESSIVE_EXPANSION', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_AGGRESSIVE_EXPANSION%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_AGGRESSIVE_EXPANSION', 'TXT_KEY_LEADER_PB_HONG_GREETING_AGGRESSIVE_EXPANSION%', 500);
-- The human is aggressively claiming plots
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_AGGRESSIVE_PLOT_BUYING', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_AGGRESSIVE_PLOT_BUYING%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_AGGRESSIVE_PLOT_BUYING', 'TXT_KEY_LEADER_PB_HONG_GREETING_AGGRESSIVE_PLOT_BUYING%', 500);
-- AI is praising your strong military
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_FRIENDLY_STRONG_MILITARY', 'TXT_KEY_LEADER_PB_HONG_GREETING_FRIENDLY_STRONG_MILITARY%', 500);
-- AI is praising your strong economy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_FRIENDLY_STRONG_ECONOMY', 'TXT_KEY_LEADER_PB_HONG_GREETING_FRIENDLY_STRONG_ECONOMY%', 500);
-- AI is mocking you for having fewer cities than them
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_HUMAN_FEW_CITIES', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_HUMAN_FEW_CITIES%', 500);
-- AI is mocking you for having a small military
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_HUMAN_SMALL_ARMY', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_HUMAN_SMALL_ARMY%', 500);
-- AI considers you to be a warmonger
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_GREETING_HOSTILE_HUMAN_IS_WARMONGER', 'TXT_KEY_LEADER_PB_HONG_GREETING_HOSTILE_HUMAN_IS_WARMONGER%', 500);

-- ============================================================================
-- Declarations of Friendship and Denouncing
-- ============================================================================
-- AI offers you a Declaration of Friendship
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_WORK_WITH_US', 'TXT_KEY_LEADER_PB_HONG_DEC_FRIENDSHIP%', 500);
-- AI isn't ready for a Declaration of Friendship yet
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_TOO_SOON_FOR_DOF', 'TXT_KEY_LEADER_PB_HONG_TOO_SOON_FOR_DOF%', 500);
-- AI, as your friend, wants you to denounce another civilization
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DOF_AI_DENOUNCE_REQUEST', 'TXT_KEY_LEADER_PB_HONG_DOF_AI_DENOUNCE_REQUEST%', 500);
-- AI, as your friend, wants you to declare war on another civilization (disabled in normal DLL according to whoward69)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DOF_AI_WAR_REQUEST', 'TXT_KEY_LEADER_PB_HONG_DOF_AI_WAR_REQUEST%', 500);
-- AI is denouncing you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_WORK_AGAINST_SOMEONE', 'TXT_KEY_LEADER_PB_HONG_DENOUNCE%', 500);
-- AI is responding to you denouncing them
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 'TXT_KEY_LEADER_PB_HONG_RESPONSE_TO_BEING_DENOUNCED%', 500);
-- AI contacting you after you befriend their friend
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DOFED_FRIEND', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DOFED_FRIEND%', 500);
-- AI contacting you after you befriend their enemy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DOFED_ENEMY', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DOFED_ENEMY%', 500);
-- AI contacting you after you denounce their friend
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DENOUNCED_FRIEND', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DENOUNCED_FRIEND%', 500);
-- AI contacting you after you denounce their enemy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DENOUNCED_ENEMY', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DENOUNCED_ENEMY%', 500);
-- AI contacting you after they befriend your friend
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DOF_SO_AI_DOF', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DOF_SO_AI_DOF%', 500);
-- AI contacting you after they denounce your enemy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DENOUNCE_SO_AI_DENOUNCE', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DENOUNCE_SO_AI_DENOUNCE%', 500);
-- AI contacting you after they denounce your friend
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DOF_SO_AI_DENOUNCE', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DOF_SO_AI_DENOUNCE%', 500);
-- AI contacting you after they befriend your enemy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HUMAN_DENOUNCE_SO_AI_DOF', 'TXT_KEY_LEADER_PB_HONG_HUMAN_DENOUNCE_SO_AI_DOF%', 500);

-- ============================================================================
-- AI warnings
-- ============================================================================
-- AI has noticed your military posture is aggressive
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_PB_HONG_HOSTILE_AGGRESSIVE_MILITARY_WARNING%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_PB_HONG_AGGRESSIVE_MILITARY_WARNING%', 500);

-- AI has noticed your aggressive settling
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_EXPANSION_SERIOUS_WARNING', 'TXT_KEY_LEADER_PB_HONG_EXPANSION_SERIOUS_WARNING%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_EXPANSION_WARNING', 'TXT_KEY_LEADER_PB_HONG_EXPANSION_WARNING%', 500);

-- AI has noticed your aggressive plot claiming
-- AI dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_PLOT_BUYING_SERIOUS_WARNING', 'TXT_KEY_LEADER_PB_HONG_PLOT_BUYING_SERIOUS_WARNING%', 500);
-- AI has no negative feelings
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_PLOT_BUYING_WARNING', 'TXT_KEY_LEADER_PB_HONG_PLOT_BUYING_WARNING%', 500);

-- ============================================================================
-- War requests
-- ============================================================================
-- AI wants you to go to war against a third party
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_COOP_WAR_REQUEST', 'TXT_KEY_LEADER_PB_HONG_COOP_WAR_REQUEST%', 500);

-- ============================================================================
-- Miscellanious comments
-- ============================================================================
-- You and the AI are competing for the same city states
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_MINOR_CIV_COMPETITION', 'TXT_KEY_LEADER_PB_HONG_MINOR_CIV_COMPETITION%', 500);

-- ============================================================================
-- Player requests
-- ============================================================================
-- You continue to ask for something that the AI is not interested in
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_REPEAT_NO', 'TXT_KEY_LEADER_PB_HONG_REPEAT_NO%', 500);
-- You ask the AI to not settle near you
-- AI agrees
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DONT_SETTLE_YES', 'TXT_KEY_LEADER_PB_HONG_DONT_SETTLE_YES%', 500);
-- AI doesn't agree
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DONT_SETTLE_NO', 'TXT_KEY_LEADER_PB_HONG_DONT_SETTLE_NO%', 500);

-- ============================================================================
-- Insults
-- ============================================================================
-- Generic insult if no others are picked
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_GENERIC', 'TXT_KEY_LEADER_PB_HONG_INSULT_GENERIC%', 500);
-- Your military is weaker than the global average
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_MILITARY', 'TXT_KEY_LEADER_PB_HONG_INSULT_MILITARY%', 500);
-- AI has nukes and you don't (Our words are backed with nuclear weapons!)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_NUKE', 'TXT_KEY_LEADER_PB_HONG_INSULT_NUKE%', 500);
-- You are being a bully to City States
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_BULLY', 'TXT_KEY_LEADER_PB_HONG_INSULT_BULLY%', 500);
-- Your empire is unhappy
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_UNHAPPINESS', 'TXT_KEY_LEADER_PB_HONG_INSULT_UNHAPPINESS%', 500);
-- AI has more cities than you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_CITIES', 'TXT_KEY_LEADER_PB_HONG_INSULT_CITIES%', 500);
-- AI has more population than you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_POPULATION', 'TXT_KEY_LEADER_PB_HONG_INSULT_POPULATION%', 500);
-- AI has generated more total culture than you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INSULT_CULTURE', 'TXT_KEY_LEADER_PB_HONG_INSULT_CULTURE%', 500);

-- ============================================================================
-- Player declares war on the AI
-- ============================================================================
-- Generic response
-- AI is similar in strength to the player
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_ATTACKED_HOSTILE', 'TXT_KEY_LEADER_PB_HONG_ATTACKED_HOSTILE%', 500);

-- ============================================================================
-- Trade
-- ============================================================================
-- AI is offering a trade because they want a luxury from you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_LUXURY_TRADE', 'TXT_KEY_LEADER_PB_HONG_LUXURY_TRADE%', 500);
-- AI wants you to open your borders
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_OPEN_BORDERS_OFFER', 'TXT_KEY_LEADER_PB_HONG_OPEN_BORDERS_OFFER%', 500);
-- AI wants more and dislikes you
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_TRADE_NEEDMORE_ANGRY', 'TXT_KEY_LEADER_PB_HONG_TRADE_NEEDMORE_ANGRY%', 500);
-- AI wants more and is neutral
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_TRADE_NEEDMORE_NEUTRAL', 'TXT_KEY_LEADER_PB_HONG_TRADE_NEEDMORE_NEUTRAL%', 500);
-- AI wants more and likes u :)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_TRADE_NEEDMORE_HAPPY', 'TXT_KEY_LEADER_PB_HONG_TRADE_NEEDMORE_HAPPY%', 500);

-- ============================================================================
-- AI declares war on the player
-- ============================================================================
-- Generic response
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DOW_GENERIC', 'TXT_KEY_LEADER_PB_HONG_DOW_GENERIC%', 500);
-- AI is in a land dispute with the player
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_DOW_LAND', 'TXT_KEY_LEADER_PB_HONG_DOW_LAND%', 500);
-- AI declares war after the player refuses a demand
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_WAR_DEMAND_REFUSED', 'TXT_KEY_LEADER_PB_HONG_WAR_DEMAND_REFUSED%', 500);

-- ============================================================================
-- Peace offers
-- ============================================================================
-- AI doesn't want to have peace
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_NO_PEACE', 'TXT_KEY_LEADER_PB_HONG_NO_PEACE%', 500);
-- Player asks for peace on the same turn war was declared - no peace!
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_TOO_SOON_NO_PEACE', 'TXT_KEY_LEADER_PB_HONG_TOO_SOON_NO_PEACE%', 500);

-- ============================================================================
-- Cultural Influence
-- ============================================================================
-- Player is influential on the AI (Our people are wearing your blue jeans...)
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INFLUENTIAL_ON_AI', 'TXT_KEY_LEADER_PB_HONG_INFLUENTIAL_ON_AI%', 500);
-- AI is influential on the player
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_PB_HONG', 'RESPONSE_INFLUENTIAL_ON_HUMAN', 'TXT_KEY_LEADER_PB_HONG_INFLUENTIAL_ON_HUMAN%', 500);

--==========================================================================================================================			
--==========================================================================================================================						
