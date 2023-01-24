--  Patches for CC=sumlipo
--  @(#) $Id$
--  2020-08-05: Georg Fischer
--
-- temporarily deactivated for witab generation
-- ??? DELETE FROM seq4 WHERE parm5 = 'dist'; -- 'dist' does not work at the moment
-- ??? COMMIT;
-- ??? UPDATE seq4 s1 SET s1.parm1 = 
-- ???   ( SELECT MIN(s2.aseqno) 
-- ???     FROM seq4 s2 
-- ???     WHERE s1.parm1 = s2.parm1
-- ???       AND s1.parm2 = s2.parm2
-- ???       AND s1.parm3 = s2.parm3
-- ???       AND s1.parm4 = s2.parm4
-- ???   )
-- ???   , parm2 = 'Z.ONE'
-- ???   WHERE s1.callcode = 'sumlino';
-- ??? UPDATE seq4 SET parm2 = 'Z.ZERO' WHERE aseqno = 'A000534'; -- if it is ever generated (too slow)
-- ??? COMMIT;

-- 2021-08-18, for witab:
UPDATE seq4 s SET s.name = (SELECT n.name FROM asname n WHERE s.aseqno = n.aseqno);
COMMIT;
DELETE FROM seq4 WHERE aseqno IN ('A018820');
COMMIT;

