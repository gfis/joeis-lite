-- Patches for holink
-- @(#) $Id$
-- 2020-10-26, Georg Fischer

UPDATE seq4 SET parm1='[[0],[-9],[9],[0],[0],[1],[-1]]'  WHERE aseqno = 'A309791';
UPDATE seq4 SET parm1='[[0],[1],[-3],[4],[-4],[3],[-1]]' WHERE aseqno = 'A192447';
UPDATE seq4 SET parm2='[1,2,6,8,10,18,20,28,68,88,108,188,200,208,288,688]' WHERE aseqno = 'A038619';
UPDATE seq4 SET parm2='[1,2,3,4,5,6,66]'                           WHERE aseqno = 'A069882';
UPDATE seq4 SET parm2='[1,2,3,4,5,10,15,20,25,50,100,200]'         WHERE aseqno = 'A282032';
UPDATE seq4 SET parm2='[4,19,23,25,29,31,33,35,39,41,43,45,49,51]'    WHERE aseqno = 'A296602';
UPDATE seq4 SET parm2='[1,1,3,2,15,33,35,59,63,97,99,139,143,193]' WHERE aseqno = 'A334559';
UPDATE seq4 SET parm2='[0,0,0,0,3,9,16]' WHERE aseqno = 'A334563';
UPDATE seq4 SET parm2='[1,2,4,8,12,18,23,28,32]' WHERE aseqno = 'A337120';

DELETE FROM seq4 WHERE aseqno IN  ('A056758','A101758','A108692','A117154','A117597','A117661'
    ,'A126772','A131621','A133058','A134720','A135619','A192336','A194768','A194769','A197908','A197909'
    ,'A247486','A249668','A289265','A289265','A324472','A333348','A336238','A337240','A337241','A337398'
    ,'A092634','A109303','A335247'
    ,'A065024','A197708'
    );
COMMIT;
