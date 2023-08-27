-- trimirror.sql: patches for trimirror
-- @(#) $Id$
-- 2023-07-29, Georg Fischer: copied from trimirror.sql
--
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno IN ('A085880','A095715','A163235','A165194','A264391','A304042','A330240','A354487');
DELETE FROM seq4 WHERE parm1 IN (SELECT aseqno FROM joeis WHERE superclass LIKE 'Transpose%');
COMMIT;
