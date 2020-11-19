--  Patches for CC=egypfr
--  @(#) $Id$
--  2020-11-19: Georg Fischer
--
DELETE FROM seq4             WHERE aseqno IN ('A139518','A139521'); -- using only prime numbers and allowing repetitions
DELETE FROM seq4             WHERE aseqno IN ('A157327','A157332'); -- o.g.f.s
DELETE FROM seq4             WHERE aseqno IN ('A304798'); -- sign-alternating
UPDATE seq4 SET parm2 = ''   WHERE aseqno IN ('A001466','A006487');
UPDATE seq4 SET parm2 = ',1' WHERE aseqno IN ('A118325');
UPDATE seq4 SET parm1 = 'CR.PHI'           WHERE aseqno IN ('A117116');
UPDATE seq4 SET parm1 = 'CR.PHI.inverse()' WHERE aseqno IN ('A304798');
COMMIT;
