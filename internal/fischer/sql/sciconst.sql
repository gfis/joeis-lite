--  Patches for callcode sciconst
--  @(#) $Id$
--  2021-07-24: Georg Fischer
--
UPDATE seq4 s SET parm1 = (SELECT d.data FROM asdata d WHERE s.aseqno = d.aseqno);
COMMIT;
