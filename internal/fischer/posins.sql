--  Delete WHERE rseqno does not exist
--  @(#) $Id$
--  2020-06-04: Georg Fischer
--
SELECT * FROM seq4
WHERE  parm2 NOT IN (SELECT DISTINCT aseqno FROM seq4 ) 
  AND  parm2 NOT IN (SELECT          aseqno FROM joeis); -- if the superclass is not implemented

DELETE FROM seq4
WHERE  parm2 NOT IN (SELECT DISTINCT aseqno FROM seq4 ) 
  AND  parm2 NOT IN (SELECT          aseqno FROM joeis); -- if the superclass is not implemented
DELETE FROM seq4 WHERE aseqno IN('A330160', 'A191777');  -- these take too long
UPDATE seq4 SET PARM5='mSeq.next();' WHERE aseqno >= 'A327174' AND aseqno <= 'A327224'; -- Jianing Song's changes
COMMIT;
