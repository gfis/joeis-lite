-- patches for ordtraf
-- @(#) $Id$
-- 2023-10-03, Georg Fischer

DELETE FROM seq4 WHERE SUBSTR(parm1, 5, 7) NOT IN (SELECT aseqno FROM joeis);
COMMIT;
UPDATE seq4 s SET parm2 = (SELECT i.offset1 FROM asinfo i WHERE s.aseqno = i.aseqno);
COMMIT;
