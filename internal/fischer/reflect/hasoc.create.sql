--  Table for OEIS - working table for offset enabling: "has constructor with leading offset parameter"
--  @(#) $Id$
--  2023-07-21: 3 columns
--  2023-07-16: Georg Fischer: copied from offin.create.sql
--
DROP    TABLE  IF EXISTS hasoc;
CREATE  TABLE            hasoc
    ( superclass VARCHAR(128) NOT NULL  -- A322469
    , parmno     INT
    , parms      VARCHAR(256)
    , PRIMARY KEY(superclass)
    );
COMMIT;
