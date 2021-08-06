-- A049884.sql 
-- @(#) $Id$
-- 2021-08-06, Georg Fischer

UPDATE seq4 SET parm2 = '2*n - 2 - p1(n)' WHERE aseqno = 'A049971';
COMMIT;