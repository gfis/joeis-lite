-- valuation.sql - Patches for ZUtils.valuation
-- @(#) $Id$
-- 2022-03-16, Georg Fischer
DELETE FROM seq4 WHERE parm1 NOT IN (SELECT aseqno FROM joeis);
DELETE FROM seq4 WHERE aseqno IN ('Annnnnn'
,'A278479'
,'A318652'
,'A329898'
,'A336930'
,'A336931'
,'A339813'
,'A339814'
,'A340680'
);
COMMIT;
