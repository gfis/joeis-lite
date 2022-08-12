-- @(#) $Id$
-- 2022-08-11 Georg Fischer
-- replace parm2 with the initial parm2 terms
--
UPDATE seq4 s SET s.parm2
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm2 AS CHAR) || '}')
     FROM asdata d
     WHERE d.aseqno = s.aseqno
  );
COMMIT;
UPDATE seq4 SET parm2 = '0,0,1,0,-1296' 			WHERE aseqno = 'A273631';
UPDATE seq4 SET parm2 = '1,2,11' 					WHERE aseqno = 'A343896';
UPDATE seq4 SET parm2 = '0,0,1,0,-1296' 			WHERE aseqno = 'A273631';
DELETE from seq4 WHERE aseqno IN
('A116408'
,'A144578'
,'A339935'
,'A343898'
);
COMMIT;
