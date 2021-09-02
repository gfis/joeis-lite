--  @(#) $Id$
--  2021-09-01: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN ((SELECT aseqno from joeis) UNION (SELECT aseqno from poeis));
COMMIT;
