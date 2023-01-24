-- @(#) $Id$
-- Patches for holsig2
-- 2022-10-25, Georg Fischer
DELETE FROM seq4 WHERE aseqno IN
('A000000'
,'A071434' -- Sprague-Grundy
,'A071435'
,'A071451'
,'A071452'
,'A101312' -- order 400
,'A117154' -- 921 inits
,'A117597' -- linrec in formula
,'A125937' -- periodic after n=294095
,'A127376' -- calendar, period 400
,'A135358' -- a(79)=509 deviates from 510
,'A157962' -- calendar, order 1376
,'A161021' -- Collatz
,'A161022' -- Collatz
,'A161023' -- Collatz
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
);
COMMIT;
-- replace parm2 with initial data terms
-- = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){1}')
UPDATE seq4 s SET s.parm2 = (SELECT REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){' || CAST(s.parm2 - 1 AS CHAR) || '}') 
  FROM asdata d
  WHERE d.aseqno = s.aseqno
  );
COMMIT;
