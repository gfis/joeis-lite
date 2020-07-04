--  Patches for CC=dupl
--  @(#) $Id$
--  2020-07-02: Georg Fischer
--
DELETE FROM seq4 
  WHERE aseqno    IN (SELECT aseqno FROM joeis)
     OR parm1 NOT IN (SELECT aseqno FROM joeis);
-- UPDATE seq4 SET parm2 = '~~    ~~next();';
COMMIT;
