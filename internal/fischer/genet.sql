-- Patches for CC=genet
-- 2020-12-10, Georg Fischer
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass = 'EulerTransform');
COMMIT;
