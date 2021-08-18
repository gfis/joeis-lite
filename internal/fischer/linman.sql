-- Patches for linman
-- @(#) $Id$
-- 2021-08-18, Georg Fischer

UPDATE seq4 SET parm2 = '[1,' || SUBSTR(parm2, 2, LENGTH(parm2) - 1) WHERE aseqno
  IN ('A054886','A074764','A082398','A085801','A301421','A301424','A334930');
UPDATE seq4 SET parm2 = '[0,' || SUBSTR(parm2, 2, LENGTH(parm2) - 1) WHERE aseqno
  IN ('A093611','A116547','A155137','A204516','A220360','A224463','A227496','A227497','A259624','A259625','A272855');
UPDATE seq4 SET parm2 = '[' || SUBSTR(parm2, 3, LENGTH(parm2) - 2) WHERE aseqno
  IN ('A224463','A227496','A227497');
COMMIT;
