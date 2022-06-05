-- @(#) $Id$
-- 2022-06-04, Georg Fischer
-- replace parm3 with the initial parm1 terms
UPDATE seq4 s SET s.parm3
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm1 - 1 AS CHAR) || '}')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
DELETE FROM seq4 WHERE aseqno IN 
( 'A079352'
, 'A081090'
, 'A133266'
, 'A173329'
, 'A322567'
);
COMMIT;
