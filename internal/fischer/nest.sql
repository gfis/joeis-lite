-- Patches for CC=nest
-- 2020-12-18, Georg Fischer
DELETE FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM seq);
UPDATE seq4 SET parm3 = (SELECT offset1 FROM asinfo WHERE aseqno = parm1);
UPDATE seq4 SET parm4 = (SELECT offset1 FROM asinfo WHERE aseqno = parm2);
COMMIT;
