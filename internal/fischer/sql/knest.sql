-- knest.sql
-- @(#) $Id$ 
-- 2023-03-01, Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN     (SELECT aseqno FROM seq3); -- requires previous 'make knestpark'
COMMIT;
DELETE FROM seq4 WHERE parm1  NOT IN ((SELECT aseqno FROM joeis) UNION (SELECT aseqno FROM seq4));
COMMIT;
DELETE FROM seq4 WHERE aseqno IN
('A000001'
,'A067351'
,'A092386'
,'A210679'
);
COMMIT;
UPDATE seq4 SET parm3='~~  ~~{~~  super.next();~~}~~ ~~' WHERE aseqno IN
('A000001'
,'A069060'
,'A069112'
,'A079112'
,'A137427'
,'A139477'
,'A157845'
,'A185381'
,'A219188'
,'A259368'
,'A299700'
,'A309761'
,'A327248'
,'A336857'
,'A348367'
);
COMMIT;

