-- sql/inverse.sql
-- 2023-07-24, Georg Fischer
UPDATE seq4 s SET s.offset1 = (SELECT offset1 FROM asinfo i WHERE i.aseqno = s.aseqno);
COMMIT;
UPDATE seq4 s SET s.parm3 = s.offset1;
COMMIT;
