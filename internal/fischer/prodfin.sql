-- Patches for partcond
-- @(#) $Id$
-- 2020-09-12, Georg Fischer

-- UPDATE seq4 SET offset = 0 WHERE aseqno = 'A035562'; -- corrected in OEIS

-- DELETE FROM seq4 WHERE aseqno >= 'A035618' AND aseqno <= 'A035678'; -- keep A035679
-- DELETE FROM seq4 WHERE aseqno >= 'A035680' AND aseqno <= 'A035699';
-- DELETE FROM seq4 WHERE parm1  <> 'A035679';
