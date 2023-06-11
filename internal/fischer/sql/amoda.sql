--  Patches for CC=amoda
--  @(#) $Id$
--  2023-06-11: mSeqi.next() reversed
--  2022-12-07: Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
UPDATE seq4 s SET s.parm4   = CASE WHEN (SELECT offset1 FROM asinfo i WHERE s.parm1  = i.aseqno) > 0 THEN '~~    ~~mSeq2.next();' ELSE '' END
                , s.parm5   = CASE WHEN (SELECT offset1 FROM asinfo i WHERE s.parm2  = i.aseqno) > 0 THEN '~~    ~~mSeq1.next();' ELSE '' END
                , s.parm6   = CASE WHEN s.parm3 = 'pow' THEN '.intValue()' ELSE '' END;
UPDATE seq4 s SET s.offset1 = (SELECT offset1 FROM asinfo i WHERE s.aseqno = i.aseqno)
                ;
COMMIT;
DELETE FROM seq4 WHERE offset1 NOT IN ('0', '1', '2', '3');
COMMIT;

