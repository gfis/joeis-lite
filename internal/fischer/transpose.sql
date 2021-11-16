-- transpose.sql
-- 2021-11-10, Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
