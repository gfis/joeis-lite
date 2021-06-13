-- holfsig.sql
-- 2021-06-01, Georg Fischer
UPDATE seq4 SET parm2 = '10,20,30,40,5,15,25,35,45,55,65,75,85,95'           WHERE aseqno = 'A069534';
UPDATE seq4 SET parm2 = '1,2,4,1,5,6,4,5,1,4,2,1,1,2'                        WHERE aseqno = 'A070937';
UPDATE seq4 SET parm2 = '5,1,6,2,7,3,8,4,9,14,19,24,29,34,39'                WHERE aseqno = 'A077491';
UPDATE seq4 SET parm2 = '1,7,36,151,570,2019,6893,23034,76020,249077,812614' WHERE aseqno = 'A097554';
UPDATE seq4 SET parm2 = '1729,251,219,157,158,131,132,72,73,74'              WHERE aseqno = 'A342902';
UPDATE seq4 SET parm2 = '0,0,1,1,2,7,5,16,19,39,77,103,226,334,636,1106'     WHERE aseqno = 'A343314';
UPDATE seq4 SET parm2 = '0,0,1,1,2,6,6,14,19,36,67,103,194,315,560,971'      WHERE aseqno = 'A343315';
UPDATE seq4 SET parm2 = '5,47,243'                                           WHERE aseqno = 'A344121';
DELETE FROM seq4 WHERE aseqno IN ('A242350','A243845','A249668','A293978','A293979','A293981','A293978','A324472','A336238','A337240','A337398');
COMMIT;
