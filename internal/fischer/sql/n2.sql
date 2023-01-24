-- n2.sql
-- @(#) $Id$
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno    IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno IN ('A062739','A113631');
UPDATE seq4 s SET offset1 = (SELECT offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
COMMIT;
UPDATE seq4 SET callcode = 'n2add1' WHERE parm2 = '+1';
UPDATE seq4 SET callcode = 'n2sub1' WHERE parm2 = '-1';
UPDATE seq4 SET callcode = 'n2add1' WHERE parm2 = '0' AND offset1 = 1;
UPDATE seq4 SET callcode = 'n2add1' WHERE aseqno IN ('A105284','A113631','A139568','A156242','A161736','A210986','A346878');
UPDATE seq4 SET callcode = 'n2'     WHERE aseqno IN ('A092523','A100479','A135275','A135277','A138834','A139567','A143331','A145849'
    ,'A156243','A185026','A283156','A228037','A278223','A331759','A340101','A346879','A346877');
UPDATE seq4 SET aseqno = '# ' || aseqno WHERE parm3 <> '2';
COMMIT;
