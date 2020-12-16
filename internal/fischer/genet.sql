-- Patches for CC=genet
-- 2020-12-10, Georg Fischer
-- DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis WHERE superclass = 'EulerTransform');
DELETE FROM seq4 WHERE aseqno IN ('A000712','A006950','A015128','A026465','A029863','A298949');
UPDATE seq4 SET parm1 = '~~    ~~super($(OFFSET), 1, new long[0]);~~mSeqF = new A032177();' WHERE aseqno = 'A032178';
UPDATE seq4 SET parm4 = 'Z.THREE.pow(k).subtract(Z.TWO.pow(k))' WHERE aseqno IN ('A241759','A241766');
UPDATE seq4 SET parm1 = '~~    ~~super($(OFFSET), 1);~~mNextH = advanceH(0);' WHERE aseqno IN ('A035457');
COMMIT;
