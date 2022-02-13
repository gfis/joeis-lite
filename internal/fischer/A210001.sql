-- A210001.sql
-- 2022-02-03, Georg Fischer

DELETE FROM seq4 WHERE aseqno IN ('A211800','A211631','A211632','A211633');
UPDATE seq4 SET parm3 = '(n,w,x,y,z) -> x*y*z == w*(y*z + x*z + x*y)' WHERE aseqno IN ('A212102');
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A212240');
COMMIT;
