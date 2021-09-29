-- deris.sql - Patches for deris
-- @(#) $Id$
-- 2020-12-03: eulerx again
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
UPDATE seq4 SET parm2 = 0 WHERE callcode = 'binomx';
UPDATE seq4 SET parm5 = 'next();' WHERE callcode = 'binomx' AND aseqno = 'A136281';
-- eulerx
UPDATE seq4 SET parm3 = 'new SkipSequence(' || parm3 || ',1)' WHERE callcode = 'eulerx' AND aseqno IN ('A053483','A055192','A134955','A137917','A292548','A299023','A299026','A330457');
UPDATE seq4 SET parm3 = 'new SkipSequence(' || parm3 || ',2)' WHERE callcode = 'eulerx' AND aseqno IN ('A071019');
DELETE FROM seq4 WHERE callcode = 'eulerx' AND aseqno IN ('A055192','A137917');
UPDATE seq4 SET parm4 = 'next();' WHERE callcode = 'eulerx' AND aseqno IN ('A053483','A071019','A099065','A132220','A226313','A263914','A299023','A299026');

DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno IN ('A294905');
COMMIT;
-- 2021-08-26, for compseq:
UPDATE seq4 SET callcode = 'compseq0' WHERE aseqno IN ('A153282','A165991','A219636','A228373','A257772','A325424');
DELETE FROM seq4 WHERE aseqno IN ('A214837', 'A226913','A274504'); -- primes; not sorted
COMMIT;
-- 2021-09-29
DELETE FROM seq4 WHERE aseqno IN ('A104406','A278959');
