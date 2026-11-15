--  Table for OEIS - which sequences are implemented by joeis
--  @(#) $Id$
--  2026-11-13: column implements
--  2024-09-20: callcode had length 16
--  2020-11-21: callcode, author
--  2019-06-05: status
--  2019-04-05: superclass
--  2019-04-04: Georg Fischer ,
--
DROP    TABLE  IF EXISTS joeis;
CREATE  TABLE            joeis
    ( aseqno     VARCHAR(10) NOT NULL  -- A322469
    , superclass VARCHAR(64)
    , implements VARCHAR(256)  -- Conjectural DirectSequence etc.
    , status     VARCHAR(8)  -- pass, FAIL, FATAL, timeout
    , callcode   VARCHAR(32)
    , author     VARCHAR(16)
    , PRIMARY KEY(aseqno)
    );
COMMIT;
