--  Patches for CC=moderiv
--  @(#) $Id$
--  2020-07-25: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
