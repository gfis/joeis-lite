-- bincoef.sql
-- 2021-06-03, Georg Fischer
UPDATE seq4 SET parm2 = '0, 0, 0, 0, 1'           WHERE aseqno = 'A000332';
UPDATE seq4 SET parm2 = '0, 0, 0, 0, 0, 1' WHERE aseqno = 'A000389';
UPDATE seq4 SET offset = 9                 WHERE aseqno = 'A004351';
COMMIT;
