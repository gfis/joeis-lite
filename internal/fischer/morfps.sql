-- morfps.sql
-- 2021-05-27, Georg Fischer

DELETE FROM seq4 WHERE aseqno IN
    ('A106437','A119647','A120716','A176892','A191648','A305495','A305496','A317198','A318134','A320926','A320927');
COMMIT;
UPDATE seq4 set parm1 = '3' WHERE aseqno = 'A317203';
UPDATE seq4 set parm2 = '0->011MM00,1->011MM01,M->011MM0M' WHERE aseqno = 'A176416';
UPDATE seq4 set parm2 = '1->10,0->1M,M->1' WHERE aseqno = 'A317198';
UPDATE seq4 SET parm2 = '' WHERE aseqno IN ('A105258','A179542'); -- unanchored = triangle
COMMIT;
