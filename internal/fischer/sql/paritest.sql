-- paritest.sql
-- 2022-06-15, Georg Fischer
UPDATE seq4 s SET 
  s.callcode = 'an'
  , s.offset1 = (SELECT bfimin  FROM bfinfo b WHERE s.aseqno = b.aseqno)
  , s.parm1  = (SELECT bfimax  FROM bfinfo b WHERE s.aseqno = b.aseqno)
  , s.parm3  = ''
  , s.parm4  = ''
  , s.parm5  = ''
  , s.parm6  = ''
  , s.parm7  = ''
  , s.parm8  = (SELECT revision FROM asinfo i WHERE s.aseqno = i.aseqno)
  , s.name   = (SELECT SUBSTR(name, 1, 64) FROM asname n WHERE s.aseqno = n.aseqno)
  ;
COMMIT;
