--  Patches for CC=possub
--  @(#) $Id$
--  2022-02-27: Georg Fischer, copied from cofrman.sql; *BF
--
DELETE FROM seq4 WHERE parm1    NOT IN (SELECT aseqno FROM joeis);
COMMIT;
