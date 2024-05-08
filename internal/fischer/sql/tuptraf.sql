-- tuptraf.sql - amend offsets
-- @(#) $Id$
-- 2024-04-11, Georg Fischer

--                                                           1         2
--                   parm1                       p2 p3 456789012345678901234567890
-- A088922 tuptraf 0 (n, s) -> s[0].+(s[1]).-(2) "" new A000005(), new A110654()
UPDATE seq4 s
    SET s.parm3   = CASE WHEN callcode = 'tuptraf' 
    THEN
        CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)              >
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3, 20, 7)) 
             THEN 
                  s.parm3 || '.skip(' || (
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)              -
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3, 20, 7)) 
                  ) || ')'
             ELSE s.parm3 END
    ELSE s.parm3 END;
COMMIT;
UPDATE seq4 s
    SET s.parm3   = CASE WHEN callcode = 'tuptraf' 
    THEN
        CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno) >
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3,  5, 7))
             THEN 
                  SUBSTR(s.parm3, 1, 13) || '.skip(' || (
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno) -
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3,  5, 7))
                  ) || ')' || SUBSTR(s.parm3, 14, LENGTH(s.parm3) - 13)
             ELSE s.parm3 END
    ELSE s.parm3 END;
COMMIT;

--                            1         2
--                   p1 456789012345678901234567890
-- A088922 simtraf 0 new A000001()	(n, v) -> ...
UPDATE seq4 s
    SET s.parm3   = CASE WHEN callcode = 'simtraf' 
    THEN
        CASE WHEN (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)              >
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3,  5, 7)) 
             THEN 
                  s.parm3 || '.skip(' || (
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)              -
                  (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3,  5, 7)) 
                  ) || ')'
             ELSE s.parm3 END
    ELSE s.parm3 END;
COMMIT;
