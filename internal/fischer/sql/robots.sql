-- robots.sql
-- @(#) $Id$
-- Georg Fischer, 2023-08-10
DELETE FROM seq4 WHERE aseqno IN 
('A000000'
,'A363319' -- sorting, Kimberling
,'A364463' -- wrong diffseq
,'A364575' -- memory...

-- does not work here!

,'A364671' -- wrong diffseq
);
COMMIT;
