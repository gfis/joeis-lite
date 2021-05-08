-- binomin.sql
-- 2021-05-08, Georg Fischer
DELETE FROM seq4 WHERE parm1 = '[[0],[-1],[1]]';
DELETE FROM seq4 WHERE aseqno IN ('A083272','A093392','A094616','A091759','A190734','A203427','A219092','A227858','A229581','A245593');
-- UPDATE seq4 s SET parm2 = '[' || COALESCE((SELECT SUBSTR(data, 1, LOCATE(',', data, LOCATE(',', data) + 1) - 1) FROM asdata d WHERE d.aseqno = s.aseqno), '0') || ']';
-- UPDATE seq4 SET parm2 = '[1,2]' WHERE aseqno in ('A097070');
-- UPDATE seq4 SET parm2 = '[-1,-3]' WHERE aseqno in ('A097070');
UPDATE seq4 SET parm1='[[0],[-6,-1,-3,-2],[-6,11,-7,2]]' WHERE aseqno='A095166';
UPDATE seq4 SET parm1='[[24,350,155,22,1],[-24]]' WHERE aseqno='A323220';
UPDATE seq4 SET parm1='[[6,35,12,1],[-6]]' WHERE aseqno='A323221';
UPDATE seq4 SET parm1='[[0],[-120,-24,-50,-35,-10,-1],[120,-6,-5,5,5,1]]' WHERE aseqno='A323228';
-- UPDATE seq4 SET parm2='[0,0,6,0,-12,0,90]' WHERE aseqno='A062765';
UPDATE seq4 SET offset = 0 WHERE aseqno in ('A152456');
UPDATE seq4 SET offset = 1 WHERE aseqno in ('A085375','A120408','A120409');
UPDATE seq4 SET parm2='[3]', parm1='[[0],[0,1],[-1]]' WHERE aseqno in ('A157984');
COMMIT;

