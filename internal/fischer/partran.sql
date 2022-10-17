-- @(#) $Id$
-- Patches for partran
-- 2022-10-17, more corrections
-- 2022-10-02, Georg Fischer
SELECT aseqno, callcode, offset1, parm1, parm2 FROM seq4
                 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
UPDATE seq4 SET parm1 = 'A048298' WHERE aseqno = 'A073266';
UPDATE seq4 SET parm1 = 'A212804' WHERE aseqno = 'A105422'; 
UPDATE seq4 SET parm1 = 'A126869' WHERE aseqno = 'A111959'; 
UPDATE seq4 SET parm1 = 'A002865' WHERE aseqno = 'A128627'; 
UPDATE seq4 SET parm1 = 'A121262' WHERE aseqno = 'A156054'; 
UPDATE seq4 SET parm1 = 'A004148' WHERE aseqno = 'A162981'; -- n+1 
UPDATE seq4 SET parm1 = 'A329678' WHERE aseqno = 'A186332';
UPDATE seq4 SET parm1 = 'A001006' WHERE aseqno = 'A202710';
-- UPDATE seq4 SET parm1 = 'A003269' WHERE aseqno = 'A259074'; -- n+1
COMMIT;
-- UPDATE seq4 SET parm1 = 'A291148' WHERE aseqno = 'A337048'; -- n+1, negate()
UPDATE seq4 SET parm1 = 'A036987' WHERE aseqno = 'A073266';
UPDATE seq4 SET parm1 = 'A130716' WHERE aseqno = 'A078803';
COMMIT;
