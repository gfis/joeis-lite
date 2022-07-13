-- Patches for holom
-- @(#) $Id$
-- 2021-08-18: holom, patch inits[0]
-- 2021-06-06, Georg Fischer; RH=75; RM oo 50.

-- UPDATE seq4 SET offset1=0 WHERE aseqno IN ('A121989','A122022','A122050','A122752','A288954');
UPDATE seq4 SET parm2 = '[1,' || SUBSTR(parm2, 2, LENGTH(parm2) - 1) WHERE aseqno
  IN ('A054886','A074764','A082398','A085801','A155137','A334930');
UPDATE seq4 SET parm2 = '[0,' || SUBSTR(parm2, 2, LENGTH(parm2) - 1) WHERE aseqno
  IN ('A093611','A116547','A220360');
COMMIT;
