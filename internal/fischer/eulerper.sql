--  Patches for CC=eulerxfm
--  @(#) $Id$
--  2020-08-15: Georg Fischer
--
-- UPDATE seq4 SET parm3 = CASE
--   WHEN offset = 1 THEN 'next();'
--   WHEN offset = 2 THEN 'next(); next();'
--   WHEN offset = 3 THEN 'next(); next(); next();'
--   ELSE                 ''
--   END;

-- DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass = 'EulerTransform');
UPDATE seq4 s SET parm7 = COALESCE((SELECT superclass FROM joeis j where s.aseqno = j.aseqno), 'null');
UPDATE seq4 s SET parm2 = '0,-1,1,-1,1,0,0,-1,1,0,0,0,0,-1,2,-1,0,0,0,0,1,-1,0,0,1,-1,1,-1,0,0' WHERE aseqno = 'A094022';
DELETE FROM seq4 WHERE aseqno = 'A106481'; -- EUlerTransform is not valid
COMMIT;
