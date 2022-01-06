--  Patches for CC=pricongr
--  @(#) $Id$
--  2022-01-06: Georg Fischer
--
UPDATE seq4 SET parm1 = 15 WHERE aseqno IN ('A033212','A191018');
UPDATE seq4 SET parm1 = 22 WHERE aseqno IN ('A191020');
DELETE FROM seq4           WHERE aseqno IN ('A191018','A191019','A191061');
COMMIT;
