-- Patches for holon
-- @(#) $Id$
-- 2023-12-14, Georg Fischer
UPDATE seq4 s SET s.callcode = 'holon'
, s.parm2 = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST((CASE WHEN s.parm2 < 10 THEN s.parm2 ELSE 10 END) AS CHAR) || '}') FROM asdata d WHERE d.aseqno = s.aseqno); 
UPDATE seq4 SET parm2 = '0,1,0,3,2', parm3 = 3 WHERE aseqno = 'A078478';
UPDATE seq4 SET parm2 = '1,2,5' WHERE aseqno = 'A112951';
UPDATE seq4 SET parm2 = '1,27,925,35069,1406679,58491537' WHERE aseqno = 'A132059';
UPDATE seq4 SET parm3 = '-1' WHERE aseqno = 'A228178';
COMMIT;
