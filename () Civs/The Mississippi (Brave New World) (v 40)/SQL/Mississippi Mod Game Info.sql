---------------------------
--Atlas
---------------------------

INSERT INTO IconTextureAtlases 
		(Atlas, 									  IconSize, 	                         Filename, 	    IconsPerRow, 	IconsPerColumn)
VALUES	('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 				   256, 		 'MississippiModAtlas256.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 				   214, 		 'MississippiModAtlas214.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 				   128, 		 'MississippiModAtlas128.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 					80, 		  'MississippiModAtlas80.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 					64, 		  'MississippiModAtlas64.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 					45, 		  'MississippiModAtlas45.dds',				  8, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ATLAS', 					32, 		  'MississippiModAtlas32.dds',				  8, 				 1),
		
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 		   128, 	'MississippiModAtlasAlpha128.dds',				  1, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 			64, 	 'MississippiModAtlasAlpha64.dds',				  1, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 			48, 	 'MississippiModAtlasAlpha48.dds',				  1, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 			32, 	 'MississippiModAtlasAlpha32.dds',				  1, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 			24, 	 'MississippiModAtlasAlpha24.dds',				  1, 				 1),
		('MISSISSIPPI_MOD_TOMATEKH_ALPHA_ATLAS', 			16, 	 'MississippiModAtlasAlpha16.dds',				  1, 				 1),
	
		('MISSISSIPPI_MOD_TOMATEKH_UNIT_ALPHA_ATLAS', 		32,     'MississippianUnitAlphaAtlas.dds',				  1, 				 1);		
		
		/*
		('GARAMA_BUILD_ATLAS', 				        64, 	          'Garama_Build_64.dds',				  1, 				 1),
		('GARAMA_BUILD_ATLAS', 				        45, 	          'Garama_Build_45.dds',				  1, 				 1),
		('GARAMA_BUILD_GOLD_ATLAS', 			    64,          'Garama_Gold_Build_64.dds',				  1, 				 1),
		('GARAMA_BUILD_GOLD_ATLAS',			        45,          'Garama_Gold_Build_45.dds',				  1, 				 1);
		*/

---------------------------
--Audio
---------------------------

INSERT INTO Audio_Sounds 
			(SoundID, 															            Filename, 						LoadType)
VALUES		('SND_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_PEACE',				    'MississippianPeace', 			   'DynamicResident'),
			('SND_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_WAR', 				      'MississippianWar', 			   'DynamicResident');
			--('SND_DOM_SPEECH_MISSISSIPPI_MOD_TOMATEKH', 						  'MississippianDoM', 			   'DynamicResident');

INSERT INTO Audio_2DSounds 
			(ScriptID, 																									           SoundID, 				SoundType, 			MinVolume, 			MaxVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_PEACE', 				         'SND_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_PEACE', 	         'GAME_MUSIC', 	               48, 		           48, 		          1),
			('AS2D_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_WAR', 	                           'SND_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_WAR', 		     'GAME_MUSIC', 	               48, 		           48, 		          1);

INSERT INTO Audio_2DSounds 
			(ScriptID, 																									      SoundID, 				SoundType, 			 Looping,		MinVolume, 			MaxVolume)
VALUES		('AS2D_AMBIENCE_LEADER_MISSISSIPPI_MOD_TOMATEKH_AMBIENCE', 		                              'SND_AMBIENCE_ODA_AMBIENCE', 		       'GAME_SFX', 	               1,	           12, 		           12);
			--('AS2D_DOM_SPEECH_SND_LEADER_MUSIC_MISSISSIPPI_MOD_TOMATEKH_WAR', 		    'SND_DOM_SPEECH_MISSISSIPPI_MOD_TOMATEKH', 		    'GAME_SPEECH',           	   0,	           90, 		           90);