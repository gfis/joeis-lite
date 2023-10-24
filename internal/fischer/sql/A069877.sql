-- A069877.sql - remove nyi subsequences, and set skip parameter
-- @(#) $Id$
-- 2023-10-23: simtraf pattern
-- 2023-07-26, Georg Fischer

-- remove all rseqnos that are nyi
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;

UPDATE seq4 s SET 
  s.offset1 = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.aseqno)
, s.parm4   = (SELECT i.offset1 FROM asinfo i WHERE i.aseqno = s.parm1)
, s.parm1   = s.parm2
;
COMMIT;
UPDATE seq4 s SET 
  s.parm1   = s.parm1 || '.skip(' || CAST(s.offset1 - s.parm4 AS CHAR) || ')' WHERE s.offset1 > s.parm4;
COMMIT;
UPDATE seq4 s SET 
  s.parm2   = s.parm3
;
COMMIT;
UPDATE seq4 s SET 
  s.parm1   = s.parm1 || '.skip(1)' WHERE s.aseqno = 'A278229';
;
COMMIT;
