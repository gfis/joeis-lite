-- decsolv.sql - patches for decsolv
-- 2021-08-01, Georg Fischer
--
UPDATE seq4 SET parm2 = '.inverse()' WHERE aseqno IN ('A196503');
COMMIT;
