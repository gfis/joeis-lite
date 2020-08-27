--  Patches for CC=eulerasi
--  @(#) $Id$
--  2020-08-18: Georg Fischer
--
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis WHERE superclass NOT LIKE 'EulerTransform%');
COMMIT;
UPDATE seq4 s SET callcode = 'eulerasi'
, parm1 = (SELECT terms FROM asinfo i WHERE s.aseqno = i.aseqno)
, parm8 = COALESCE((SELECT superclass FROM joeis j where s.aseqno = j.aseqno), 'null');
;
COMMIT;
