--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 										Filename, 				LoadType)
VALUES		('SND_LEADER_MUSIC_MC_VERCINGETORIX_PEACE', 	'VercingetorixPeace',	'DynamicResident'),
			('SND_LEADER_MUSIC_MC_VERCINGETORIX_WAR', 		'VercingetorixWar',		'DynamicResident'),
			('SND_LEADER_SPEECH_MC_VERCINGETORIX_DOM', 		'VercingetorixDoM',		'DynamicResident'),
			('SND_SOUND_MC_OATHSWORN', 						'Sound_MC_Oathsworn',	'DynamicResident');
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 									SoundType, 			MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_MC_VERCINGETORIX_PEACE', 	'SND_LEADER_MUSIC_MC_VERCINGETORIX_PEACE', 	'GAME_MUSIC', 		100, 		100, 		1, 		 0),
			('AS2D_LEADER_MUSIC_MC_VERCINGETORIX_WAR', 		'SND_LEADER_MUSIC_MC_VERCINGETORIX_WAR', 	'GAME_MUSIC', 		100, 		100, 		1, 		 0),
			('AS2D_DOM_SPEECH_MC_VERCINGETORIX_DOM', 		'SND_LEADER_SPEECH_MC_VERCINGETORIX_DOM',	'GAME_SPEECH', 		100, 		100, 		0, 		 0),
			('AS2D_SOUND_MC_OATHSWORN', 					'SND_SOUND_MC_OATHSWORN', 					'GAME_SFX', 		75, 		60, 		0, 		 0);
			
UPDATE Audio_2DSounds
	SET TaperSoundtrackVolume = 0.0
	WHERE ScriptID = 'AS2D_SOUND_MC_OATHSWORN';
--==========================================================================================================================		
--==========================================================================================================================		
