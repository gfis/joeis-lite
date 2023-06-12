--  Patches for CC=triprod
--  @(#) $Id$
--  2023-06-06, Georg Fischer: tripro3, skip-this; RH=77
--
UPDATE seq4 s SET callcode  = 'skip-this' WHERE (SELECT i.keyword FROM asinfo i WHERE i.aseqno = s.aseqno) NOT LIKE '%tabl%';
COMMIT;
DELETE FROM seq4 WHERE callcode = 'skip-this';
COMMIT;
