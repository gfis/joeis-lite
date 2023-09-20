-- patches for morfix
-- @(#) $Id$
-- 2023-09-20, Georg Fischer

-- A106641	morfix	0	1	rows	1->3443,2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}		1->{3, 4, 4, 3}, 2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}.				A four-symbol four-at-a-time substitution with an ordering change: q=0.
-- A106642	morfix	0	1	rows	1->2112,2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{1, 2, 2, 1}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}		1->{2, 1, 1, 2}, 2->q*{3, 2, 2, 3} + (1 - q)*{2, 3, 3, 2}, 3->{4, 3, 3, 4}, 4->q*{1, 4, 4, 1} + (1 - q)*{4, 1, 1, 4}.				A four-symbol four-at-a-time substitution with an ordering change: q=1.

UPDATE seq4 SET parm3 = '1->3443,2->2332,3->1221,4->4114' WHERE aseqno = 'A106641'; -- q=0
UPDATE seq4 SET parm3 = '1->3443,2->3223,3->1221,4->1441' WHERE aseqno = 'A106642'; -- q=1
COMMIT;
