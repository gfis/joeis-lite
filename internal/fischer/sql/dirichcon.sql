-- dirichcon.sql - Patches for dirichcon
-- @(#) $Id$
-- 2021-04-22, Georg Fischer
--
UPDATE seq4 SET parm5 = 0, callcode = 'dirichcop2' WHERE aseqno IN 
  ('A054617','A251662');
UPDATE seq4 SET parm5 = 1, callcode = 'dirichcop2' WHERE aseqno IN 
  ('A323765','A323766');
-- DELETE FROM seq4 WHERE aseqno IN ('A159046','A185291','A299149','A328484','A328721','A328851','A328876','A340774');
COMMIT;
