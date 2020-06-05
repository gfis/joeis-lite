--  Delete WHERE rseqno does not exist
--  @(#) $Id$
--  2020-06-04: Georg Fischer
--
DELETE FROM seq4
WHERE  parm2 NOT IN (SELECT DISTINCT aseqno FROM seq4 ) 
  AND  parm2 NOT IN (SELECT          aseqno FROM joeis) 
;
DELETE FROM seq4 WHERE aseqno IN('A330160', 'A191777'); -- take too long
COMMIT;
