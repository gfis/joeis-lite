--  Patches for CC=caelem
--  @(#) $Id$
--  2021-12-15: Georg Fischer
--
UPDATE seq4 s SET parm2  = COALESCE((SELECT superclass FROM joeis j WHERE s.aseqno = j.aseqno), 'nyi');
UPDATE seq4 s SET aseqno = 'A243566' WHERE aseqno = 'A243560';
DELETE FROM seq4 WHERE aseqno = 'A266812'; -- UPDATE seq4 s SET aseqno = 'A071046', parm1 = 62 
UPDATE seq4 s SET parm1  = 9 WHERE aseqno IN ('A266243','A266243','A266245');
UPDATE seq4 s SET aseqno = 'A267604' WHERE aseqno = 'A267404';
DELETE FROm seq4 WHERE aseqno IN
('A050187'
,'A052928'
,'A054135'
,'A054977'
,'A056830'
,'A065803'
,'A071042'
,'A074330'
,'A081253'
,'A083584'
,'A099814'
,'A103505'
,'A103517'
,'A129868'
,'A131179'
,'A133872'
,'A134451'
,'A138148'
,'A140529'
,'A141722'
,'A156760'
,'A157532'
,'A166486'
,'A171378'
,'A176059'
,'A188530'
,'A198694'
,'A211538'
,'A247375'
);
COMMIT;
SELECT * FROM seq4 WHERE parm2 <> 'nyi' AND name NOT LIKE '%iangle%' AND name NOT LIKE '%cellular automaton%' ;
DELETE   FROM seq4 WHERE parm2 <> 'nyi' AND name NOT LIKE '%iangle%' AND name NOT LIKE '%cellular automaton%' ;
