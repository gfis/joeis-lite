--  Patches for CC=caelem
--  @(#) $Id$
--  2021-12-10: Georg Fischer
--
UPDATE seq4 s SET parm2 = COALESCE((SELECT superclass FROM joeis j WHERE s.aseqno = j.aseqno), 'nyi');
COMMIT;
