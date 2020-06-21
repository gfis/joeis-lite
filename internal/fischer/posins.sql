--  Patches for CC=posins
--  @(#) $Id$
--  2020-06-21: Georg Fischer
--
UPDATE seq4 SET PARM4='++mN;'   WHERE parm1  IN ('A001620','A049541','A156595','A189718','A001203','A286939','A101666');
UPDATE seq4 SET PARM4='next();' WHERE aseqno  >= 'A327175' AND aseqno <= 'A327224' AND PARM3 = 0; -- cf. email .cn
UPDATE seq4 SET PARM3=1         WHERE aseqno IN ('A284489','A284880'); -- typo, corr. 
UPDATE seq4 SET PARM1='A285667' WHERE aseqno IN ('A285666','A286058');
COMMIT;
