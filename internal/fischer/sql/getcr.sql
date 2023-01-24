-- getcr.sql
-- @(#) $Id$
-- 2021-08-16, Georg Fischer

SELECT s.aseqno, j.superclass FROM seq4 s, joeis j WHERE s.aseqno = j.aseqno ORDER BY 1;
