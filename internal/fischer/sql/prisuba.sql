--  Patches for CC=prisuba
--  @(#) $CC=prisuba
--  2023-02-14: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
UPDATE seq4 s SET s.parm3 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.parm1);
COMMIT;

