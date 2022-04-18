-- Patches for compseqm
-- @(#) $Id$
-- 2022-04-14, Georg Fischer

-- 123456789012345
-- new A056000()
DELETE FROM seq4 WHERE SUBSTR(parm3, 5, 7) NOT IN (SELECT aseqno FROM joeis);
COMMIT;

