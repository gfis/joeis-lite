--  Patches for CC=ca2elem
--  @(#) $Id$
--  2021-12-23: Georg Fischer
--
UPDATE seq4 SET aseqno = 'A169703', parm1 = 174 WHERE aseqno IN ('A269707');
UPDATE seq4 SET parm3 =  'new A169703()'        WHERE aseqno IN ('A269709');
UPDATE seq4 SET aseqno = 'A169704', parm3 = 'new A169703()' WHERE aseqno IN ('A269710');
UPDATE seq4 SET aseqno = 'A169702', parm3 = 'new A169701()' WHERE aseqno IN ('A271460');
UPDATE seq4 SET aseqno = 'A270569'              WHERE aseqno IN ('A270565');
UPDATE seq4 SET parm3 =  'new AA270569()'       WHERE aseqno IN ('A270565');
UPDATE seq4 SET parm1 = 65                      WHERE aseqno IN ('A278753','A278754','A278755','A278756');
UPDATE seq4 SET parm1 = 33                      WHERE aseqno IN ('A276708','A276768','A276966','A277773');
UPDATE seq4 SET callcode = 'ca2rightd'          WHERE aseqno IN ('A284405');
UPDATE seq4 SET aseqno   = 'A283523'            WHERE aseqno IN ('A284406');
UPDATE seq4 SET aseqno   = 'A282520'            WHERE aseqno IN ('A282510');
UPDATE seq4 SET aseqno   = 'A282448'            WHERE aseqno IN ('A282428');
UPDATE seq4 SET aseqno   = 'A282449'            WHERE aseqno IN ('A282429');
UPDATE seq4 SET aseqno   = 'A280610'            WHERE aseqno IN ('A280609');
UPDATE seq4 SET aseqno   = 'A280467'            WHERE aseqno IN ('A280466');
UPDATE seq4 SET aseqno   = 'A279807'            WHERE aseqno IN ('A279802');
UPDATE seq4 SET aseqno   = 'A279806'            WHERE aseqno IN ('A279801');
UPDATE seq4 SET aseqno   = 'A279030'            WHERE aseqno IN ('A279031');
UPDATE seq4 SET aseqno   = 'A278787'            WHERE aseqno IN ('A278778');
DELETE FROM seq4                                WHERE aseqno IN ('A283596','A283597');
DELETE FROM seq4                                WHERE aseqno IN
('A056830'
,'A078371'
,'A101622'
,'A105279'
,'A116520'
,'A140252'
,'A153772'
,'A153893'
,'A154955'
,'A166147'
,'A234275'
,'A273314'
,'A273315'
,'A273316'
,'A273408'
,'A273480'
,'A273481'
,'A273797'
,'A277736'
,'A279029'
,'A283523'
);
COMMIT;
