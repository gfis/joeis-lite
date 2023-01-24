--  Patches for CC=sectrec
--  @(#) $Id$
--  2021-12-18: Georg Fischer
--
DELETE FROm seq4 WHERE aseqno IN
('A157962'
,'A174418'
,'A287476'
);
COMMIT;
