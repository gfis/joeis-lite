--  Patches for CC=nisolut
--  @(#) $Id$
--  2020-10-28: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno < 'A038000';
-- UPDATE seq4 SET parm2=1 WHERE aseqno <= 'A124000';
COMMIT;
