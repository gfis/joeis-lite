--  Patches for CC=euleras
--  @(#) $Id$
--  2021-11-24: individual DELETE
--  2020-12-03: Georg Fischer
--
DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis WHERE superclass IS NOT NULL);
DELETE FROM seq4 WHERE aseqno IN ('A029726','A134964','A137917','A173239','A174065','A328550');
COMMIT;
