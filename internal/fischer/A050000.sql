-- A050000.sql 
-- @(#) $Id$
-- 2021-08-06, Georg Fischer
UPDATE seq4 SET parm2 = 'new A050100()' WHERE aseqno IN (          'A050102','A050103');
UPDATE seq4 SET parm2 = 'new A050112()' WHERE aseqno IN ('A050113','A050114','A050115');
COMMIT;