--  Patches for CC=tricons
--  @(#) $Id$
--  2021-10-01: Georg Fischer
--
-- Cf. prep_pascal.pl:
-- print        join("\t", $aseqno, $callcode, 0, $lseqno, $rseqno, $pseqno, $skip_parm, $compute_parm) . "\n";
-- # pastrico uses:                               PARM1    PARM2    PARM3    PARM4       PARM5
-- # pastri   uses:                               PARM1    PARM2             PARM4

UPDATE seq4 s SET parm1 = (SELECT rseqno FROM trepl t1 WHERE t1.aseqno = s.parm1) WHERE s.parm1 IN (SELECT aseqno FROM trepl t2 WHERE t2.aseqno = s.parm1);
UPDATE seq4 s SET parm2 = (SELECT rseqno FROM trepl t1 WHERE t1.aseqno = s.parm2) WHERE s.parm2 IN (SELECT aseqno FROM trepl t2 WHERE t2.aseqno = s.parm2);
COMMIT;

-- show the dependant ones not yet implemented in jOEIS
SELECT parm1 AS asn FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis)
UNION 
SELECT parm2 AS asn FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis)
ORDER BY 1;

-- DELETE those with dependencies not yet implemented in jOEIS
DELETE FROM seq4 
    WHERE (parm1 LIKE 'A______' AND parm1 NOT IN (SELECT aseqno FROM joeis))
       OR (parm2 LIKE 'A______' AND parm2 NOT IN (SELECT aseqno FROM joeis))
       OR (parm3 LIKE 'A______' AND parm3 NOT IN (SELECT aseqno FROM joeis));
COMMIT;

-- create instances: Annnnnn -> new Annnnnn()
UPDATE seq4 SET parm1 = 'new ' || parm1 || '()' WHERE parm1 LIKE 'A______';
UPDATE seq4 SET parm2 = 'new ' || parm2 || '()' WHERE parm2 LIKE 'A______';
UPDATE seq4 SET parm3 = 'new ' || parm3 || '()' WHERE parm3 LIKE 'A______';
COMMIT;

UPDATE seq4 SET parm5 = '~~    ~~return getA();', callcode = 'pastrico';
UPDATE seq4 SET parm4 = '~~    ~~skipRight(1);' WHERE aseqno IN ('A133109');
COMMIT;

DELETE FROM seq4 WHERE aseqno IN ('A110356','A282063'); -- too few terms

