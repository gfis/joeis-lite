--  Patches for CC=wraptr
--  @(#) $Id$
--  2021-10-17: Georg Fischer
--
UPDATE seq4 SET parm2 = 'null' WHERE parm1 = parm2;
COMMIT;

