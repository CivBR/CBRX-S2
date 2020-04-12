-- Great Artists, Musicians and Writers are captured
UPDATE Units SET Capture=Class
  WHERE Class IN ('UNITCLASS_ARTIST', 'UNITCLASS_MUSICIAN', 'UNITCLASS_WRITER');
