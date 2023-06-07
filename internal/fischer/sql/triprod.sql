--  Patches for CC=triprod
--  @(#) $Id$
--  2023-06-06: tripro3, skip-this; RH=77
--  2021-10-10: Georg Fischer
--
-- DELETE those with dependencies not yet implemented in jOEIS
DELETE FROM seq4 WHERE callcode = 'triprod' AND ((parm1 NOT IN (SELECT aseqno FROM joeis)) OR (parm2 NOT IN (SELECT aseqno FROM joeis)));
DELETE FROM seq4 WHERE callcode = 'tripro3' AND ((parm1 NOT IN (SELECT aseqno FROM joeis)) OR (parm2 NOT IN (SELECT aseqno FROM joeis)) OR (parm3 NOT IN (SELECT aseqno FROM joeis)));
COMMIT;
UPDATE seq4 s SET callcode  = 'triprov'   WHERE callcode = 'triprod' AND (SELECT i.keyword FROM asinfo i WHERE i.aseqno = s.parm2)  NOT LIKE '%tabl%';
COMMIT;
UPDATE seq4 s SET callcode  = 'triprov0'  WHERE callcode = 'triprov' AND (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.parm2) = 0;
UPDATE seq4 s SET callcode  = 'skip-this' WHERE (SELECT i.keyword FROM asinfo i WHERE i.aseqno = s.aseqno) NOT LIKE '%tabl%';
COMMIT;
DELETE FROM seq4 WHERE callcode = 'skip-this';
COMMIT;
