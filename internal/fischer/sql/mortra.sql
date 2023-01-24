-- mortra.sql
-- @(#) $Id$
-- 2021-09-23, Georg Fischer

-- A286925	mortra	1	A080764	0->011->00							{0->01,1->00}-transform of the Sturmian word A080764.
UPDATE seq4 set parm2 = '0->01,1->00' WHERE aseqno = 'A286925';
COMMIT;
