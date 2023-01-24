-- num1dig.sql
-- @(#) $Id$
-- 2021-04-26, Georg Fischer

UPDATE seq4 SET parm4 = 'super.next();' WHERE callcode = 'num1dis' 
  AND aseqno IN ('A079099','A079100','A079110','A079113','A079123','A079127','A079133','A079134','A079135','A079163','A079584');
UPDATE seq4 SET offset1 = 1 WHERE aseqno IN ('A097468','A097470');
COMMIT;
