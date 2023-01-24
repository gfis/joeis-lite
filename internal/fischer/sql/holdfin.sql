-- holdfin.sql
-- 2021-06-01, Georg Fischer
UPDATE seq4 SET parm2 = '0,0,0,0,0,0,0,0,1,12,92'           WHERE aseqno = 'A055022';
UPDATE seq4 SET parm2 = '0,0,0,0,0,0,0,0,0,0,2,54,717,6836' WHERE aseqno = 'A055024';
UPDATE seq4 SET offset1 = 0 WHERE aseqno = 'A230122';
COMMIT;
