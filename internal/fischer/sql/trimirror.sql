-- trimirror.sql: patches for trimirror
-- @(#) $Id$
-- 2021-10-31, Georg Fischer
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno IN ('A095715','A163235','A165194');
COMMIT;
