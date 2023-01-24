-- mult.sql - Patches for MultiplicativeSequence
-- @(#) $Id$
-- 2022-07-22, Georg Fischer 

-- skip first term and prepend with '1'
UPDATE seq4 s SET s.callcode = 'multp1' WHERE s.aseqno IN 
( 'A209198'
, 'A258260'
, 'A258998'
, 'A279912'
, 'A282254'
);
COMMIT;
