--  Patches for CC=euleras
--  @(#) $Id$
--  2020-12-03: Georg Fischer
--
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis WHERE superclass IS NOT NULL);
COMMIT;
