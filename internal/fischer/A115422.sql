-- A115422.sql 
-- @(#) $Id$
-- 2021-11-15, Georg Fischer; EFF=0
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A115793','A115795','A115819');
COMMIT;