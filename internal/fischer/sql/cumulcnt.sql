-- cumulcnt.sql
-- @(#) $Id$
-- 2022-01-14, Georg Fischer

UPDATE seq4 SET parm7 = CAST(SUBSTR(aseqno, 2, 6) AS INT) WHERE aseqno IN ('A079668','A240508');
UPDATE seq4 SET callcode = '' WHERE parm1 = 'I';
-- DELETE FROM seq4 WHERE aseqno < 'A050000';
DELETE FROM seq4 WHERE aseqno IN
('A030717'
,'A030718'
,'A030720'
,'A051120'
,'A079668'
,'A126027'
);
COMMIT;
