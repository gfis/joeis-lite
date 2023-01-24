-- Patches for CC=flosqrt
-- 2021-04-08, Georg Fischer
--
UPDATE seq4 SET parm1 = 'A000178'             WHERE aseqno = 'A192668';
UPDATE seq4 SET parm2 = '~~    ~~super.next();' WHERE aseqno = 'A192675';
COMMIT;
