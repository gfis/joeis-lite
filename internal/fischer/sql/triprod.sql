--  Patches for CC=triprod
--  @(#) $Id$
--  2021-10-10: Georg Fischer
--
-- DELETE those with dependencies not yet implemented in jOEIS
DELETE FROM seq4 
    WHERE (parm1 NOT IN (SELECT aseqno FROM joeis))
       OR (parm2 NOT IN (SELECT aseqno FROM joeis));
COMMIT;
