-- A211422.sql
-- 2022-02-02, Georg Fischer

DELETE FROM seq4 WHERE aseqno IN ('A211800','A211631','A211632','A211633');
UPDATE seq4 SET parm3 = '(n,w,x,y,z) -> x*y*z == w*(y*z + x*z + x*y)' WHERE aseqno IN ('A212102');
UPDATE seq4 SET parm3 = '(n,w,x,y,z) -> 4*x*y*z*n == w*(y*z*n + x*z*n + x*y*n + x*y*z)' WHERE aseqno IN ('A212256');
-- 4/w == 1/x + 1/y + 1/z + 1/n
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A212136');
COMMIT;
