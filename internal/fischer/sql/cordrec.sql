-- @(#) $Id$
-- 2022-06-04, Georg Fischer
-- replace parm3 with the initial parm1 terms
UPDATE seq4 s SET s.parm3
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm1 - 1 AS CHAR) || '}')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
DELETE FROM seq4 WHERE aseqno IN 
('A079352'
,'A081090'
,'A133266'
,'A173329'
,'A217592'
,'A224550'
,'A255228'
,'A322567'
);
UPDATE seq4 s SET s.parm3 = '1,1,1,2' WHERE aseqno IN ('A064183');
UPDATE seq4 s SET s.parm3 = '1,1,3'   WHERE aseqno IN ('A329470');
UPDATE seq4 s SET s.name = (SELECT SUBSTR(n.name,1, 256) FROM asname n WHERE n.aseqno = s.aseqno);
COMMIT;
