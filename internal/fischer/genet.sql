-- Patches for CC=genet
-- 2020-12-10, Georg Fischer
-- DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass = 'EulerTransform');
DELETE FROM seq4 WHERE aseqno IN ('A000712','A006950','A015128','A029863');
COMMIT;
