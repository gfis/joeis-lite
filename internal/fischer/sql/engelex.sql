-- Patches for CC=engelex
-- 2020-11-22, Georg Fischer
-- normal:
DELETE FROM seq4 WHERE parm1 = 'VOID';
UPDATE seq4 SET parm3 = parm2;
UPDATE seq4 set parm2 = '';
-- special:
UPDATE seq4 set parm2 = '4096' WHERE aseqno IN ('A006275','A006276') ;
UPDATE seq4 set parm2 = '4096' WHERE aseqno IN ('A091831','A118242','A219506','A219507');
DELETE FROM seq4 WHERE aseqno IN ('A076303'); -- treat 40 x "2" especially
DELETE FROM seq4 WHERE aseqno IN ('A059193','A068377','A068379','A068380','A118239'); -- linear recurrences already there
COMMIT;
