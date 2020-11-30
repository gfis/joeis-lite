-- Patches for CC=rebase
-- 2020-11-30, Georg Fischer

DELETE FROM seq4                WHERE aseqno IN ('A061861','A120437','A121349','A144863','A257830');
-- UPDATE      seq4 SET offset = 0 WHERE aseqno IN ('A033044');
UPDATE      seq4 SET parm4 = parm2; -- parm1 is rseqno
COMMIT;
-- UPDATE seq4 s SET parm2 = parm3, parm3 = parm4 WHERE parm2 < parm3;
COMMIT;
UPDATE      seq4 s SET parm4 = (SELECT name FROM asname n WHERE n.aseqno = s.aseqno);
COMMIT;
