--  Patches for CC=recordval
--  @(#) $Id$
--  2020-06-24: Georg Fischer
--
UPDATE seq4 SET PARM4='~~    ~~next();' WHERE aseqno IN ('A086332','A120754','A236145');
COMMIT;
