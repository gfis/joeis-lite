--  Patches for CC=pricongr
--  @(#) $Id$
--  2022-01-06: Georg Fischer
--
DELETE FROM seq4   WHERE aseqno IN ('A059858','A147603','A160215','A160216','A214360','A242190','A257362','A271265','A296926');
DELETE FROM seq4   WHERE aseqno IN 
('A000353'
,'A007639'
,'A038884'
,'A042966'
,'A057204'
,'A057205'
,'A107008'
);
COMMIT;
