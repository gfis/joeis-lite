-- @(#) $Id$
-- 2022-09-06, Georg Fischer
-- replace parm6 with initial data term
--
-- = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){1}')
UPDATE seq4 s SET s.parm6
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
UPDATE seq4 s SET s.parm7
= (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){1}')
     FROM asdata d 
     WHERE d.aseqno = s.aseqno
  );
COMMIT;
-- DELETE FROM seq4 WHERE LENGTH(parm6) >= 5;
-- COMMIT;
