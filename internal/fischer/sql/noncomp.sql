--  Patches for callcode noncomp
--  @(#) $Id$
--  2021-08-12: always generate with select EX=xx
--  2021-07-24: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE aseqno NOT IN ('A308681'));
COMMIT;
