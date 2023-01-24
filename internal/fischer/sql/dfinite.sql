-- @(#) $Id$
-- 2022-07-29, Georg Fischer
-- replace parm2 with the initial parm2 terms
UPDATE seq4 s SET s.parm2
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm2 AS CHAR) || '}')
     FROM asdata d
     WHERE d.aseqno = s.aseqno
  );
DELETE FROM seq4 WHERE aseqno IN
('A079352'
);
UPDATE seq4 s SET s.parm2 = '1,2,3,5,7,10'          WHERE aseqno IN ('A119565');
UPDATE seq4 s SET s.parm2 = '0,1,5,55'              WHERE aseqno IN ('A129440');
UPDATE seq4 s SET s.parm2 = '0,1,1,2'               WHERE aseqno IN ('A165902');
UPDATE seq4 s SET s.parm2 = '0,1,1,1,1,2'           WHERE aseqno IN ('A210098');
UPDATE seq4 s SET s.parm2 = '0,1,1,1,1,-1,2'        WHERE aseqno IN ('A242107');
UPDATE seq4 s SET s.parm2 = '1,0,1,2,-1,4,3,4,15'   WHERE aseqno IN ('A244373');
UPDATE seq4 s SET s.parm2 = '1,1,0,-1,-2,-1'        WHERE aseqno IN ('A275865');
UPDATE seq4 s SET s.name = (SELECT SUBSTR(n.name,1, 256) FROM asname n WHERE n.aseqno = s.aseqno);
COMMIT;
