-- quotm.sql
-- 2021-11-28, Georg Fischer
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE (callcode <> 'quots') AND parm3 NOT IN (SELECT aseqno FROM joeis);
COMMIT;
