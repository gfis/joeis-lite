-- trafo.sql - patches for transforms
-- @(#) $Id$
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROm joeis);
COMMIT;
UPDATE seq4 s SET offset1 = (SELECT i.offset1 FROM asinfo WHERE i.aseqno = s.aseqno);
COMMIT;
