-- patch complem.gen
-- @(#) $Id$
-- 2023-09-11, Georg Fischer
UPDATE seq4 s SET s.parm2 = ', ' || CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm1, 5, 7)) = 1 THEN 'Z.ONE' ELSE 'Z.ZERO' END;
COMMIT;

