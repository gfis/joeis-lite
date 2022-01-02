--  Patches for CC=pricongr
--  @(#) $Id$
--  2022-01-01: Georg Fischer
--
DELETE FROM seq4   WHERE aseqno IN ('A059858','A147603','A160215','A160216','A214360','A242190','A257362','A271265','A296926');
COMMIT;
