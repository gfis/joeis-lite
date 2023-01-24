--  Patches for CC=invbinom|binomtf
--  @(#) $Id$
--  2021-12-09: Georg Fischer
--
-- DELETE those with dependencies not yet implemented in jOEIS
DELETE FROM seq4 WHERE (parm1 NOT IN (SELECT aseqno FROM joeis));
UPDATE seq4 SET parm2 = 1 WHERE aseqno IN ('A006930','A196161','A307800');
UPDATE seq4 SET parm2 = 2 WHERE aseqno IN ('A071015');
UPDATE seq4 SET callcode = 'binomtf0' WHERE aseqno IN ('A081557','A081562');
UPDATE seq4 SET parm1 = 'A081557' WHERE aseqno IN ('A081558');
COMMIT;
