-- diriprod.sql - Patches for diriprod
-- @(#) $Id$
-- 2020-09-02, Georg Fischer; RT=78

DELETE FROM seq4 WHERE aseqno IN ('A031363','A192006');
UPDATE seq4 a SET a.callcode = 'diripronz' WHERE a.name LIKE 'Nonzero%'; 
UPDATE seq4 a SET a.callcode = 'diriproin' WHERE a.name LIKE 'Indices%'; 

UPDATE seq4 a SET a.callcode = 'diriproin' WHERE a.aseqno in ('A035251', 'A035248', 'A035243','A035240'); 

-- determine the superclass for indices of nonzero ...
UPDATE seq4 a SET a.parm2 = COALESCE(
    ( SELECT r.aseqno FROM seq4 r 
      WHERE r.callcode LIKE 'diriprod%' AND a.parm1 = r.parm1 AND a.offset = r.offset
    ), '') 
    WHERE callcode = 'diriproin';

-- determine the superclass for nonzero ...
UPDATE seq4 a SET a.parm2 = COALESCE(
    ( SELECT r.aseqno FROM seq4 r 
      WHERE r.callcode LIKE 'diriprod%' AND a.parm1 = r.parm1 AND a.offset = r.offset
    ), '') 
    WHERE callcode = 'diripronz';
COMMIT;
-- delete if superclass was not found
DELETE FROM seq4 WHERE LENGTH(parm1) = 0;
COMMIT;


