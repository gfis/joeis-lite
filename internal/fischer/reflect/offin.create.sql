--  Table for OEIS - working table for offset inspection
--  @(#) $Id$
--  2023-07-05: Georg Fischer: copied from seq3
--
DROP    TABLE  IF EXISTS offin;
CREATE  TABLE            offin
    ( aseqno     VARCHAR(10) NOT NULL  -- A322469
    , shift      VARCHAR(16)           -- 0 -> 1
    , superclass VARCHAR(64)           -- HolonomicRecurrence
    , PRIMARY KEY(aseqno)
    );
CREATE  INDEX  offins ON offin
    (superclass  ASC
    );
COMMIT;
