-- A069877.sql - remove nyi subsequences, and set skip parameter
-- @(#) $Id$
-- 2023-07-26, Georg Fischer
DELETE FROM seq4 WHERE SUBSTR(parm2, 5, 7) NOT IN (SELECT aseqno FROM joeis);
UPDATE seq4 s SET offset1 = (SELECT offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
COMMIT;
UPDATE seq4 s SET parm3   = offset1 - (SELECT offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(parm2, 5, 7));
COMMIT;
