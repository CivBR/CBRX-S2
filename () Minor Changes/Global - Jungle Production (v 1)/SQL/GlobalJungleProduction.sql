UPDATE BuildFeatures
  SET Production=(SELECT Production*3/4 FROM BuildFeatures WHERE FeatureType='FEATURE_FOREST' AND RemoveOnly=1)
  WHERE FeatureType='FEATURE_JUNGLE'
  AND (BuildType='BUILD_REMOVE_JUNGLE' OR
       BuildType IN (SELECT BuildType FROM BuildFeatures WHERE FeatureType='FEATURE_FOREST' AND Production > 0));
