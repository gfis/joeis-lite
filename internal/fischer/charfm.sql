--  Patches for CC=charf
--  @(#) $Id$
--  2022-12-02: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (select aseqno FROM joeis);
COMMIT;

