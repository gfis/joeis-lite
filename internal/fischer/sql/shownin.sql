--  Patches for CC=shownin
--  @(#) $Id$
--  2020-06-27: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
