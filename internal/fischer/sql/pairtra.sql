-- Align the offsets and possibly add initial terms for CC=pairtra
-- @(#) $Id$
-- 2023-10-21, Georg Fischer

-- parm1 -> u.offset1, parm2 -> v.offset1, parm3=Auuu, parm4=Avvv, parm5=lambda
UPDATE seq4 s SET 
  s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)
, s.parm1   = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3, 5, 7))
, s.parm2   = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm4, 5, 7))
, s.name    = s.parm6
  WHERE s.callcode LIKE 'pair%';
COMMIT;

-- parm6 -> 4 initial terms, parm7 -> max(offset1, u.offset1, v.offset1)
UPDATE seq4 s SET 
  s.parm6   = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){3}') FROM asdata d WHERE d.aseqno = s.aseqno) 
, s.parm7   = (CASE WHEN s.offset1 > s.parm1 THEN 
    CASE WHEN s.offset1 > s.parm2 THEN s.offset1 ELSE 
      CASE WHEN s.parm2 > s.parm1 THEN s.parm2 ELSE s.parm1 END 
    END 
    ELSE s.parm1 END)
  WHERE s.callcode LIKE 'pair%';
COMMIT;

UPDATE seq4 s SET
  s.parm6 =   (CASE
  WHEN s.offset1 < s.parm7 THEN ',' || REGEXP_SUBSTR(s.parm6, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm7 - s.offset1 - 1 AS CHAR) || '}') ELSE ''
  END)
, s.parm3 =   (CASE
  WHEN s.parm1   < s.parm7 THEN s.parm3 || '.skip(' || CAST(s.parm7 - s.parm1 AS CHAR) || ')' ELSE s.parm3
  END)
, s.parm4 =   (CASE
  WHEN s.parm2   < s.parm7 THEN s.parm4 || '.skip(' || CAST(s.parm7 - s.parm2 AS CHAR) || ')' ELSE s.parm4
  END)
  WHERE s.callcode LIKE 'pair%';
COMMIT;

