-- morfck.sql
-- @(#) $Id$
-- 2021-09-20, Georg Fischer

UPDATE seq4 s SET parm2 = (SELECT SUBSTR(d.data,1,1) || SUBSTR(d.data,3,1) || SUBSTR(d.data,5,1) || SUBSTR(d.data,7,1) FROm asdata d WHERE d.aseqno = s.aseqno)
  WHERE callcode LIKE 'mor%';
COMMIT;
