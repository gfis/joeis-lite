-- Patches for partsumm
-- @(#) $Id$
-- 2022-03-24, Georg Fischer

DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
