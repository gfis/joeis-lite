--  Table for OEIS - which sequences are implemented by joeis
--  @(#) \$Id\$
--  2019-06-05: status
--  2019-04-05: superclass
--  2019-04-04: Georg Fischer ,
--
DROP    TABLE  IF EXISTS joeis;
CREATE  TABLE            joeis
    ( aseqno     VARCHAR(10) NOT NULL  -- A322469
    , superclass VARCHAR(64)
    , status     VARCHAR(8)  -- pass, FAIL, FATAL, timeout
    , PRIMARY KEY(aseqno)
    );
COMMIT;
