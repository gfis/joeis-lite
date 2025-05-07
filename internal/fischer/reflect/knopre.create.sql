--  Table for OEIS - A-numbers with known predicate and corresponding filter lambda
--  @(#) $Id$
--  2025-05-07: Georg Fischer, copied from commn/seq2.create.sql
--
DROP    TABLE  IF EXISTS knopre;
CREATE  TABLE            knopre
    ( aseqno  VARCHAR(10) NOT NULL  -- A322469
    , lambda  VARCHAR(512)
    , PRIMARY KEY(aseqno)
    );
COMMIT;
