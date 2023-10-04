-- Patches for pairing
-- @(#) $Id$
-- 2023-10-04, Georg Fischer
UPDATE seq4 s SET parm3 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm2, 5, 7))
                , parm5 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm4, 5, 7));
UPDATE seq4 s SET parm2 = (CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm2, 5, 7)) = 0 THEN parm2 || '.skip(1)' ELSE parm2 END)
                , parm4 = (CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm4, 5, 7)) = 0 THEN parm4 || '.skip(1)' ELSE parm4 END);
COMMIT;

