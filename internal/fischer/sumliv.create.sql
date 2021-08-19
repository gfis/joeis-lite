--  View for sumlipo (FROM seq4), for sumlipo.witab -> Wiki tables
--  @(#) $Id$
--  2020-08-07: Georg Fischer
--
DROP   VIEW  IF EXISTS sumliv;
CREATE VIEW            sumliv AS
    SELECT aseqno
    , callcode
    , CAST(parm1 AS INT) AS pow
    , CAST(parm2 AS INT) AS mult
    , parm3              AS mquant
    , parm4              AS least
    , parm5              AS dist
    , CAST(parm6 AS INT) AS ways
    , parm7              AS wquant
    , name
    FROM seq4;
COMMIT;
