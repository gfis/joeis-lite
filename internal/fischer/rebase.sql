-- Patches for CC=rebase
-- 2020-11-30, Georg Fischer

-- DELETE FROM seq4 WHERE aseqno IN ('A004777');
COMMIT;
UPDATE      seq4 s SET parm3 = '0', parm4 = (SELECT name FROM asname n WHERE n.aseqno = s.aseqno);
UPDATE      seq4 s SET callcode = 'rebasep' WHERE aseqno IN ('A004777','A005836','A020654','A020657','A033044');
UPDATE      seq4 s SET callcode = 'rebasep' WHERE aseqno IN ('A039155','A039209','A039274','A065039','A102487','A102491');
COMMIT;
DELETE FROM seq4 WHERE aseqno < 'A010000';
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROm joeis WHERE callcode LIKE 'rebase%' AND aseqno <> 'A033044');
COMMIT;
