-- inbase2.sql 
-- @(#) $Id$
-- 2021-11-15, Georg Fischer; EFF=0
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;