--  Table for OEIS holonomic recurrences
--  @(#) $Id$
--  2021-02-14, Georg Fischer; copied from seq4.create.sql
--
DROP    TABLE  IF EXISTS holref;
CREATE  TABLE            holref
    ( aseqno   VARCHAR(10) NOT NULL  -- A-number
    , callcode VARCHAR(32)           -- holos
    , offset1   INT                   -- offset1
    , matrix   VARCHAR(8192)
    , init     VARCHAR(4096)
    , shift    INT
    , gftype   INT
    , keyword  VARCHAR(128)
    , PRIMARY KEY(aseqno, callcode)
    );
COMMIT;
