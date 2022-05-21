-- trecpas.sql: patches for trexpas
-- 2022-05-19, Georg Fischer
--
UPDATE seq4 SET callcode = 'trecpas1' WHERE offset > 0;
COMMIT;
