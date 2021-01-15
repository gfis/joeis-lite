-- Patches for CC=anumof
-- 2021-01-15, Georg Fischer
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('xx');
UPDATE seq4 SET parm2 = '[13]' WHERE aseqno = 'A216179';
UPDATE seq4 SET offset = 0     WHERE aseqno = 'A279538';
COMMIT;
