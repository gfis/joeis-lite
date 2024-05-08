-- dirix.sql
-- @(#) $Id$
-- 2024-03-29, Georg Fischer
DELETE FROM seq4 WHERE SUBSTR(parm1, 5, 7) NOT IN (SELECT aseqno FROM direct);
COMMIT;

