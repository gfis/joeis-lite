-- quots.sql
-- 2021-11-26, Georg Fischer
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis) 
                   AND parm1 NOT IN (SELECT aseqno FROM poeis)
                   ;
DELETE FROM seq4 WHERE callcode = 'quot' 
                   AND parm3 NOT IN (SELECT aseqno FROM joeis)
                   AND parm3 NOT IN (SELECT aseqno FROM poeis);
UPDATE seq4 SET parm2 = 2         WHERE aseqno IN ('A203316');
UPDATE seq4 SET parm1 = 'A203430' WHERE aseqno IN ('A203431');
UPDATE seq4 SET parm1 = 'A203524' WHERE aseqno IN ('A203525');
UPDATE seq4 SET parm1 = 'A203527' WHERE aseqno IN ('A203528');
UPDATE seq4 SET parm1 = 'A203587' WHERE aseqno IN ('A203588');
COMMIT;
