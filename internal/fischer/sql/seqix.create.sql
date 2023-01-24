--  Table with sequential numbers 1..256
--  @(#) \$Id\$
--  2020-08-06: Georg Fischer ,
--
DROP    TABLE  IF EXISTS seqix;
CREATE  TABLE            seqix
    ( ix          INT NOT NULL  -- 1,2,3, ... 256
    , PRIMARY KEY(ix)
    );
COMMIT;
