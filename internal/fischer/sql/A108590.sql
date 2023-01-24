-- A108590.sql
-- @(#) $Id$
-- 2022-05-25, Georg Fischer
DELETE FROM seq4 WHERE SUBSTR(parm3, 5, 7) NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE SUBSTR(parm5, 5, 7) NOT IN (SELECT aseqno FROM joeis);
UPDATE seq4 SET parm2 = (SELECT offset1 FROM asinfo WHERE aseqno = SUBSTR(parm3, 5, 7));
UPDATE seq4 SET parm4 = (SELECT offset1 FROM asinfo WHERE aseqno = SUBSTR(parm5, 5, 7));
UPDATE seq4 s SET parm6 = (SELECT keyword FROM asinfo i WHERE i.aseqno = s.aseqno)
              || '-'   || (SELECT keyword FROM asinfo i WHERE i.aseqno = SUBSTR(parm5, 5, 7)
              || '-'   || (SELECT keyword FROM asinfo i WHERE i.aseqno = SUBSTR(parm3, 5, 7);
COMMIT;
