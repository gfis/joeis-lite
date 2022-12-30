-- concatf.sql
-- @(#) $Id$
-- 2022-12-30, Georg Fischer
UPDATE seq4 s SET s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
UPDATE seq4 s SET s.parm3   = (CASE WHEN s.parm3 = '1' THEN '~~    ~~mSeq.next();' ELSE '' END);
COMMIT;
DELETE FROM seq4 WHERE aseqno IN ('A000000'
,'A160096'
);
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT j.aseqno FROM joeis j);
DELETE FROM seq4 WHERE callcode NOT IN ('concatb','concatf','concatn','concats','concatr');
--                                       both      first     next      single    reverse
COMMIT;