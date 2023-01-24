--  @(#) $Id$
--  2020-06-10: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN(SELECT aseqno from poeis);
COMMIT;
