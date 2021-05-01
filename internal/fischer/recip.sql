-- recip.sql
-- 2021-05-01, Georg Fischer
UPDATE seq4 SET parm2 = 'new long[] {+1,-1,-1,-1,+1,+1,+1,+1,-1 }', parm3 = 'new long[] { -1,+1 }' WHERE aseqno IN ('A049184');
COMMIT;
