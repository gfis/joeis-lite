-- patches for sigma0
-- 2021-06-28, Georg Fischer

DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
