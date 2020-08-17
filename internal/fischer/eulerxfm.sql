--  Patches for CC=eulerxfm
--  @(#) $Id$
--  2020-08-17: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass NOT LIKE 'EulerTransformSequence%');
COMMIT;
UPDATE seq4 s SET callcode = 'eulerxfm'
--, parm2 = CASE WHEN LENGTH(parm2) = 0 THEN 'new Z[0]' ELSE parm2 END
--, parm3 = CASE 
--              WHEN parm1 = 1 THEN 'new FiniteSequence('   || parm3 || ')' 
--              WHEN parm1 = 2 THEN 'new PeriodicSequence(' || parm3 || ')' 
--          END
, parm8 = COALESCE((SELECT superclass FROM joeis j where s.aseqno = j.aseqno), 'null');
;
COMMIT;
