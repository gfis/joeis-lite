--  Patches for CC=pastri(co)
--  @(#) $Id$
--  2021-10-01: Georg Fischer
--
-- Cf. prep_pascal.pl:
-- print        join("\t", $aseqno, $callcode, 0, $lseqno, $rseqno, $pseqno, $skip_parm, $compute_parm) . "\n";
-- # pastrico uses:                               PARM1    PARM2    PARM3    PARM4       PARM5
-- # pastri   uses:                               PARM1    PARM2             PARM4

-- Rename duplicate (dead) sequences into the valid ones:
UPDATE seq4 SET parm1 = 'A020725' WHERE parm1 = 'A104661';
UPDATE seq4 SET parm2 = 'A020725' WHERE parm2 = 'A104661';

UPDATE seq4 SET parm1 = 'A001519' WHERE parm1 = 'A011783';
UPDATE seq4 SET parm2 = 'A001519' WHERE parm2 = 'A011783';

UPDATE seq4 SET parm1 = 'A033484' WHERE parm1 = 'A099018';
UPDATE seq4 SET parm2 = 'A033484' WHERE parm2 = 'A099018';

UPDATE seq4 SET parm1 = 'A004277' WHERE parm1 = 'A076032';
UPDATE seq4 SET parm2 = 'A004277' WHERE parm2 = 'A076032';
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

