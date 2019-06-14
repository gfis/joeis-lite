--  Table for OEIS - working table for sequence numbers and 4 parameter fields
--  @(#) $Id$
--  2019-06-13: Georg Fischer ,
--
DROP    TABLE  IF EXISTS seq4;
CREATE  TABLE            seq4
    ( aseqno   VARCHAR(10) NOT NULL  -- A322469
    , callcode VARCHAR(32)           -- cfsnum
    , offset   VARCHAR(8 )           -- offset
    , parm1    VARCHAR(16)           --
    , parm2    VARCHAR(32)           
    , parm3    VARCHAR(64)           
    , parm4    VARCHAR(128)          
    , name     VARCHAR(256)  
    , status   VARCHAR(16)           -- pass, FAIL       
    , PRIMARY KEY(aseqno)
    );
COMMIT;
