--  Patches for CC=pricongr
--  @(#) $Id$
--  2022-01-01: Georg Fischer
--
UPDATE seq4 SET parm1 = 15 WHERE aseqno IN('A033212','A191018');
DELETE FROM seq4   WHERE aseqno IN ('A000000');
COMMIT;
