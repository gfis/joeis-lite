--  Patches for CC=invbinom
--  @(#) $Id$
--  2021-10-15: Georg Fischer
--
-- DELETE those with dependencies not yet implemented in jOEIS
DELETE FROM seq4 WHERE (parm1 NOT IN (SELECT aseqno FROM joeis));
UPDATE seq4 SET parm2 = 1 WHERE aseqno IN ('A006930');
COMMIT;
