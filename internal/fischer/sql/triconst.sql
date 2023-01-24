--  Patches for CC=triconst
--  @(#) $Id$
--  2021-10-17: Georg Fischer
--
-- does not work? Why?
-- DELETE FROM seq4
--   WHERE parm1 LIKE 'new A%'                 AND SUBSTR(parm1, 5, 7) NOT IN (SELECT aseqno FROM joeis)
--      OR parm2 LIKE 'new A%'                 AND SUBSTR(parm2, 5, 7) NOT IN (SELECT aseqno FROM joeis)
--      OR parm3 LIKE '~~    ~~setPlus(new A%' AND SUBSTR(parm3,21, 7) NOT IN (SELECT aseqno FROM joeis);
-- --                  123456789012345678901
COMMIT;

