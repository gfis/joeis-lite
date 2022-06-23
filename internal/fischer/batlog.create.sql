--  Table for joeis-lite - log of batch test results
--  @(#) $Id$
--  2022-06-20: Georg Fischer
--  A089587	80	pass	143 ms		79
--
DROP    TABLE  IF EXISTS batlog;
CREATE  TABLE            batlog
    ( aseqno   VARCHAR(10) NOT NULL  -- A322469
    , idiff    INT                   -- index of first difference
    , result   VARCHAR(16)           -- pass, FAIL, FATO, e_*
    , expected VARCHAR(256)          -- or elapsed
    , timeout  VARCHAR(32)           -- or empty
    , computed VARCHAR(256)          -- or bfimax
    , PRIMARY KEY(aseqno)
    );
COMMIT;
