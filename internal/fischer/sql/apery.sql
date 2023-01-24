-- @(#) $Id$
-- 2022-08-07 Georg Fischer
-- replace parm2 with the initial parm2 terms
UPDATE seq4 s SET s.parm2
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm2 - 1 AS CHAR) || '}')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
UPDATE seq4 s SET s.parm2 = '[1,8,88,1088]' WHERE aseqno IN ('A036917');
UPDATE seq4 s SET s.parm2 = '[2,6,54]'      WHERE aseqno IN ('A219692');
UPDATE seq4 s SET s.parm3 = 1               WHERE aseqno IN ('A279619');
COMMIT;
