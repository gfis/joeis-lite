-- Patches for CC=engelex
-- 2020-11-22, Georg Fischer
DELETE FROM seq4 WHERE parm1 = 'VOID';
UPDATE seq4 SET parm3 = parm2;
UPDATE seq4 set parm2 = '';
UPDATE seq4 set parm2 = '65536' WHERE aseqno IN ('A006275','A006276') ;
UPDATE seq4 set parm2 = '65536' WHERE aseqno IN ('A091831','A118242','A219506','A219507');
UPDATE seq4 set parm2 =  '2048' WHERE aseqno IN ('A076303');
DELETE FROM seq4                WHERE aseqno IN ('A076303');
COMMIT;
