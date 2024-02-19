-- holos.sql
-- 2024-02-07, Georg Fischer; *KFF=0!!
-- Replace parm2 with initial data terms
UPDATE seq4 s SET s.parm2 = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm2 - 1 AS CHAR) || '}')
  FROM asdata d
  WHERE d.aseqno = s.aseqno
  );
COMMIT;
