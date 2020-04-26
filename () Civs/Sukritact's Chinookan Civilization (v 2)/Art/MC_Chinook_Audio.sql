--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 										Filename, 						LoadType)
VALUES		('SND_LEADER_MUSIC_MC_COMCOMLY_PEACE',		 	'ChinookPeace',					'DynamicResident'),
			('SND_LEADER_MUSIC_MC_COMCOMLY_WAR', 			'ChinookWar', 					'DynamicResident'),
			('SND_DOM_SPEECH_MC_CHINOOK', 					'ChinookDoM',					'DynamicResident');			
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 										SoundType, 			MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_MC_COMCOMLY_PEACE', 		'SND_LEADER_MUSIC_MC_COMCOMLY_PEACE', 			'GAME_MUSIC', 		80, 		80, 		1, 		 0),
			('AS2D_LEADER_MUSIC_MC_COMCOMLY_WAR', 			'SND_LEADER_MUSIC_MC_COMCOMLY_WAR', 			'GAME_MUSIC', 		80, 		80, 		1,		 0),
			('AS2D_DOM_SPEECH_MC_CHINOOK', 					'SND_DOM_SPEECH_MC_CHINOOK',					'GAME_SPEECH', 		100, 		100, 		0, 		 0);
--==========================================================================================================================		
--==========================================================================================================================		
