-- patches for solvetab
-- 2021-08-20, Georg Fischer

-- patch interval
UPDATE seq4 SET parm3 = '3', parm4 = '3.14' WHERE aseqno IN 
('A201575','A201577','A201580','A201581','A201584','A201586','A201588','A201590'
,'A201653','A201655','A201657','A201659','A201662','A201665','A201667','A201669'
,'A201671','A201673','A201675','A201677','A201679','A201681');

UPDATE seq4 SET offset1 =  0 WHERE aseqno IN ('A201285','A199188','A202351');
UPDATE seq4 SET offset1 = -1 WHERE aseqno IN ('A201289');
UPDATE seq4 SET offset1 =  1 WHERE aseqno IN ('A199174');

COMMIT;
