-- bisect.sql
-- 2021-05-28, Georg Fischer

-- switch polarity
UPDATE seq4 set parm2 = 1 WHERE aseqno IN ('A092668', 'A099813');
DELETE FROM seq4 WHERE aseqno IN ('A185424');

