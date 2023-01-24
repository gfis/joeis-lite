-- A067067.sql
-- @(#) $Id$
-- 2022-02-28, Georg Fischer
DELETE FROM seq4 WHERE SUBSTR(parm2, 5, 7) NOT IN (SELECT aseqno FROM joeis);
COMMIT;
