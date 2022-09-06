-- @(#) $Id$
-- 2022-09-06, Georg Fischer
-- replace parm6 with initial data term
--
UPDATE seq4 s SET s.parm6
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
COMMIT;
