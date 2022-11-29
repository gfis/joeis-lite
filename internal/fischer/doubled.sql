--  Patches for CC=doubled
--  @(#) $Id$
--  2022-11-28: Georg Fischer; EF=69
--
UPDATE seq4 SET parm1 = 'A029837' WHERE aseqno = 'A292510';
UPDATE seq4 s SET offset = (SELECT offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
DELETE FROM seq4 WHERE aseqno IN ('A000000'
,'A064284'
,'A086007'
,'A091372'
,'A111972'
,'A137979'
,'A140438'
,'A160338'
,'A175860'
,'A178334'
,'A178815'
,'A185255'
,'A185294'
,'A186729'
,'A211661'
,'A211666'
,'A236678'
,'A239374'
,'A274070'
,'A276502'
,'A279758'
,'A285698'
,'A290792'
,'A320006'
,'A339276'
,'A346663'
,'A353513'
,'A356852'
);
COMMIT;

