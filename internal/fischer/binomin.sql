-- binomin.sql
-- 2021-05-08, Georg Fischer

DELETE FROM seq4 WHERE parm1 = '[[0],[-1],[1]]';
DELETE FROM seq4 WHERE aseqno IN 
    ('A083272','A093392','A094616','A091759','A128812','A161372','A164754','A190734','A203427'
    ,'A219092','A227624','A227858','A229581','A245593','A247486','A249922');
    -- ,'A257888');
    COMMIT;
UPDATE seq4 SET parm1  ='[[0],[-15120,-11274,-3325,-485,-35,-1],[0,24,50,35,10,1]]'
                                                                            WHERE aseqno IN ('A047831');
UPDATE seq4 SET parm1  ='[[0],[-840,-638,-179,-22,-1],[0,6,11,6,1]]'        WHERE aseqno IN ('A047835');
UPDATE seq4 SET parm2  ='[0,1,6,18]'                                        WHERE aseqno IN ('A052655');
UPDATE seq4 SET parm2  ='[1,1,2,7]'                                         WHERE aseqno IN ('A055503');
UPDATE seq4 SET parm1  ='[[0,-2,3],[-1]]', parm2 ='[1,36,21]'               WHERE aseqno IN ('A074155');
UPDATE seq4 SET parm1  ='[[0],[0,-3,-4,-1],[1]]', parm2 ='[6]'              WHERE aseqno IN ('A084259');
UPDATE seq4 SET parm1  ='[[0],[-6,-1,-3,-2],[-6,11,-7,2]]'                  WHERE aseqno IN ('A095166');
UPDATE seq4 SET parm1  ='[[0],[9,-7],[1]]', parm2  ='[1]'                   WHERE aseqno IN ('A147585');
UPDATE seq4 SET parm2  ='[0,1,2,5,7]'                                       WHERE aseqno IN ('A163985');
UPDATE seq4 SET parm2  ='[1,8,25]'                                          WHERE aseqno IN ('A164754');
COMMIT;
UPDATE seq4 SET parm1  ='[[0],[-2,-8,-8],[-1,1,2]]'                         WHERE aseqno IN ('A257589');
UPDATE seq4 SET parm1  ='[[24,350,155,22,1],[-24]]'                         WHERE aseqno IN ('A323220');
UPDATE seq4 SET parm1  ='[[6,35,12,1],[-6]]'                                WHERE aseqno IN ('A323221');
UPDATE seq4 SET parm1  ='[[0],[-120,-24,-50,-35,-10,-1],[120,-6,-5,5,5,1]]' WHERE aseqno IN ('A323228');
UPDATE seq4 SET parm1  ='[[0],[0,1],[-1]]', parm2  ='[3]'                   WHERE aseqno IN ('A157984');
UPDATE seq4 SET parm2  ='[1,9,100]'                                         WHERE aseqno IN ('A056002');
UPDATE seq4 SET parm1  ='[[0],[-12,-8,-1],[0,1]', parm2  ='[1,21]'          WHERE aseqno IN ('A062260');
UPDATE seq4 SET parm2  ='[8,16,24,27,32,35,40,43,48,51,54,56,59,62,64,67,70,72,75,78,80,81,83,86,88,89,91,94,96,97,99,102,104,105,107,108,110,112,113,115,116,118,120,121,123,124,125,126,128,129,131,132,133,134,135,136,137,139,140,141,142,143,144,145,147,148,149,150,151,152,153,155,156]'
                                                                            WHERE aseqno IN ('A078131');
COMMIT;
UPDATE seq4 SET parm1  = '[[0],[2,-3,3,-1],[3,-3,1]]', parm2='[1,1,3,7,26]' WHERE aseqno IN ('A108217');
UPDATE seq4 SET parm2  ='[1,0,6,20,81,324]'                                 WHERE aseqno IN ('A118265');
UPDATE seq4 SET parm2  ='[1,0,10,40,205,1024]', offset=5                    WHERE aseqno IN ('A118266');
UPDATE seq4 SET parm1  ='[0,1,-2,3,-4,3,-2,1]', parm2='[0,-1,0,2,1,-1,1,4]' WHERE aseqno IN ('A131505');
UPDATE seq4 SET parm2  ='[1,2,6]'                                           WHERE aseqno IN ('A131352');
UPDATE seq4 SET parm2  ='[1,2,6]'                                           WHERE aseqno IN ('A131352');
UPDATE seq4 SET parm2  ='[1,2,6]'                                           WHERE aseqno IN ('A131352');
UPDATE seq4 SET parm2  ='[1,2,3,4,9,19,44,94,194,294]'                      WHERE aseqno IN ('A258274');
COMMIT;
UPDATE seq4 SET parm1  ='[[0],[24,-176,384,-256],[-12,-48,-27,27]]', parm2='[0,4]', offset=1 
                                                                            WHERE aseqno IN ('A283049');
UPDATE seq4 SET offset = 0                                                  WHERE aseqno IN ('A152456');
UPDATE seq4 SET offset = 1                                                  WHERE aseqno IN ('A052795','A060080','A085375','A120408','A120409');
UPDATE seq4 SET offset = 2                                                  WHERE aseqno IN ('A188554');
COMMIT;
