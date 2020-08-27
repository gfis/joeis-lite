--  Patches for target dex
--  @(#) $Id$
--  2020-06-12: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN
   ( 'A085667' -- take too long
   , 'A173973' -- special MMA's Zeta[s,a]
   );
COMMIT;
