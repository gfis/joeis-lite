--  Patches for CC=decofr
--  @(#) $Id$
--  2021-08-26: Georg Fischer
--
DELETE FROM seq4 WHERE callcode NOT IN ('decofr');
COMMIT;
