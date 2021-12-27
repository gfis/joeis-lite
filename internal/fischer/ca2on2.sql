--  Patches for CC=ca2on2
--  @(#) $Id$
--  2021-12-26: Georg Fischer
--
UPDATE seq4 s SET aseqno = 'A270222' WHERE aseqno IN ('A272022');
UPDATE seq4 s SET aseqno = 'A270218' WHERE aseqno IN ('A272218');
UPDATE seq4 s SET parm4 = COALESCE((SELECT superclass FROM joeis j WHERE s.aseqno = j.aseqno), 'nyi');
DELETE FROM seq4   WHERE aseqno IN ('A000000');
COMMIT;
