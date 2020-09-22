-- deris.sql - Patches for deris
-- @(#) $Id$
-- 2020-08-31, Georg Fischer; RT=78
DELETE FROM seq4 WHERE aseqno = 'A056837'; -- replaced by A001971, set elsewhere
DELETE FROM seq4 WHERE aseqno IN ('A122255','A122895','A167393','A323512','A327866'); -- charfun(2)
DELETE FROM seq4 WHERE aseqno IN ('A256863','A258833','A258834'); -- comseq
DELETE FROM seq4 WHERE aseqno IN ('A046934','A053735','A167393','A078488'); -- diffseq
-- UPDATE seq4 SET aseqno = 'A066674'       WHERE aseqno = 'A125878';
-- UPDATE seq4 SET parm1  = 'new A066674()' WHERE aseqno = 'A125879';
UPDATE seq4 SET parm2 = (CASE WHEN parm2 = 0 THEN '' ELSE ', Z.ONE' END) WHERE callcode = 'compseq';
UPDATE seq4 SET parm2 = ', Z.THREE' WHERE callcode = 'compseq' AND aseqno = 'A137905';

UPDATE seq4 s SET parm7 = (SELECT i.terms FROM asinfo i WHERE s.aseqno = i.aseqno)
                , parm8 = (SELECT i.terms FROM asinfo i WHERE s.parm1  = i.aseqno);

UPDATE seq4 SET parm2 = 0 WHERE callcode = 'stirling2';
COMMIT;
