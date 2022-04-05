-- primen.sql
-- @(#) $Id$
DELETE FROM seq4 WHERE ASEQNO IN ('A078772'
,'A067362'
,'A067363'
,'A067364'
,'A067365'
,'A074396'
,'A088659'
,'A099634'
,'A161758'
,'A189409'
,'A246778'
,'A248714'
,'A249241'
,'A249669'
,'A257231'
,'A275272'
,'A275276'
,'A318898' -- A002144
,'A318908' -- A002145
,'A333417'
,'A342349'
);
UPDATE seq4 SET OFFSET = 1 WHERE aseqno IN ('A061024');
UPDATE seq4 SET OFFSET = 2 WHERE aseqno IN ('A139164');
UPDATE seq4 SET parm1 = 'MemoryFactorial.SINGLETON.factorial(p).subtract(1)'             WHERE aseqno IN ('A139189');
UPDATE seq4 SET parm1 = 'MemoryFactorial.SINGLETON.factorial(p).subtract(2).divide2()'   WHERE aseqno IN ('A139190');
UPDATE seq4 SET parm1 = 'MemoryFactorial.SINGLETON.factorial(p).subtract(4).divide(4)'   WHERE aseqno IN ('A139192');
UPDATE seq4 SET parm1 = 'MemoryFactorial.SINGLETON.factorial(p).subtract(8).divide(8)'   WHERE aseqno IN ('A139196');
UPDATE seq4 SET parm1 = 'MemoryFactorial.SINGLETON.factorial(p).subtract(10).divide(10)' WHERE aseqno IN ('A139198');
COMMIT;
