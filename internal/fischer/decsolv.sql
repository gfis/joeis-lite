-- decsolv.sql - patches for decsolv
-- 2021-08-01, Georg Fischer
--
UPDATE seq4 SET parm2 = '.inverse()' WHERE aseqno IN ('A196503');
UPDATE seq4 SET parm3='0.0605', parm4='0.0630', offset=0 WHERE aseqno ='A260632';
COMMIT;
