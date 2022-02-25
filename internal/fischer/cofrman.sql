--  Patches for CC=cofrman
--  @(#) $Id$
--  2022-02-25: restrict to subclasses of DecimalExpansionSequence
--  2021-08-27: Georg Fischer
--
-- DELETE FROM seq4 WHERE callcode NOT IN ('cofr');
DELETE FROM seq4 WHERE parm1    NOT IN (SELECT aseqno FROM joeis WHERE superclass IN ('DecimalExpansionSequence'));
-- SELECT s.aseqno, s.callcode, s.offset, s.parm1, n.name FROM seq4 s, asname n WHERE s.parm1 = n.aseqno;
COMMIT;
