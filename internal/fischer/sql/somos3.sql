-- @(#) $Id$
-- 2022-06-03, Georg Fischer 
UPDATE seq4 s SET s.parm3
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm1 - 1 AS CHAR) || '}')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
COMMIT;
