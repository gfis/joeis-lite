--  Table for OEIS holonomic recurrences
--  @(#) $Id$
--  2022-07-14: column names were offset, shift
--  2021-02-14, Georg Fischer; copied from seq4.create.sql
--
DROP    TABLE  IF EXISTS holref;
CREATE  TABLE            holref
    ( aseqno   VARCHAR(10) NOT NULL  -- A-number
    , callcode VARCHAR(32)           -- holos
    , offset1  INT                   -- offset1
    , matrix   VARCHAR(8192)
    , init     VARCHAR(4096)
    , dist     INT
    , gftype   INT
    , keyword  VARCHAR(128)
    , PRIMARY KEY(aseqno, callcode)
    );
COMMIT;
