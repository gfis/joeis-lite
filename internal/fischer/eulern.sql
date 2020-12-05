--  Patches for CC=eulern
--  @(#) $Id$
--  2020-12-03: Georg Fischer
--
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE parm2 < aseqno;
UPDATE      seq4 s SET parm1 = '' WHERE aseqno IN ('A099065','A132220','A226313','A263914');
UPDATE      seq4 s SET parm3 = (SELECT offset1 FROM asinfo i WHERE s.parm2 = i.aseqno);
COMMIT;
