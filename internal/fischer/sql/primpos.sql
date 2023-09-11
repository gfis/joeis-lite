-- patch primpos.gen
-- @(#) $Id$
-- 2023-09-08, Georg Fischer
UPDATE seq4 s SET parm1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm2, 5, 7));
COMMIT;
DELETE FROM seq4 WHERE aseqno IN
('A000000'
);
COMMIT;
