-- A063130.sql 
-- @(#) $Id$
-- 2022-01-19, Georg Fischer; RN=74-2
UPDATE seq4 s SET parm2 = (SELECT '[' || SUBSTR(a.data, 1, 16) || ']' FROM asdata a WHERE a.aseqno = s.aseqno);
COMMIT;
