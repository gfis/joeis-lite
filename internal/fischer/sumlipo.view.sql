--  View for sumlipo (FROM seq4)
--  @(#) $Id$
--  2020-08-05: Georg Fischer
--
CREATE VIEW sumliv AS
    SELECT aseqno
    , callcode
    , parm1 AS pow
    , parm2 AS mult
    , parm3 AS mquant
    , parm4 AS least
    , parm5 AS dist
    , parm6 AS ways
    , name
    FROM seq4;
COMMIT;
