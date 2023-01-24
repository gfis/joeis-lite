--  Patches for target padding
--  @(#) $Id$
--  2020-08-20: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN
   ( 'A305493' -- PadRight in complicated formula
   , 'A000000' -- 
   );
COMMIT;
