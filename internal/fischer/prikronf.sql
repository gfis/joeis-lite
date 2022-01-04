--  Patches for CC=pricongr
--  @(#) $Id$
--  2022-01-03: Georg Fischer
--
UPDATE seq4 SET parm1 = 15 WHERE aseqno IN ('A033212','A191018');
UPDATE seq4 SET parm1 = 22 WHERE aseqno IN ('A191020');
-- UPDATE seq4 SET parm2 = -1 WHERE aseqno IN ('A191060','A191060','A191060','A191060','A191060','A191060','A191060','A191060');
DELETE FROM seq4   WHERE aseqno IN ('A000000');
COMMIT;
