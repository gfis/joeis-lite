-- A062044.sql
-- @(#) $Id$
-- 2022-04-16, Georg Fischer

DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno from JOEIS);
COMMIT;
