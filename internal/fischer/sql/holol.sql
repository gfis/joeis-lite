-- Patches for holom
-- @(#) $Id$
-- 2022-08-15, Georg Fischer: repair OffsetInspector complaints

UPDATE seq4 s SET offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
COMMIT;
