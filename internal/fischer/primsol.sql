-- Patches for CC=primsol
-- 2021-02-28, Georg Fischer
UPDATE seq4 SET parm3 = '-2' WHERE aseqno = 'A216747';
COMMIT;
