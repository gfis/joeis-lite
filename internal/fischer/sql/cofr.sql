--  Patches for target cofr
--  @(#) $Id$
--  2021-07-23: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno    IN (SELECT aseqno FROM joeis);
COMMIT;
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis WHERE superclass = 'DecimalExpansionSequence');
UPDATE seq4 SET parm1 = 'A010774' WHERE aseqno = 'A103922';
-- DELETE FROM seq4 WHERE aseqno = 'A053002';
COMMIT;
