-- A210000.sql
-- 2022-02-02, Georg Fischer

UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A211146');
UPDATE seq4 SET offset = 2 WHERE aseqno IN ('A055507');
COMMIT;
