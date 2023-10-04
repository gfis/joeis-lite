-- patches for morfix
-- @(#) $Id$
-- 2023-09-19, Georg Fischer; try explicit anchors; without that: in morfix.sql

-- A106641	morfix	0	1	rows	1->3443,2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}		1->{3, 4, 4, 3}, 2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}.				A four-symbol four-at-a-time substitution with an ordering change: q=0.
-- A106642	morfix	0	1	rows	1->2112,2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}		1->{2, 1, 1, 2}, 2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{4, 3, 3, 4}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}.				A four-symbol four-at-a-time substitution with an ordering change: q=1.

UPDATE seq4 SET parm3 = '1->3443,2->2332,3->1221,4->4114' WHERE aseqno = 'A106641'; -- q=0
UPDATE seq4 SET parm3 = '1->3443,2->3223,3->1221,4->1441' WHERE aseqno = 'A106642'; -- q=1
COMMIT;
UPDATE seq4 SET parm2 = 'trian' WHERE aseqno IN 
('A000000'
,'A105202' -- ok      FAIL    ,2,1,1,2,1,2,3,2        computed
,'A106109' -- ok      FAIL    ,3,6,5,6,1,2,1,1        computed
,'A106583' -- ok      FAIL    ,2,1,3,5,2,2,2,4        computed
);
UPDATE seq4 SET parm2 = 'word' WHERE aseqno IN 
('A000000'
,'A103682' -- 3       FAIL    ,2,1,2,1,2,1,2,3        computed
,'A105264' -- 1       FAIL    ,2,2,3,2,3,3,4,2        computed
);
UPDATE seq4 SET parm2 = 'rows' WHERE aseqno IN 
('A000000'
,'A072845' -- 2       FAIL    ,3,7,9,1,3,7,9,3        computed
,'A093951' -- 2       FAIL    ,2,4,8,17,36,80,176,403 computed
,'A103269' -- 1       FAIL    ,12,1213,1213121,1213121121312,11,1,2,1,1,2,1,2
,'A103956' -- 4       FAIL    ,1,1,2,1,1,2,1,2        computed
,'A103957' -- 2       FAIL    ,2,1,1,2,1,1,2,1        computed
,'A105102' -- ok      FAIL    ,1,2,2,3,1,2,2,3        computed
,'A105103' -- ok      FAIL    ,1,1,2,1,2,1,2,1        computed
,'A105105' -- 6       FAIL    ,3,1,2,2,3,2,3,3        computed
,'A105123' -- ok      FAIL    ,1,1,6,3,1,1,6,3        computed
,'A105256' -- 1       FAIL    ,4,2,4,2,1,5,1,3        computed
,'A105313' -- 2       FAIL    ,4,3,2,1,4,3,2,4        computed
,'A105933' -- 11      FAIL    ,1,2,4,7,1,2,3,2        computed
,'A106038' -- 1       FAIL    ,2,3,1,2,1,1,2,3        computed
,'A106049' -- 0       FAIL    ,4,3,4,3,2,1,2,3        computed
,'A106117' -- 0       FAIL    ,3,5,6,5,1,1,2,1        computed
,'A106148' -- 0       FAIL    ,4,5,4,8,9,8,2,3        computed
,'A106437' -- 0       FAIL    ,4,1,2,2,2,1,2,2        computed
,'A106559' -- 0       FAIL    ,2,3,2,1,4,1,2,3        computed
,'A106581' -- 0       FAIL    ,2,4,3,1,2,2,2,4        computed
,'A106584' -- 0       FAIL    ,3,2,3,1,3,5,3,2        computed
,'A106589' -- 0       FAIL    ,2,3,3,1,2,3,2,3        computed
,'A106601' -- 0       FAIL    ,3,1,2,3,3,2,3,3        computed
,'A106638' -- 1       FAIL    ,2,2,1,2,3,3,2,2        computed
,'A106641' -- 1       FAIL    ,2,2,1,4,1,1,4,4        computed
,'A106642' -- 1       FAIL    ,4,4,1,4,3,3,4,4        computed
,'A106644' -- 0       FAIL    ,4,2,3,3,1,3,1,1        computed
,'A106645' -- 0       FAIL    ,2,4,1,2,4,1,3,1        computed
,'A106650' -- 0       FAIL    ,3,4,1,2,3,4,2,3        computed
,'A106652' -- 0       FAIL    ,2,3,4,5,1,2,3,4        computed
,'A106653' -- 1       FAIL    ,2,3,4,2,3,4,5,3        computed
,'A106654' -- 0       FAIL    ,4,1,2,3,2,3,4,1        computed
,'A106655' -- 0       FAIL    ,4,3,2,1,4,3,2,1        computed
,'A106686' -- 1       FAIL    ,3,3,2,4,3,2,4,2        computed
,'A106687' -- 0       FAIL    ,6,1,2,3,4,5,6,2        computed
,'A106688' -- 0       FAIL    ,2,4,2,5,6,3,4,3        computed
,'A106689' -- 2       FAIL    ,3,2,1,1,1,3,2,1        computed
,'A106693' -- 2       FAIL    ,3,2,3,1,1,1,1,3        computed
,'A106698' -- 1       FAIL    ,2,1,2,1,2,2,3,1        computed
,'A106703' -- 1       FAIL    ,2,1,2,1,2,1,2,2        computed
,'A106704' -- 0       FAIL    ,5,6,5,5,5,5,4,5        computed
,'A106705' -- 3       FAIL    ,7,7,7,7,7,7,7,1        computed
,'A107292' -- 1       FAIL    ,3,3,1,2,2,1,3,3        computed
,'A107296' -- 1       FAIL    ,3,1,1,2,1,3,1,1        computed
,'A107297' -- 2       FAIL    ,3,1,1,2,1,3,1,1        computed
,'A107335' -- 2       FAIL    ,3,2,3,1,1,1,3,2        computed
,'A107336' -- 1       FAIL    ,2,3,3,2,1,3,1,1        computed
,'A107338' -- 1       FAIL    ,2,1,3,2,1,3,1,2        computed
,'A107469' -- 2       FAIL    ,2,3,4,3,2,1,1,1        computed
,'A107470' -- 4       FAIL    ,3,3,7,7,9,1,1,1        computed
,'A107474' -- 1       FAIL    ,2,3,4,2,1,2,3,4        computed
,'A107604' -- 0       FAIL    ,2,2,2,2,5,2,5,2        computed
,'A107640' -- 1       FAIL    ,2,1,4,3,5,2,4,1        computed
,'A107641' -- 1       FAIL    ,3,2,1,4,3,5,2,5        computed
,'A107789' -- 0       FAIL    ,2,2,2,3,3,2,2,2        computed
,'A107790' -- 0       FAIL    ,3,7,12,15,20,24,29,33  computed
,'A107791' -- 0       FAIL    ,2,4,7,11,13,16,18,21   computed
,'A107792' -- 0       FAIL    ,3,5,8,9,12,14,17,19    computed
,'A108015' -- 0       FAIL    ,2,3,4,3,4,4,1,2        computed
,'A108121' -- 0       FAIL    ,3,1,2,2,3,1,2,2        computed
,'A108132' -- 0       FAIL    ,2,3,3,1,2,2,3,3        computed
,'A131517' -- 2       FAIL    ,4,8,11,4,8,11,1,8      computed
,'A131803' -- 1       FAIL    ,4,8,11,3,8,12,3,7      computed
,'A131979' -- 2       FAIL    ,3,5,7,8,2,3,5,7        computed
,'A132725' -- 1       FAIL    ,6,9,11,1,4,9,12,2      computed
,'A133159' -- 2       FAIL    ,3,6,8,9,1,4,6,12       computed
,'A133193' -- 2       FAIL    ,3,6,8,1,4,6,11,1       computed
,'A133210' -- 2       FAIL    ,6,10,12,2,6,5,11,2     computed
,'A133269' -- 2       FAIL    ,5,8,12,5,9,12,4,8      computed
,'A133302' -- 2       FAIL    ,3,6,10,1,3,8,12,1      computed
,'A133303' -- 1       FAIL    ,2,3,4,5,7,1,3,4        computed
,'A133329' -- 2       FAIL    ,3,6,7,1,3,10,11,6      computed
,'A133339' -- 2       FAIL    ,3,6,7,8,1,2,9,10       computed
,'A133340' -- 2       FAIL    ,3,6,7,1,2,8,9,1        computed
,'A135357' -- 1       FAIL    ,6,6,6,8,6,6,6,8        computed
,'A135649' -- 1       FAIL    ,-1,-59,-2951,-144881,-7100318,-
,'A137269' -- 1       FAIL    ,0,1,1,2,1,0,2,1        computed
,'A138484' -- 0       FAIL    ,0,10,1011,3110,102113,13311210,
,'A138485' -- 1       FAIL    ,11,21,1112,1231,211312,223113,2
,'A138486' -- 0       FAIL    ,2,12,1211,3112,122113,133122,22
,'A138487' -- 0       FAIL    ,3,13,1311,3113,2321,112213,1331
,'A138488' -- 0       FAIL    ,4,14,1411,3114,142113,13311214,
,'A138489' -- 0       FAIL    ,5,15,1511,3115,152113,13311215,
,'A138490' -- 0       FAIL    ,6,16,1611,3116,162113,13311216,
,'A138491' -- 0       FAIL    ,7,17,1711,3117,172113,13311217,
,'A138492' -- 0       FAIL    ,8,18,1811,3118,182113,13311218,
,'A138493' -- 0       FAIL    ,9,19,1911,3119,192113,13311219,
,'A268475' -- 1       FAIL    ,435,555,2415,31635,38025,44835,
,'A290817' -- 1       FAIL    ,3,5,7,11,13,19,29,31   computed
,'A299539' -- 1       FAIL    ,5,19,28,37,46,55,64,73 computed
,'A317196' -- 0       FAIL    ,2,13,121,121312,12131211213,121
,'A317953' -- 2       FAIL    ,12,1231,1231112,1231112121231,1 
);
COMMIT;

