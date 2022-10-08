-- @(#) $Id$
-- Patches for partran
-- 2022-10-02, Georg Fischer
SELECT aseqno, callcode, offset1, parm1, parm2 FROM seq4
                 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
