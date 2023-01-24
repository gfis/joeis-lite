--  Patches for CC=eulerxfm
--  @(#) $Id$
--  2020-08-17: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass NOT LIKE 'EulerTransform%');
COMMIT;
UPDATE seq4 s SET callcode = 'eulerxfm'
, parm8 = COALESCE((SELECT superclass FROM joeis j where s.aseqno = j.aseqno), 'null');
;
COMMIT;
