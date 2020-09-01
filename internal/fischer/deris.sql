-- deris.sql - Patches for deris
-- @(#) $Id$
-- 2020-08-31, Georg Fischer; RT=78
DELETE FROM seq4 WHERE aseqno = 'A056837'; -- replaced by A001971, set elsewhere
DELETE FROM seq4 WHERE aseqno IN ('A122255','A122895','A167393'); -- charfun(2)
DELETE FROM seq4 WHERE aseqno IN ('A046934','A053735','A167393'); -- diffseq
-- UPDATE seq4 SET parm1  = 'new A001971()' WHERE aseqno = 'A059169';
-- UPDATE seq4 SET aseqno = 'A066674'       WHERE aseqno = 'A125878';
-- UPDATE seq4 SET parm1  = 'new A066674()' WHERE aseqno = 'A125879';
-- UPDATE seq4 SET parm5 = ', true, 6' WHERE aseqno = 'A167393';
COMMIT;
