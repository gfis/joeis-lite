--  sumway.query.sql - query for the OEIS wiki table generation
--  2020-08-06, Georg Fischer

    SELECT *
    FROM seqix x,
      ( SELECT aseqno AS an
          , parm1  AS pow
          , parm2  AS mult
          , parm3  AS ways
          , parm4  AS wayat
          , parm5  AS dist
          , parm6  AS nonz
        FROM seq4
      ) AS t
    WHERE ix <= 12
      AND t.ways = x.ix
    ORDER BY 1, 3,4,6,7,8,5
    ;

