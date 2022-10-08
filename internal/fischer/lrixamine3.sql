-- @(#) $Id$
-- Patches for holsig
-- 2022-09-29, Georg Fischer
DELETE FROM seq4 WHERE aseqno IN
('A000000'
,'A101312' -- order 400
,'A117154' -- 921 inits
,'A117597' -- linrec in formula
,'A125937' -- periodic after n=294095
,'A127376' -- calendar, period 400
,'A157962' -- calendar, order 1376
,'A164936' -- ~600 inits
,'A171738' -- order 55
,'A174249' -- order 324
,'A189046' -- order 105
,'A194768' -- 53986089 inits
,'A194769' -- 9108736851 inits
,'A247486' -- 6642 inits
,'A249668' -- ~2100 inits
,'A263347' -- order 97
,'A263561' -- order 97
,'A270271' -- order 65
,'A277830' -- no linrec
,'A293978' -- 9066 inits
,'A293979' -- 16180 inits
,'A293981' -- > 941 inits
,'A306245' -- reallocated
,'A309710' -- reallocated
,'A327560' -- huge
,'A327561' -- huge
,'A328550' -- reallocated
,'A333347' -- huge
,'A337240' -- 10^10 inits
,'A337241' -- 10^10 inits
,'A337398' -- >Mega inits
,'A338433' -- inits?
,'A346267' -- 	0	FATAL	construction...
,'A346321' -- 	0	FATAL	construction...
,'A346322' -- 	0	FATAL	construction...
,'A346323' -- 	0	FATAL	construction...
,'A346324' -- 	0	FATAL	construction...
,'A346325' -- 	0	FATAL	construction...
,'A350539' -- calendar, order 31, possible
,'A355873' -- 9876543210 inits
-- 2022-10-07
,'A004829' -- all n > 454
,'A004830' -- All integers except 23 and 239
,'A005783' -- ??? 1	FAIL	,3,9,23,51,103,196,348,590	computed:	,1,3,9,23,51,103,196,348
,'A008319' -- largest number not in the sequence is 892
,'A014796' -- ??? 0	FAIL	,16,100,400,3136,7056,14400,48400,81796	computed:	,0,16,100,400,3136,7056,14400,48400
,'A034493' -- 29 leading zeroes	40	FAIL	,3,26,136,514,1761,5427,15920,44178	computed:	,0,0,0,0,0,0,0,0
,'A044941' -- no linrec
,'A055649' -- incorrect linrec removed
,'A056758' -- incorrect linrec was removed
,'A094914' -- abs(linrec)
,'A109303' -- all numbers greater than 9876543210
,'A132337' -- incorrect linrec was removed
,'A166986' -- no linrec
,'A192336' -- for n >= 92
,'A277723' -- incorrect linrec was removed
,'A343078' -- a(n) = n + 1023 for n >= 33.
,'A343079' -- a(n) = n + 4095 for n >= 65.
,'A350414' -- After the first 21 terms, the sequence repeats with period 10.
);
COMMIT;
