-- convprod.sql
-- @(#) $Id$
-- 2023-02-24, Georg Fischer; *war.ua=1
UPDATE seq4 SET callcode ='convprod0' WHERE aseqno IN
('A067588'
,'A191831'
,'A198956'
,'A238133'
,'A229326'
,'A274352'
,'A274355'
,'A277029'
,'A304909'
,'A304909'
,'A305082'
,'A305101'
,'A305102'
);
DELETE FROM seq4 WHERE aseqno IN
('A086718'
,'A101313'
,'A102231'
,'A221529'
,'A281905'
,'A281906'
,'A305199'
,'A306041'
,'A340579'
,'A340584'
,'A343531'
,'A347237'
,'A354543'
);
COMMIT;
