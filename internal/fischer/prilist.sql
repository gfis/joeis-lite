-- Patches for CC=prilsit
-- @(#) $Id$
-- 2022-05-21, Georg Fischer
UPDATE seq4 SET parm1 = 0 WHERE aseqno IN ('A107771','A108108','A124849','A124853','A152843','A162410'
,'A201541'
,'A210504'
,'A210505'
,'A244087');
DELETE FROM seq4          WHERE aseqno IN ('A120431','A120432','A164641','A164642','A164571','A164573','A213210','A269721'
,'A213677'
,'A216303'
,'A220746'
,'A221211'
,'A222219'
,'A222227'
,'A222424'
,'A321867'
,'A329364'
,'A336060');
COMMIT;
