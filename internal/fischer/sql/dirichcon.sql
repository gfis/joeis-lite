-- dirichcon.sql
-- @(#) $Id$
-- 2023-06-04: patch dirichinv0
-- 2023-04-24, Georg Fischer

-- A349612  dirichcon2  1   new A342001()   1   new A325126()   1   
--                          parm1               12345678        parm4
DELETE FROM seq4 WHERE SUBSTR(parm1, 5, 7) NOT IN (select aseqno FROM joeis);
DELETE FROM seq4 WHERE SUBSTR(parm3, 5, 7) NOT IN (select aseqno FROM joeis) AND s.callcode LIKE 'dirichc%';
COMMIT;
UPDATE seq4 s SET parm2 = (SELECT offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm1, 5, 7));
UPDATE seq4 s SET parm4 = (SELECT offset1 FROM asinfo i WHERE i.aseqno = SUBSTR(s.parm3, 5, 7) AND s.callcode LIKE 'dirichc%');
COMMIT;
UPDATE seq4 s set s.CALLCODE = 'dirichinv0' WHERE s.CALLCODE = 'dirichinv' AND s.parm2 = 0;
COMMIT;
