-- dirtraf.sql - select the DirectSequences
-- @(#) $Id$
-- 2024-02-02: patching of the initial terms
-- 2023-11-18, Georg Fischer
DELETE FROM seq4 WHERE SUBSTR(parm1, 5, 7) NOT IN (SELECT aseqno FROM direct);
UPDATE seq4 s 
SET s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)
  , s.parm3   = 'null'
  , s.parm4   = ''
  , s.parm5   = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm2, 5, 7))
  ; 
COMMIT;
UPDATE seq4 s 
SET s.callcode = (CASE WHEN s.offset1 >= s.parm5 THEN s.callcode ELSE 'dirtrali' END)
  , s.parm4    = (CASE WHEN s.offset1 >= s.parm5 THEN ''         ELSE 
    (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm5 - s.offset1 - 1 AS CHAR) || '}')
      FROM  asdata d
      WHERE d.aseqno = s.aseqno
    )
    END)
  ;
COMMIT;

