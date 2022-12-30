-- partsum2.sql
-- @(#) $Id$
-- 2022-12-25, Georg Fischer
UPDATE seq4 s SET s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)
UPDATE seq4 s SET s.parm2 = '~~    ~~mSeq.next();' WHERE s.aseqno NOT IN ('A000000'
,'A063966'
,'A064612'
,'A076517'
,'A108130'
,'A111712'
,'A113241'
,'A160096'
,'A161169'
,'A173530'
,'A174143'
,'A178689'
,'A275257'
,'A286272'
,'A291783'
,'A292300'
,'A304970'
,'A327235'
,'A329355'
,'A329356'
,'A330320'
,'A330570'
,'A349776'
,'A356042'
,'A356043'
,'A356125'
,'A356535'
);
COMMIT;
DELETE FROM seq4 WHERE aseqno IN ('A000000'
,'A160096'
,'A161169'
,'A275257'
);
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT j.aseqno FROM joeis j);
COMMIT;