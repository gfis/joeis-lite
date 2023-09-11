-- patch filtpos.gen
-- @(#) $Id$
-- 2023-09-08, Georg Fischer
UPDATE seq4 s SET parm1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno), parm2 = parm2 || '.skip(1)' 
    WHERE parm3 = 'DIVISIBLE_BY_INDEX' AND parm1 = 0;
COMMIT;
DELETE FROM seq4 WHERE aseqno IN
('A000000'
,'A073735' --	1	FAIL	,579,968,1065,1221...	,2,8,17,18
,'A075002' --	3	FAIL	,2,2...	,3,5
,'A080778' --	0	FATOK	blocked...	ms
,'A124110' --	1	FAIL	,11,29,31,59...	,2,3,5,8
,'A136367' --	1	FAIL	,2,3,4,5...	,3,4,5,6
,'A233419' --	0	FATOK	blocked...	ms
,'A237612' --	2	FAIL	,1,3,2...	,2,7,8
,'A256545' --	1	FAIL	,6,30,434,510...	,9,25,81,49
,'A259490' --	1	FAIL	,2,4,9,33...	,3,5,10,34
,'A262081' --	1	FAIL	,6,10,210,34...	,2,3,5,6
,'A267094' --	0	FATOK	blocked...	ms
,'A273014'
,'A283158' --	0	FATOK	blocked...	ms
,'A296244' --	1	FAIL	,15,21,35,39...	,3,5,6,9
,'A304044' --	0	FATOK	blocked...	ms
,'A316312'
,'A321084' --	3	FAIL	,5,19...	,4,9
,'A321343' --	1	FAIL	,19,73,103,157...	,1,2,4,6
,'A324060' --	2	FAIL	,3,5,6...	,10,16,65
,'A325630' --	0	FATOK	blocked...	ms
,'A325812' --	2	FAIL	,6,12,28...	,2,3,4
,'A326074' --	1	FAIL	,3,6,28,221...	,4,6,8,9
,'A327432' --	0	FATOK	blocked...	ms
,'A327433' --	1	FAIL	,3,5,6,11...	,1,2,45,350
,'A339429' --	0	FATOK	blocked...	ms
,'A342838' --	0	FATAL	Exception...	79799799739999199998399999919999
,'A359148' --	0	FATOK	blocked...	ms
,'A360503' --	0	FATOK	blocked...	ms
,'A361662' --	2	FAIL	,4,6,8...	,48,1280,2496
,'A364050' --	1	FAIL	,10001,36763,1037301,1226221...	,1,2,3,4
,'A143986' -- FAIL/FATOK
,'A145524' -- FAIL/FATOK
,'A263161' -- FAIL/FATOK
,'A270617' -- FAIL/FATOK
,'A300790' -- FAIL/FATOK
,'A306724' -- FAIL/FATOK
,'A319838' -- FAIL/FATOK
,'A329061' -- FAIL/FATOK
,'A329293' -- FAIL/FATOK
,'A336326' -- FAIL/FATOK
,'A356164' -- FAIL/FATOK
);
COMMIT;
