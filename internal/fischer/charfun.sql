-- created by repair_head.pl -n 4 at 2020-08-28 10:30:52
UPDATE seq4 SET parm4='next();' WHERE aseqno='A083187';-- ,1,1,1,0,1,0,1,0 ,0,1,1,1,0,1,0,1
UPDATE seq4 SET parm4='next();' WHERE aseqno='A099395';-- ,1,0,0,1,0,0,0,0 ,0,1,0,0,1,0,0,0
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
