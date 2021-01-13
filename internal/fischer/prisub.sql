-- Patches for CC=prisub
-- 2021-01-12, Georg Fischer
UPDATE seq4 SET parm4 = 'next();' WHERE aseqno IN ('A073598','A097697','A219042','A219046','A219618','A230433');
COMMIT;
