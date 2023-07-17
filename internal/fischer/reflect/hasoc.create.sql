--  Table for OEIS - working table for offset enabling: "has isolated offset constructor"
--  @(#) $Id$
--  2023-07-16: Georg Fischer: copied from offin.create.sql
--
DROP    TABLE  IF EXISTS hasoc;
CREATE  TABLE            hasoc
    ( superclass VARCHAR(128) NOT NULL  -- A322469
    , PRIMARY KEY(superclass)
    );
COMMIT;
