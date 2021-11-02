-- interleave.sql
-- 2021-11-02, Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
