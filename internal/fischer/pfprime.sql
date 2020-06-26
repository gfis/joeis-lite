--  Patches for CC=pfprime
--  @(#) $Id$
--  2020-06-26: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN ('A058767','A058780','A058781'); -- formulae with n^2...
UPDATE seq4 SET parm2 = 299 WHERE aseqno = 'A281063';

