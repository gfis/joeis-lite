--  Table for OEIS - working table for sequence numbers and 8 parameter fields
--  @(#) $Id$
--  2022-07-13: MariaDB 10.6 has 'offset1' as keyword
--  2022-02-17: parm1 was 8192
--  2021-01-26: parm1 was 4096
--  2020-09-23: callcode was (32)
--  2020-04-11: callcode in key
--  2019-07-18: parm3 VARCHAR(64), was 32
--  2019-06-23: 4 parms -> 8
--  2019-06-13: Georg Fischer
--
DROP    TABLE  IF EXISTS seq4;
CREATE  TABLE            seq4
    ( aseqno   VARCHAR(10) NOT NULL  -- A322469
    , callcode VARCHAR(16)           -- cfsnum
    , offset1  VARCHAR(16)           -- offset1
    , parm1    VARCHAR(16384)
    , parm2    VARCHAR(2048)
    , parm3    VARCHAR(1024)
    , parm4    VARCHAR(128 )
    , parm5    VARCHAR(1024) -- holos remark
    , parm6    VARCHAR(128)
    , parm7    VARCHAR(64)
    , parm8    VARCHAR(64)
    , name     VARCHAR(256)
--  , status   VARCHAR(16)           -- pass, FAIL
    , PRIMARY KEY(aseqno, callcode)
    );
COMMIT;
