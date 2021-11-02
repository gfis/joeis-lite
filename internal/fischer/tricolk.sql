-- tricolk.sql: patches for tricolk
-- 2021-10-29, Georg Fischer
--
UPDATE seq4 SET parm3 = 0 WHERE aseqno BETWEEN 'A287046' AND 'A287048';
UPDATE seq4 SET parm3 = 0 WHERE aseqno BETWEEN 'A288071' AND 'A288090';
UPDATE seq4 SET parm3 = 0 WHERE aseqno BETWEEN 'A288262' AND 'A288264';
UPDATE seq4 SET parm3 = 0 WHERE aseqno BETWEEN 'A288262' AND 'A288264';
UPDATE seq4 SET parm3 = 0 WHERE aseqno BETWEEN 'A288271' AND 'A288290';
COMMIT;
