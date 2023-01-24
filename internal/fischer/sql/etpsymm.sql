-- Patch for etpsymm
-- 2020-11-11, Georg Fischer
-- needs a previous
-- make seq2 LIST=$(COMMON)/../eta/ein1sk.tmp

UPDATE seq4 s4 
    SET s4.parm1 = 1
    WHERE s4.callcode IN ('etpsymm','etpadd0') 
    ;
UPDATE seq4 s4 
    SET s4.parm1 = COALESCE(
        ( SELECT s2.info 
          FROM seq2 s2 
          WHERE s4.parm5 LIKE s2.aseqno || '=%'
        ), 1)
    WHERE s4.callcode IN ('etpsymm','etpadd0') 
    ;
COMMIT;
