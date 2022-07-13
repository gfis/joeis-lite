--  Table for OEIS - working table for sequence numbers and 8 parameter fields
--  @(#) $Id$
--  2020-04-11: callcode in key
--  2019-07-18: parm3 VARCHAR(64), was 32
--  2019-06-23: 4 parms -> 8
--  2019-06-13: Georg Fischer ,
--
DROP    TABLE  IF EXISTS suw4;
CREATE  TABLE            suw4
    ( aseqno   VARCHAR(10) NOT NULL  -- A322469
    , callcode VARCHAR(32)           -- cfsnum
    , offset1   VARCHAR(16)           -- offset1
    , parm1    VARCHAR(4096)
    , parm2    VARCHAR(1024)
    , parm3    VARCHAR(256)
    , parm4    VARCHAR(4096)
    , parm5    VARCHAR(256)
    , parm6    VARCHAR(128)
    , parm7    VARCHAR(128)
    , parm8    VARCHAR(128)
    , name     VARCHAR(1024)
    , status   VARCHAR(16)           -- pass, FAIL
    , PRIMARY KEY(aseqno, callcode)
    );
COMMIT;
