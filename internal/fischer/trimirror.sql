-- trimirror.sql: patches for trimirror
-- 2021-10-31, Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
