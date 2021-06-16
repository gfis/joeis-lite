-- Patches for holom
-- @(#) $Id$
-- 2021-06-06, Georg Fischer; RH=75; RM oo 50.

UPDATE seq4 SET offset=0 WHERE aseqno IN ('A121989','A122022','A122050','A122752');
COMMIT;
